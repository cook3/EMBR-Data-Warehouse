CREATE TABLE [dbo].[lead] (
    [lead_id]          INT           NULL,
    [title]            VARCHAR (10)  NULL,
    [first_name]       VARCHAR (100) NULL,
    [last_name]        VARCHAR (100) NULL,
    [address]          VARCHAR (250) NULL,
    [city]             VARCHAR (250) NULL,
    [state]            VARCHAR (250) NULL,
    [postcode]         INT           NULL,
    [mobile]           VARCHAR (100) NULL,
    [email]            VARCHAR (100) NULL,
    [dob]              DATE          NULL,
    [gender]           VARCHAR (1)   NULL,
    [age]              VARCHAR (5)   NULL,
    [ipaddress]        VARCHAR (100) NULL,
    [prize]            VARCHAR (250) NULL,
    [homeowner_answer] VARCHAR (255) NULL,
    [submission_date]  DATETIME      NULL,
    [lead_status]      VARCHAR (10)  NULL,
    [lead_source]      VARCHAR (250) NULL,
    [data_source]      VARCHAR (255) NULL
);






GO
CREATE NONCLUSTERED INDEX [idx_lead_id_source]
    ON [dbo].[lead]([lead_id] ASC, [data_source] ASC);


GO
CREATE NONCLUSTERED INDEX [idx_lead_data_source_lead_id]
    ON [dbo].[lead]([data_source] ASC)
    INCLUDE([lead_id]);


GO
CREATE NONCLUSTERED INDEX [idx_lead_data_source_mobile]
    ON [dbo].[lead]([data_source] ASC)
    INCLUDE([mobile]);


GO
CREATE NONCLUSTERED INDEX [idx_lead_mobile_include]
    ON [dbo].[lead]([mobile] ASC)
    INCLUDE([lead_id], [first_name], [email], [submission_date]);


GO
CREATE NONCLUSTERED INDEX [idx_first_last_name_mobile]
    ON [dbo].[lead]([first_name] ASC, [last_name] ASC)
    INCLUDE([mobile]);

