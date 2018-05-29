

CREATE PROCEDURE [dbo].[email_errors]


AS 


-- =============================================
-- Author:		Scott Cooke
-- Create date: 29/05/2018
-- Description:	email errors
-- =============================================


DECLARE @xml NVARCHAR(MAX)
DECLARE @body NVARCHAR(MAX)


SET @xml = CAST(( SELECT [lead_Id] AS 'td','',[submission_date] AS 'td','',[load_date] AS 'td','',ErrorDescription AS 'td','', ErrorColumn AS 'td'
FROM staging.errors ORDER BY load_date 
FOR XML PATH('tr'), ELEMENTS ) AS NVARCHAR(MAX))


SET @body ='<html><body><H3>Error List</H3>
<table border = 1> 
<tr>
<th> Lead ID </th> <th> Submission Date </th> <th> Load Date </th> <th> ErrorDescription </th> <th> ErrorColumn </th> </tr>'    


SET @body = @body + @xml +'</table></body></html>'


EXEC msdb.dbo.sp_send_dbmail
@profile_name = 'Email Account', 
@body = @body,
@body_format ='HTML',
@recipients = 'hello@embr.com.au', 
@subject = 'List of lead load errors' ;