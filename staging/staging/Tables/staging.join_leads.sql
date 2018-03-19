CREATE TABLE [staging].[join_leads] (
    [id]           BIGINT         NOT NULL,
    [cid]          INT            NULL,
    [ipaddr]       NVARCHAR (85)  NULL,
    [ttl]          INT            NULL,
    [ts]           DATETIME       NULL,
    [refer]        NVARCHAR (85)  NULL,
    [camp_id]      INT            NULL,
    [valid]        TINYINT        NULL,
    [email]        NVARCHAR (85)  NULL,
    [inf_name1]    NVARCHAR (85)  NULL,
    [inf_name2]    NVARCHAR (85)  NULL,
    [inf_addr]     NVARCHAR (85)  NULL,
    [inf_city]     NVARCHAR (85)  NULL,
    [inf_zip]      NVARCHAR (85)  NULL,
    [inf_state]    NVARCHAR (85)  NULL,
    [inf_country]  INT            NULL,
    [inf_phone]    NVARCHAR (85)  NULL,
    [inf_fax]      NVARCHAR (85)  NULL,
    [answers]      NVARCHAR (MAX) NULL,
    [ref_category] INT            NULL,
    [sold]         INT            NULL,
    [status]       NVARCHAR (1)   NULL,
    [lcode]        NVARCHAR (MAX) NULL,
    [dbid]         INT            NULL
);


GO
CREATE NONCLUSTERED INDEX [idx_id]
    ON [staging].[join_leads]([id] ASC);

