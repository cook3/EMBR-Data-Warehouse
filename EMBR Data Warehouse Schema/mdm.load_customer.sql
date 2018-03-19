﻿
CREATE PROCEDURE  [mdm].[load_customer]

AS 

-- =============================================
-- Author:		Scott Cooke
-- Create date: 05/02/2018
-- Description:	perform load of all unique customer info
-- =============================================

BEGIN

SET NOCOUNT ON;

DECLARE @incremental_flag INT  

SET @incremental_flag = ( SELECT TOP 1 1 FROM [mdm].[customer] ) --count to check if this is the first full load. if so do straight insert/else merge changes

IF @incremental_flag = 1 --handle incremental loads

		BEGIN

				;with base_cte AS 
					(		
					SELECT  customer_id
								, title
								, first_name
								, last_name
								, address
								, city
								, [state]
								, postcode
								, mobile
								, dob
								, gender
								, age
								, email
								, submission_date
								, lead_status
								, [data_source]
								, [lead_source]
								, ROW_NUMBER() OVER (PARTITION BY first_name, mobile, email  ORDER BY submission_date asc ) AS duplicate_number
						FROM [dbo].[customer]
						WHERE LEN(mobile) > 0
							AND [data_source] = 'databowl'

									)

				MERGE [mdm].[customer] AS target
				USING (


							SELECT c.customer_id
								, c.title
								, c.first_name
								, c.last_name
								, c.[address]
								, c.city
								, c.[state]
								, c.postcode
								, c.mobile
								, c.dob
								, c.gender
								, c.age
								, c.email
								, c.submission_date
								, ISNULL( d.geography_key, -1) AS geography_key
								, s.source_key
								, ds.data_source_key
							FROM base_cte c 
								LEFT JOIN lead.dim_geography d on c.postcode = d.postcode
									AND d.[state_code] = c.[state] 
								INNER JOIN lead.dim_data_source ds ON c.[data_source] = ds.source
								INNER JOIN lead.dim_source s ON c.lead_source = s.source
							WHERE duplicate_number = 1						
					  
						) AS source 

					ON	target.[customer_id] = source.[customer_id]


				WHEN NOT MATCHED BY TARGET --insert new rows - a row exists in the source, but not in the target table
				THEN INSERT (
							  [customer_id]
							  ,[title]
							  ,[first_name]
							  ,[last_name]
							  ,[address]
							  ,[city]
							  ,[geography_key]
							  ,[data_source_key]
							  ,[source_key]
							  ,[mobile]
							  ,[dob]
							  ,[gender]
							  ,[age]
							  ,[email]
							  ,[valid_from]
							  ,[valid_to]
							  ,[active]

								)

				VALUES (   
						    source.[customer_id]
							, source.[title]
							, source.[first_name]
							, source.[last_name]
							, source.[address]
							, source.[city]
							, source.[geography_key]
							, source.[data_source_key]
							, source.[source_key]
							, source.[mobile]
							, source.[dob]
							, source.[gender]
							, source.[age]
							, source.[email]
							, source.[submission_date]
							, NULL
							, 1

						  )

				WHEN NOT MATCHED BY SOURCE 
					THEN UPDATE
						SET valid_to = GETDATE()
						, active = 0 ;
						  
				;
							  



		END

	ELSE   -- bulk load

		BEGIN 

				;WITH base_cte AS 
					(		
					
					SELECT  customer_id
								, title
								, first_name
								, last_name
								, address
								, city
								, [state]
								, postcode
								, mobile
								, dob
								, gender
								, age
								, email
								, submission_date
								, lead_status
								, [data_source]
								, [lead_source]
								, ROW_NUMBER() OVER (PARTITION BY first_name, mobile, email  ORDER BY submission_date asc ) AS duplicate_number
						FROM [dbo].[customer]
						WHERE LEN(mobile) > 0
							AND [data_source] = 'databowl'
									)

				INSERT INTO [mdm].[customer]

						(
							  [customer_id]
							  ,[title]
							  ,[first_name]
							  ,[last_name]
							  ,[address]
							  ,[city]
							  ,[geography_key]
							  ,[data_source_key]
							  ,[source_key]
							  ,[mobile]
							  ,[dob]
							  ,[gender]
							  ,[age]
							  ,[email]
							  ,[valid_from]
							  ,[valid_to]
							  ,[active]

								)

				SELECT c.customer_id
					, c.title
					, c.first_name
					, c.last_name
					, c.[address]
					, c.[city]
					, ISNULL( d.geography_key, -1) AS geography_key
					, ds.data_source_key
					, s.source_key
					, c.mobile
					, c.dob
					, c.gender
					, c.age
					, c.email
					, c.submission_date
					, NULL
					, 1
				FROM base_cte c 
					LEFT JOIN lead.dim_geography d on c.postcode = d.postcode
						AND d.[state_code] = c.[state] 
					INNER JOIN lead.dim_data_source ds ON c.[data_source] = ds.source
					INNER JOIN lead.dim_source s ON c.lead_source = s.source
				WHERE duplicate_number = 1	


	END

END

