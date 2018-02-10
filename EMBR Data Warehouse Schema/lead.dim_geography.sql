CREATE TABLE [lead].[dim_geography]
(
	[geography_key] [int]  NOT NULL,
	postcode varchar(4) NULL,
	latitude numeric(8,5),
	longitude numeric(8,5),
	state_code varchar(3),
	state varchar(28),
	local_government_area varchar(44),
	time_zone varchar(21))
GO
