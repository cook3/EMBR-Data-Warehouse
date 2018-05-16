CREATE TABLE [fuzzy].[de_dup] (
    [lead_key_in]            INT           NULL,
    [lead_key_out]           INT           NULL,
    [_score]                 REAL          NULL,
    [first_name]             VARCHAR (100) NULL,
    [mobile]                 VARCHAR (100) NULL,
    [email]                  VARCHAR (100) NULL,
    [submission_date]        DATETIME      NULL,
    [mobile_clean]           VARCHAR (100) NULL,
    [email_clean]            VARCHAR (100) NULL,
    [first_name_clean]       VARCHAR (100) NULL,
    [_Similarity_first_name] REAL          NULL,
    [_Similarity_email]      REAL          NULL,
    [lead_id]                INT           NULL
);





