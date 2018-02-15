CREATE TABLE [mdm].[customer]
(
	[customer_key] [int] IDENTITY(1,1) NOT NULL,
	[customer_id] [int] NULL,
    [title] VARCHAR(10) NULL, 
    [first_name] VARCHAR(100) NULL, 
    [last_name] VARCHAR(100) NULL, 
    [address] VARCHAR(250) NULL, 
	[city] varchar(250) NULL,
    [geography_key] INT NULL, 
    [mobile] varchar(100) NULL, 
    [dob] DATE NULL, 
    [gender] VARCHAR(1) NULL, 
	[age] varchar(5) NULL,
	[email] varchar(255) NULL,
    [valid_from] DATETIME NULL, 
    [valid_to] DATETIME NULL DEFAULT NULL, 
    [active] BIT NULL
 CONSTRAINT [PK_dim_customer] PRIMARY KEY CLUSTERED 
(
	[customer_key] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
