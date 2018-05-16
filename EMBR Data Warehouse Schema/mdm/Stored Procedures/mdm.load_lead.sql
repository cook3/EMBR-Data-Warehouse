

CREATE PROCEDURE  [mdm].[load_lead]

AS 

-- =============================================
-- Author:		Scott Cooke
-- Create date: 05/02/2018
-- Description:	perform load of all unique customer info
-- =============================================

BEGIN

SET NOCOUNT ON;

DECLARE @incremental_flag INT  

SET @incremental_flag = ( SELECT TOP 1 1 FROM [mdm].[lead] ) --count to check if this is the first full load. if so do straight insert/else merge changes

IF @incremental_flag = 1 --handle incremental loads

		BEGIN

				MERGE [mdm].[lead] AS target
				USING (


							SELECT  c.lead_id
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
										, h.homeowner_key
										, ds.data_source_key
								FROM [dbo].[lead] c
									INNER JOIN fuzzy.cleansed_list cl ON c.lead_id = cl.lead_id
									LEFT JOIN lead.dim_geography d on c.postcode = d.postcode
										AND d.[state_code] = c.[state] 
									INNER JOIN lead.dim_data_source ds ON c.[data_source] = ds.source
									INNER JOIN lead.dim_source s ON c.lead_source = s.source
									INNER JOIN lead.dim_homeowner h ON c.homeowner_answer = h.answer					
					  
						) AS source 

					ON	target.[lead_id] = source.[lead_id]


				WHEN NOT MATCHED BY TARGET --insert new rows - a row exists in the source, but not in the target table
				THEN INSERT (
							  [lead_id]
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
							  ,[homeowner_key]
							  ,[submission_date]
							  ,[valid_from]
							  ,[valid_to]
							  ,[active]

								)

				VALUES (   
						    source.[lead_id]
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
							, source.[homeowner_key]
							, source.[submission_date]
							, GETDATE()
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


			INSERT INTO [mdm].[lead]

					(
							[lead_id]
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
							,[homeowner_key]
							,[submission_date]
							,[valid_from]
							,[valid_to]
							,[active]

							)

			SELECT  c.lead_id
						, c.title
						, c.first_name
						, c.last_name
						, c.[address]
						, c.city
						, ISNULL( d.geography_key, -1) AS geography_key
						, ds.data_source_key
						, s.source_key
						, c.mobile
						, c.dob
						, c.gender
						, c.age
						, c.email
						, h.homeowner_key
						, c.submission_date
						, GETDATE()
						, NULL
						, 1
				FROM [dbo].[lead] c
					INNER JOIN fuzzy.cleansed_list cl ON c.lead_id = cl.lead_id
					LEFT JOIN lead.dim_geography d on c.postcode = d.postcode
						AND d.[state_code] = c.[state] 
					INNER JOIN lead.dim_data_source ds ON c.[data_source] = ds.source
					INNER JOIN lead.dim_source s ON c.lead_source = s.source
					INNER JOIN lead.dim_homeowner h ON c.homeowner_answer = h.answer


	END

END