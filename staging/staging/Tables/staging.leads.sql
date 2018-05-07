CREATE TABLE [staging].[leads] (
    [lead_id]          INT            NOT NULL,
    [email]            VARCHAR (250)  NULL,
    [title]            VARCHAR (4000) NULL,
    [firstname]        VARCHAR (4000) NULL,
    [lastname]         VARCHAR (4000) NULL,
    [address1]         VARCHAR (4000) NULL,
    [city]             VARCHAR (4000) NULL,
    [state]            VARCHAR (4000) NULL,
    [postcode]         VARCHAR (4000) NULL,
    [mobile]           VARCHAR (4000) NULL,
    [dob]              VARCHAR (4000) NULL,
    [Gender]           VARCHAR (4000) NULL,
    [Age]              VARCHAR (4000) NULL,
    [Source]           VARCHAR (4000) NULL,
    [Prize]            VARCHAR (4000) NULL,
    [ipaddress]        VARCHAR (4000) NULL,
    [SubmissionDate]   VARCHAR (4000) NULL,
    [affiliateid]      VARCHAR (4000) NULL,
    [clickid]          VARCHAR (4000) NULL,
    [device_brand]     VARCHAR (4000) NULL,
    [user_agent]       VARCHAR (4000) NULL,
    [device_type]      VARCHAR (4000) NULL,
    [lead_status]      VARCHAR (4000) NULL,
    [lead_message]     VARCHAR (4000) NULL,
    [homeowner_answer] VARCHAR (4000) NULL,
    [data_source]      VARCHAR (255)  NULL,
    CONSTRAINT [pk_lead_id] PRIMARY KEY CLUSTERED ([lead_id] ASC)
);









GO



GO


