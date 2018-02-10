CREATE TABLE [dbo].[customer]

(
	[customer_id] [int] NULL,
    [title] VARCHAR(10) NULL, 
    [first_name] VARCHAR(100) NULL, 
    [last_name] VARCHAR(100) NULL, 
    [address] VARCHAR(250) NULL, 
	[city] varchar(250) NULL,
	[state] varchar(250) NULL,
	[postcode] varchar(4) NULL,
    [mobile] varchar(100) NULL, 
	[email] varchar(100) NULL,
    [dob] DATE NULL, 
    [gender] VARCHAR(1) NULL, 
	[age] varchar(5) NULL,
	[submission_date] DATETIME NULL, 
    [lead_status] VARCHAR(10) NULL

)
