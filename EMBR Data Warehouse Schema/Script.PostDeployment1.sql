﻿/*
Post-Deployment Script Template							
--------------------------------------------------------------------------------------
 This file contains SQL statements that will be appended to the build script.		
 Use SQLCMD syntax to include a file in the post-deployment script.			
 Example:      :r .\myfile.sql								
 Use SQLCMD syntax to reference a variable in the post-deployment script.		
 Example:      :setvar TableName MyTable							
               SELECT * FROM [$(TableName)]					
--------------------------------------------------------------------------------------
*/
:r .\time_fill.sql
:r .\dbo_dim_geography_fill.sql
:r .\dbo_data_source_load.sql

EXECUTE dbo.load_dim_date '2010-01-01', '2050-12-31'

EXECUTE dbo.load_dim_date '1900-01-01', '1900-01-01'
