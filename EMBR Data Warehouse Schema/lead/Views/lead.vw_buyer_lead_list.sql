
CREATE VIEW [lead].[vw_buyer_lead_list]

AS

-- =============================================
-- Author:		Scott Cooke
-- Create date: 21/06/2018
-- Description:	view for buyer list
-- =============================================


SELECT [title] AS Title
      ,[first_name] AS [First Name]
      ,[last_name] AS [Last Name]
      ,[address] AS [Address]
      ,[city] AS [City]
      ,g.postcode AS [Postcode]
	  ,g.state AS [State]
      ,[mobile] AS [Mobile]
      ,[dob] AS [Date of Birth]
	  ,(Convert(Char(8), CURRENT_TIMESTAMP,112) - 0 - Convert(char(8), [dob], 112)) / 10000 As Age
      ,[gender] AS [Gender]
      ,[email] AS [Email]
      ,h.answer_group AS [Homeowner Answer]
 FROM [mdm].[lead] l
	INNER JOIN [lead].[dim_homeowner] h ON l.homeowner_key = h.homeowner_key
	INNER JOIN [lead].[dim_geography] g ON l.geography_key = g.geography_key
 WHERE active = 1