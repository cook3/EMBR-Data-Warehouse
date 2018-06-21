CREATE TABLE [fuzzy].[old_homeowner_answers] (
    [id]              INT           IDENTITY (1, 1) NOT NULL,
    [mobile]          VARCHAR (100) NULL,
    [homeowner_key]   INT           NULL,
    [submission_date] DATETIME      NULL,
    CONSTRAINT [pk_old_homeowner_answers] PRIMARY KEY CLUSTERED ([id] ASC)
);

