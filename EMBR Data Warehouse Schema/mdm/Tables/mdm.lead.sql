﻿CREATE TABLE [mdm].[lead] (
    [lead_key]        INT           IDENTITY (1, 1) NOT NULL,
    [lead_id]         INT           NULL,
    [title]           VARCHAR (10)  NULL,
    [first_name]      VARCHAR (100) NULL,
    [last_name]       VARCHAR (100) NULL,
    [address]         VARCHAR (250) NULL,
    [city]            VARCHAR (250) NULL,
    [geography_key]   INT           NULL,
    [data_source_key] INT           NULL,
    [source_key]      INT           NULL,
    [mobile]          VARCHAR (100) NULL,
    [dob]             DATE          NULL,
    [gender]          VARCHAR (1)   NULL,
    [age]             VARCHAR (5)   NULL,
    [email]           VARCHAR (255) NULL,
    [prize]           VARCHAR (250) NULL,
    [ipaddress]       VARCHAR (100) NULL,
    [homeowner_key]   INT           NULL,
    [submission_date] DATETIME      NULL,
    [valid_from]      DATETIME      NULL,
    [valid_to]        DATETIME      DEFAULT (NULL) NULL,
    [active]          BIT           NULL,
    CONSTRAINT [PK_dim_lead] PRIMARY KEY CLUSTERED ([lead_key] ASC)
);



