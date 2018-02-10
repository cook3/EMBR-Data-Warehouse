CREATE TABLE [dbo].[dim_time](
	[time_key] [int] NOT NULL,
	[time_value] [time](0) NULL,
	[hour_24] [int] NULL,
	[hour_12] [int] NULL,
	[minutes] [int] NULL,
	[minute_value] [time](0) NULL,
	[seconds] [int] NULL,
	[am_pm] [varchar](2) NOT NULL,
	[day_time_bucket_group_key] [int] NULL,
	[day_time_bucket] [varchar](36) NULL,
 CONSTRAINT [PK_time] PRIMARY KEY CLUSTERED 
(
	[time_key] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO