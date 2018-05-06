CREATE TABLE [staging].[lead_homeowners] (
    [lead_id]          INT            NOT NULL,
    [SubmissionDate]   VARCHAR (4000) NULL,
    [homeowner_answer] VARCHAR (4000) NULL,
    PRIMARY KEY CLUSTERED ([lead_id] ASC)
);



