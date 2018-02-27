﻿CREATE TABLE [staging].[old_lead] (
    [id]           BIGINT       NOT NULL,
    [cid]          INT          DEFAULT ((0)) NULL,
    [ipaddr]       VARCHAR (85) DEFAULT ('') NULL,
    [ttl]          INT          DEFAULT ((1)) NULL,
    [ts]           DATETIME     DEFAULT ('0000-00-00 00:00:00') NULL,
    [refer]        VARCHAR (85) DEFAULT ('') NULL,
    [camp_id]      INT          DEFAULT ((0)) NULL,
    [valid]        TINYINT      DEFAULT ((0)) NULL,
    [email]        VARCHAR (85) DEFAULT ('') NULL,
    [inf_name1]    VARCHAR (85) DEFAULT (NULL) NULL,
    [inf_name2]    VARCHAR (85) DEFAULT (NULL) NULL,
    [inf_addr]     VARCHAR (85) DEFAULT (NULL) NULL,
    [inf_city]     VARCHAR (85) DEFAULT (NULL) NULL,
    [inf_zip]      VARCHAR (85) DEFAULT (NULL) NULL,
    [inf_state]    VARCHAR (85) DEFAULT (NULL) NULL,
    [inf_country]  INT          DEFAULT (NULL) NULL,
    [inf_phone]    VARCHAR (85) DEFAULT (NULL) NULL,
    [inf_fax]      VARCHAR (85) DEFAULT (NULL) NULL,
    [answers]      TEXT         DEFAULT (NULL) NULL,
    [ref_category] INT          DEFAULT ((0)) NULL,
    [sold]         INT          DEFAULT ((0)) NULL,
    [status]       CHAR (1)     DEFAULT ('L') NULL,
    [lcode]        TEXT         DEFAULT (NULL) NULL
);
