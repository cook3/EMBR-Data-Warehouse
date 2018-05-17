
CREATE PROCEDURE [lead].[load_dim_homeowner]

AS 

-- =============================================
-- Author:		Scott Cooke
-- Create date: 26/04/2018
-- Description:	perform load of all homeowner answers
-- =============================================

BEGIN

SET NOCOUNT ON;

DECLARE @incremental_flag INT  

SET @incremental_flag = ( SELECT TOP 1 1 FROM [lead].[dim_homeowner] ) --count to check if this is the first full load. if so do straight insert/else merge changes

IF @incremental_flag = 1 --handle incremental loads

		BEGIN
				MERGE [lead].[dim_homeowner] AS target
				USING (

						SELECT 'Unknown' AS [homeowner_answer], 'Unknown' AS [answer_group]


						UNION 

						SELECT DISTINCT ISNULL([homeowner_answer], 'Unknown' ) AS [homeowner_answer]
								, CASE WHEN ISNULL([homeowner_answer], 'Unknown' ) = 'Unknown' 
								 THEN 'Unknown' 
								 WHEN [homeowner_answer] IN ( 'Renting', 'Live at home')
								 THEN 'Cosponsor'
								 ELSE 'Home Owner'
								 END AS [answer_group]
						FROM [staging].[staging].[lead_homeowners] 

						  
						) AS source 

					ON	target.[answer] = source.[homeowner_answer]


				WHEN NOT MATCHED BY TARGET --insert new rows - a row exists in the source, but not in the target table
				THEN INSERT (

							  [answer]
							,  [answer_group]

								)

				VALUES (   
						    source.[homeowner_answer]
							,source.[answer_group]
						  );
							  



		END

	ELSE   -- bulk load

		BEGIN 

				INSERT INTO  [lead].[dim_homeowner]

						(
							  [answer]
							  , [answer_group]

								)


						SELECT 'Unknown' AS [homeowner_answer], 'Unknown' AS [answer_group]


						UNION 

						SELECT DISTINCT ISNULL([homeowner_answer], 'Unknown' ) AS [homeowner_answer]
								, CASE WHEN ISNULL([homeowner_answer], 'Unknown' ) = 'Unknown' 
								 THEN 'Unknown' 
								 WHEN [homeowner_answer] IN ( 'Renting', 'Live at home')
								 THEN 'Cosponsor'
								 ELSE 'Home Owner'
								 END AS [answer_group]
						FROM [staging].[staging].[lead_homeowners] 

	END

END