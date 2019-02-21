





CREATE VIEW [lead].[vw_acitve_leads]

AS

-- =============================================
-- Author:		Scott Cooke
-- Create date: 20/02/2019
-- Description:	view for all leads report
-- =============================================


 SELECT [lead_id]
      ,[title]
      ,[first_name] AS [First Name]
      ,[last_name] AS [Last Name]
      ,[address] AS [Address]
      ,[city] AS [City]
      ,[geography_key]
      ,[data_source_key]
      ,[source_key]
      ,[mobile] AS [Mobile]
	  ,(Convert(Char(8), CURRENT_TIMESTAMP,112) - 0 - Convert(char(8), [dob], 112)) / 10000 As Age
	  ,[dob] AS DOB
      ,[gender] AS [Gender]
      ,[email] AS [Email]
      ,prize AS [Prize]
	  ,ipaddress AS [IP Address]
      ,[homeowner_key]
      ,[submission_date] AS [Submission Date]
FROM [mdm].[lead]
WHERE active = 1