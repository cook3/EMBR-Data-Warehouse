CREATE FUNCTION [dbo].[fn_remove_non_numeric] ( @str varchar(1000) )
RETURNS varchar(1000)
AS 
BEGIN
	WHILE PATINDEX('%[^0-9]%', @str ) > 0
	BEGIN 
		SET @str = STUFF (@str, PATINDEX('%[^0-9]%', @str), 1, '')
		END
	RETURN @str
END