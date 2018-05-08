CREATE TABLE [dbo].[customer] (
    [customer_id]      INT           NULL,
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
    [homeowner_answer] VARCHAR (255) NULL,
    [submission_date]  DATETIME      NULL,
    [lead_status]      VARCHAR (10)  NULL,
    [lead_source]      VARCHAR (250) NULL,
    [data_source]      VARCHAR (255) NULL
);







GO
CREATE NONCLUSTERED INDEX [idx_customer_mobile_include]
    ON [dbo].[customer]([mobile] ASC)
    INCLUDE([customer_id], [first_name], [email], [submission_date]);


GO
CREATE NONCLUSTERED INDEX [idx_customer_data_source_mobile]
    ON [dbo].[customer]([data_source] ASC)
    INCLUDE([mobile]);

