




CREATE VIEW [lead].[vw_buyer_lead_list]

AS

-- =============================================
-- Author:		Scott Cooke
-- Create date: 21/06/2018
-- Description:	view for buyer list
-- =============================================


SELECT distinct l.[title] AS Title
      ,l.[first_name] AS [First Name]
      ,l.[last_name] AS [Last Name]
      ,l.[address] AS [Address]
      ,l.[city] AS [City]
      ,g.postcode AS [Postcode]
	  ,g.state AS [State]
      ,l.[mobile] AS [Mobile]
      ,l.[dob] AS [Date of Birth]
	  ,(Convert(Char(8), CURRENT_TIMESTAMP,112) - 0 - Convert(char(8), l.[dob], 112)) / 10000 As Age
      ,l.[gender] AS [Gender]
      ,l.[email] AS [Email]
	  ,l.submission_date AS [Submission Date]
	  ,l.lead_id AS [Lead ID]
	  ,s.source AS [Source]
	  ,l.prize AS [Prize]
	  ,l.ipaddress AS [IP Address]
      ,h.answer_group AS [Homeowner Answer]
 FROM [mdm].[lead] l
	INNER JOIN lead.dim_source s on l.source_key = s.source_key	
	INNER JOIN [lead].[dim_homeowner] h ON l.homeowner_key = h.homeowner_key
	INNER JOIN [lead].[dim_geography] g ON l.geography_key = g.geography_key
 WHERE active = 1