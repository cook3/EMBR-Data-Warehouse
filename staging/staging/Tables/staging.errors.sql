CREATE TABLE [staging].[errors] (
    [customer_id]      INT            NULL,
    [submission_date]  DATETIME       NULL,
    [ErrorDescription] VARCHAR (5000) NULL,
    [ErrorColumn]      VARCHAR (1000) NULL
);

