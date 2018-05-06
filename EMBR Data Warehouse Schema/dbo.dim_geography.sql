CREATE TABLE [dbo].[dim_geography] (
    [geography_key]         INT            NOT NULL,
    [name]                  VARCHAR (37)   NULL,
    [urban_area]            VARCHAR (28)   NULL,
    [state_code]            VARCHAR (3)    NULL,
    [state]                 VARCHAR (28)   NULL,
    [postcode]              VARCHAR (4)    NULL,
    [type]                  VARCHAR (20)   NULL,
    [latitude]              NUMERIC (8, 5) NULL,
    [longitude]             NUMERIC (8, 5) NULL,
    [elevation]             INT            NULL,
    [population]            INT            NULL,
    [area_sq_km]            NUMERIC (9, 3) NULL,
    [local_government_area] VARCHAR (44)   NULL,
    [time_zone]             VARCHAR (21)   NULL,
    PRIMARY KEY CLUSTERED ([geography_key] ASC)
);


GO