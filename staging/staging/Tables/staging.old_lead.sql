CREATE TABLE [staging].[old_lead] (
    [id]           BIGINT         NOT NULL,
    [cid]          INT            DEFAULT ((0)) NULL,
    [ipaddr]       NVARCHAR (85)  DEFAULT ('') NULL,
    [ttl]          INT            DEFAULT ((1)) NULL,
    [ts]           DATETIME       DEFAULT ('0000-00-00 00:00:00') NULL,
    [refer]        NVARCHAR (85)  DEFAULT ('') NULL,
    [camp_id]      INT            DEFAULT ((0)) NULL,
    [valid]        TINYINT        DEFAULT ((0)) NULL,
    [email]        NVARCHAR (85)  DEFAULT ('') NULL,
    [inf_name1]    NVARCHAR (85)  DEFAULT (NULL) NULL,
    [inf_name2]    NVARCHAR (85)  DEFAULT (NULL) NULL,
    [inf_addr]     NVARCHAR (85)  DEFAULT (NULL) NULL,
    [inf_city]     NVARCHAR (85)  DEFAULT (NULL) NULL,
    [inf_zip]      NVARCHAR (85)  DEFAULT (NULL) NULL,
    [inf_state]    NVARCHAR (85)  DEFAULT (NULL) NULL,
    [inf_country]  INT            DEFAULT (NULL) NULL,
    [inf_phone]    NVARCHAR (85)  DEFAULT (NULL) NULL,
    [inf_fax]      NVARCHAR (85)  DEFAULT (NULL) NULL,
    [answers]      NVARCHAR (MAX) DEFAULT (NULL) NULL,
    [ref_category] INT            DEFAULT ((0)) NULL,
    [sold]         INT            DEFAULT ((0)) NULL,
    [status]       NVARCHAR (1)   DEFAULT ('L') NULL,
    [lcode]        NVARCHAR (MAX) DEFAULT (NULL) NULL
);




GO
CREATE NONCLUSTERED INDEX [idx_id]
    ON [staging].[old_lead]([id] ASC);

