CREATE TABLE [dbo].[values_custom_fields] (
    [id_values_custom_fields] INT           NOT NULL,
    [ref_custom_fields]       INT           DEFAULT ((0)) NULL,
    [value_fields]            VARCHAR (300) DEFAULT (NULL) NULL,
    [cid]                     INT           DEFAULT ((0)) NULL,
    [ref_category]            INT           DEFAULT ((0)) NULL,
    [camp_ans_fields]         VARCHAR (400) DEFAULT (NULL) NULL
);

