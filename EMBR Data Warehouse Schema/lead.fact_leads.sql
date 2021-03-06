﻿CREATE TABLE [lead].[fact_leads] (
    [lead_id]         INT        NOT NULL,
    [affiliate_key]   INT        NULL,
    [device_key]      INT        NULL,
    [source_key]      INT        NULL,
    [status_key]      INT        NULL,
    [date_key]        INT        NULL,
    [time_key]        INT        NULL,
    [geography_key]   INT        NULL,
    [homeowner_key]   INT        NULL,
    [data_source_key] INT        NULL,
    [prize]           CHAR (255) NULL
);








GO
CREATE NONCLUSTERED INDEX [idx_leads_data_source_lead_id]
    ON [lead].[fact_leads]([data_source_key] ASC)
    INCLUDE([lead_id]);

