CREATE TABLE [dbo].[dim_geography]
(
	[geography_key] [int] IDENTITY(1,1) NOT NULL,
	name varchar(37),
	urban_area varchar(28),
	state_code varchar(3),
	state varchar(28),
	postcode varchar(4),
	type varchar(20),
	latitude numeric(8,5),
	longitude numeric(8,5),
	elevation int,
	population int,
	area_sq_km numeric(9,3),
	local_government_area varchar(44),
	time_zone varchar(21),
 CONSTRAINT [PK_geography] PRIMARY KEY CLUSTERED 
(
	[geography_key] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO