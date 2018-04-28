CREATE PROCEDURE [lead].[load_dim_geography]

AS 

-- =============================================
-- Author:		Scott Cooke
-- Create date: 10/02/2018
-- Description:	perform load of all lead geography values.  As we don't have cleansed suburb names via a lead, and taking into account a postcode can be used across
-- multiple suburbs the base query removes the suburb name dedups via postcode and the size of the suburb. this ensures we can join to a custoer without duplicating values 
-- =============================================

BEGIN

SET NOCOUNT ON;

DECLARE @incremental_flag INT  

SET @incremental_flag = ( SELECT TOP 1 1 FROM [lead].[dim_geography] ) --count to check if this is the first full load. if so do straight insert/else merge changes

IF @incremental_flag = 1 --handle incremental loads

		BEGIN

		;with lead_geo AS (

						SELECT -1 AS [geography_key]
								, '0' AS postcode
								, 'unknown' AS [local_government_area]
								, 'unk' AS [state_code]
								, 'unknown' AS [state]
								, NULL AS [latitude]
								, NULL AS [longitude]
								, 1 AS duplicate_number
								, '' AS [time_zone]

						UNION

						SELECT [geography_key]
								,[postcode]
								,[local_government_area]
								,[state_code]
								,[state]
							   ,[latitude]
							   ,[longitude]
 							   ,ROW_NUMBER() OVER (PARTITION BY postcode, state_code ORDER BY [area_sq_km] desc ) AS duplicate_number
							   ,[time_zone]
						FROM [dbo].[dim_geography]

						)

				MERGE [lead].[dim_geography] AS target
				USING (


						SELECT [geography_key]
							 ,[postcode]
							,[local_government_area]
							,[state_code]
							,[state]
							,[latitude]
							,[longitude]
							,[time_zone]
						FROM lead_geo
						WHERE duplicate_number = 1


						  
						) AS source 

					ON	target.[geography_key] = source.[geography_key]


				WHEN NOT MATCHED BY TARGET --insert new rows - a row exists in the source, but not in the target table
				THEN INSERT (

							  [geography_key]
							,[postcode]
							,[local_government_area]
							,[state_code]
							,[state]
							,[latitude]
							,[longitude]
							,[time_zone]

								)

				VALUES (   
						    source.[geography_key]
							, source.[postcode]
							, source.[local_government_area]
							, source.[state_code]
							, source.[state]
							, source.[latitude]
							, source.[longitude]
							, source.[time_zone]



						  );
							  



		END

	ELSE   -- bulk load

		BEGIN 

		 ;WITH lead_geo AS (

		 				SELECT -1 AS [geography_key]
								, '0' AS postcode
								, 'unknown' AS [local_government_area]
								, 'unk' AS [state_code]
								, 'unknown' AS [state]
								, NULL AS [latitude]
								, NULL AS [longitude]
								, 1 AS duplicate_number
								, '' AS [time_zone]

						UNION

						SELECT [geography_key]
								,[postcode]
								,[local_government_area]
								,[state_code]
								,[state]
							   ,[latitude]
							   ,[longitude]
 							   ,ROW_NUMBER() OVER (PARTITION BY postcode, state_code ORDER BY [area_sq_km] desc ) AS duplicate_number
							   ,[time_zone]
						FROM [dbo].[dim_geography]

						)


			INSERT INTO  [lead].[dim_geography]

						(
							  [geography_key]
							,[postcode]
							,[local_government_area]
							,[state_code]
							,[state]
							,[latitude]
							,[longitude]
							,[time_zone]
								)



						SELECT [geography_key]
							 ,[postcode]
							,[local_government_area]
							,[state_code]
							,[state]
							,[latitude]
							,[longitude]
							,[time_zone]
						FROM lead_geo
						WHERE duplicate_number = 1


	END

END