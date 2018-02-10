CREATE PROCEDURE [lead].[load_dim_source]

AS 

-- =============================================
-- Author:		Scott Cooke
-- Create date: 29/01/2018
-- Description:	perform load of all lead source types
-- =============================================

BEGIN

SET NOCOUNT ON;

DECLARE @incremental_flag INT  

SET @incremental_flag = ( SELECT TOP 1 1 FROM [lead].[dim_source] ) --count to check if this is the first full load. if so do straight insert/else merge changes

IF @incremental_flag = 1 --handle incremental loads

		BEGIN
				MERGE [lead].[dim_source] AS target
				USING (

						SELECT DISTINCT ISNULL([Source], 'Unknown') as Source
						FROM [$(staging)].[staging].[leads] 

						  
						) AS source 

					ON	target.[source] = source.[Source]


				WHEN NOT MATCHED BY TARGET --insert new rows - a row exists in the source, but not in the target table
				THEN INSERT (

							  [source]

								)

				VALUES (   
						    source.[Source]
						  );
							  



		END

	ELSE   -- bulk load

		BEGIN 

				INSERT INTO  [lead].[dim_source]

						(
							  [source]


								)


						SELECT DISTINCT ISNULL([Source], 'Unknown') as Source
						FROM [$(staging)].[staging].[leads] 


	END

END

