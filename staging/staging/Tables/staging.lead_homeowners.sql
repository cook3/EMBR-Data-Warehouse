CREATE TABLE [staging].[lead_homeowners] (
    [lead_id]          INT            NOT NULL,
    [SubmissionDate]   VARCHAR (4000) NULL,
    [homeowner_answer] VARCHAR (4000) NULL,
    [email]            VARCHAR (250)  NULL,
    [mobile]           VARCHAR (250)  NULL,
    CONSTRAINT [pk_homeowner_lead_id] PRIMARY KEY CLUSTERED ([lead_id] ASC)
);







