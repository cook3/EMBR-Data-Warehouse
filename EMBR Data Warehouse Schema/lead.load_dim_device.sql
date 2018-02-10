
CREATE PROCEDURE [lead].[load_dim_device]

AS 

-- =============================================
-- Author:		Scott Cooke
-- Create date: 29/01/2018
-- Description:	perform load of all lead device types
-- =============================================

BEGIN

SET NOCOUNT ON;

DECLARE @incremental_flag INT  

SET @incremental_flag = ( SELECT TOP 1 1 FROM [lead].[dim_device] ) --count to check if this is the first full load. if so do straight insert/else merge changes

IF @incremental_flag = 1 --handle incremental loads

		BEGIN
				MERGE [lead].[dim_device] AS target
				USING (

						SELECT DISTINCT ISNULL( device_type ,'UNKNOWN') AS device_type, ISNULL( device_brand, 'Unknown' ) as device_brand
						FROM [$(staging)].[staging].[leads]

						  
						) AS source 

					ON	target.[device_type] = source.[device_type]
						AND target.[device_brand] = source.[device_brand]


				WHEN NOT MATCHED BY TARGET --insert new rows - a row exists in the source, but not in the target table
				THEN INSERT (

							  [device_type]
							  , [device_brand]

								)

				VALUES (   
						    source.[device_type]
							, source.[device_brand]
						  );
							  



		END

	ELSE   -- bulk load

		BEGIN 

				INSERT INTO  [lead].[dim_device]

						(
							  [device_type]
							  , [device_brand]


								)


				SELECT DISTINCT ISNULL( device_type ,'UNKNOWN') AS device_type, ISNULL( device_brand, 'Unknown' ) as device_brand
				FROM [$(staging)].[staging].[leads]

	END

END
