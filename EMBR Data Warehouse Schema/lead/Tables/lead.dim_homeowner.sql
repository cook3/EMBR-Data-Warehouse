CREATE TABLE [lead].[dim_homeowner] (
    [homeowner_key] INT           IDENTITY (1, 1) NOT NULL,
    [answer]        VARCHAR (250) NULL,
    [answer_group]  VARCHAR (250) NULL,
    CONSTRAINT [PK_homeowner] PRIMARY KEY CLUSTERED ([homeowner_key] ASC)
);



