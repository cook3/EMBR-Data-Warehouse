CREATE TABLE [fuzzy].[de_dup] (
    [customer_key_in]        INT           NULL,
    [customer_key_out]       INT           NULL,
    [_score]                 REAL          NULL,
    [first_name]             VARCHAR (100) NULL,
    [mobile]                 VARCHAR (100) NULL,
    [email]                  VARCHAR (100) NULL,
    [customer_id]            INT           NOT NULL,
    [submission_date]        DATETIME      NULL,
    [mobile_clean]           VARCHAR (100) NULL,
    [email_clean]            VARCHAR (100) NULL,
    [first_name_clean]       VARCHAR (100) NULL,
    [_Similarity_first_name] REAL          NULL
);

