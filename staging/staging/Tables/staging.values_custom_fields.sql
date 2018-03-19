CREATE TABLE [staging].[values_custom_fields] (
    [id_values_custom_fields] INT            NOT NULL,
    [ref_custom_fields]       INT            DEFAULT ((0)) NULL,
    [value_fields]            NVARCHAR (300) DEFAULT (NULL) NULL,
    [cid]                     INT            DEFAULT ((0)) NULL,
    [ref_category]            INT            DEFAULT ((0)) NULL,
    [camp_ans_fields]         NVARCHAR (300) DEFAULT (NULL) NULL,
    [dbid]                    INT            NULL
);






GO
CREATE NONCLUSTERED INDEX [idx_cid_include]
    ON [staging].[values_custom_fields]([cid] ASC)
    INCLUDE([ref_custom_fields], [value_fields], [dbid]);



