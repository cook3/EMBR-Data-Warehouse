





CREATE VIEW [buyer].[vw_buyer_lead_list]

AS

-- =============================================
-- Author:		Scott Cooke
-- Create date: 24/02/2019
-- Description:	view for buyer list
-- =============================================
--SELECT 'T' AS  [Title]
--      ,'Test' AS [First Name]
--      ,'Test' AS [Last Name]
--      ,'' AS [Address]
--      ,'' AS [City]
--      ,'-1' AS [Postcode]
--      ,'Test' AS [State]
--      ,'' AS [Mobile]
--      ,'1900-01-01' AS [Date of Birth]
--      ,0 AS [Age]
--      ,'M' AS [Gender]
--      ,'' AS [Email]
--      ,'Unknown' AS [Homeowner Answer]
--      ,'' AS [Source]
--      ,'' AS [IP Address]
--      ,'1970-01-01' AS [Submission Date]
--      ,-1 AS [Lead ID]
--FROM [buyer].[buyer_list]

--UNION

SELECT  [Title]
      ,[First Name]
      ,[Last Name]
      ,[Address]
      ,[City]
      ,[Postcode]
      ,[State]
      ,[Mobile]
      ,[Date of Birth]
	  ,(Convert(Char(8), CURRENT_TIMESTAMP,112) - 0 - Convert(char(8), [Date of Birth], 112)) / 10000 As Age
      ,[Gender]
      ,[Email]
      ,[Homeowner Answer]
      ,[Source]
      ,[IP Address]
      ,CAST(FORMAT([Submission Date], 'yyyy-MM-dd', 'en-AU' ) AS varchar(200)) AS [Submission Date]
      ,CAST([Lead ID] AS varchar(500)) AS [Lead ID]
FROM [buyer].[buyer_list]