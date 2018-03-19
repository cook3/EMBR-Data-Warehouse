CREATE TABLE [lead].[dim_data_source] (
    [data_source_key] INT           IDENTITY (1, 1) NOT NULL,
    [source]          VARCHAR (255) NULL,
    CONSTRAINT [data_source_key] PRIMARY KEY CLUSTERED ([data_source_key] ASC)
);

