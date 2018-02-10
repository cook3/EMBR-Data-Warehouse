
CREATE PROCEDURE [lead].[load_dim_status]


-- =============================================
-- Author:		Scott Cooke
-- Create date: 26/01/2018
-- Description:	perform load of all lead status
-- =============================================


AS 

BEGIN

SET NOCOUNT ON;

DECLARE @incremental_flag INT  

SET @incremental_flag = ( SELECT TOP 1 1 FROM [lead].[dim_status] ) --count to check if this is the first full load. if so do straight insert/else merge changes

IF @incremental_flag = 1 --handle incremental loads

		BEGIN
				MERGE [lead].[dim_status] AS target
				USING (

						SELECT DISTINCT [lead_status], [lead_message]
						FROM [$(staging)].staging.leads

						  
						) AS source 

					ON	target.[status] = source.[lead_status]
						AND target.[message] = source.[lead_message]


				WHEN NOT MATCHED BY TARGET --insert new rows - a row exists in the source, but not in the target table
				THEN INSERT (

							  [status]
							  ,[message]

								)

				VALUES (   
						    source.[lead_status]
							,source.[lead_message]
						  );
							  



		END

	ELSE   -- bulk load

		BEGIN 

				INSERT INTO  [lead].[dim_status]

						(
							  [status]
							  ,[message]

								)


						SELECT DISTINCT [lead_status], [lead_message]
						FROM [$(staging)].staging.leads

	END

END

