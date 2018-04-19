

CREATE PROCEDURE [lead].[load_dim_affiliate_old_leads]

AS 

-- =============================================
-- Author:		Scott Cooke
-- Create date: 29/01/2018
-- Description:	perform load of all lead affiliate ids from old leads
-- =============================================

BEGIN

SET NOCOUNT ON;

DECLARE @incremental_flag INT  

SET @incremental_flag = ( SELECT TOP 1 1 FROM [lead].[dim_affiliate] ) --count to check if this is the first full load. if so do straight insert/else merge changes

IF @incremental_flag = 1 --handle incremental loads

		BEGIN
				MERGE [lead].[dim_affiliate] AS target
				USING (

						SELECT DISTINCT affiliateid
						FROM [staging].[staging].[leads_old] 

						  
						) AS source 

					ON	target.[affiliate_id] = source.[affiliateid]


				WHEN NOT MATCHED BY TARGET --insert new rows - a row exists in the source, but not in the target table
				THEN INSERT (

							  [affiliate_id]

								)

				VALUES (   
						    source.[affiliateid]
						  );
							  



		END

	ELSE   -- bulk load

		BEGIN 

				INSERT INTO  [lead].[dim_affiliate]

						(
							  [affiliate_id]


								)


				SELECT DISTINCT affiliateid
				FROM [staging].[staging].[leads_old] 

	END

END