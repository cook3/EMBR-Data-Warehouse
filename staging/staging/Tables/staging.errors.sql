CREATE TABLE [staging].[errors] (
    [lead_id]          INT            NULL,
    [submission_date]  DATETIME       NULL,
    [load_date]        DATETIME       DEFAULT (getdate()) NULL,
    [ErrorDescription] VARCHAR (5000) NULL,
    [ErrorColumn]      VARCHAR (1000) NULL
);





