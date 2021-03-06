﻿CREATE TABLE [staging].[leads_old] (
    [lead_id]     BIGINT         NULL,
    [ipaddr]      NVARCHAR (85)  NULL,
    [ttl]         INT            NULL,
    [ts]          DATETIME       NULL,
    [refer]       NVARCHAR (85)  NULL,
    [camp_id]     INT            NULL,
    [valid]       TINYINT        NULL,
    [email]       NVARCHAR (85)  NULL,
    [firstname]   NVARCHAR (85)  NULL,
    [lastname]    NVARCHAR (85)  NULL,
    [address1]    NVARCHAR (85)  NULL,
    [city]        NVARCHAR (85)  NULL,
    [postcode]    NVARCHAR (85)  NULL,
    [state]       NVARCHAR (85)  NULL,
    [country]     INT            NULL,
    [fax]         NVARCHAR (85)  NULL,
    [phone]       NVARCHAR (85)  NULL,
    [answers]     NVARCHAR (MAX) NULL,
    [sold]        INT            NULL,
    [ipaddress]   NVARCHAR (300) NULL,
    [sex]         NVARCHAR (300) NULL,
    [created]     NVARCHAR (300) NULL,
    [dob]         NVARCHAR (300) NULL,
    [source]      NVARCHAR (300) NULL,
    [prize]       NVARCHAR (300) NULL,
    [affiliateid] NVARCHAR (300) NULL,
    [title]       NVARCHAR (300) NULL,
    [id]          NVARCHAR (300) NULL,
    [status]      NVARCHAR (1)   NULL,
    [data_source] VARCHAR (255)  NULL
);





