CREATE TABLE [dbo].[dim_geography]
(
	[geography_key] [int]  NOT NULL,
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
	time_zone varchar(21)
) ON [PRIMARY]
GO