
CREATE TABLE [dbo].[fact](
	[file_name] [varchar](100) NULL,
	[line_number] [bigint] NULL,
	[sequence_number] [bigint] NULL,
	[token_0] [varchar](30) NULL,
	[token_1] [varchar](30) NULL,
	[token_2] [varchar](30) NULL,
	[token_3] [varchar](30) NULL,
	[token_4] [varchar](30) NULL,
	[token_5] [varchar](30) NULL,
	[token_6] [varchar](30) NULL,
	[token_7] [varchar](30) NULL,
	[token_8] [varchar](30) NULL,
	[token_9] [varchar](30) NULL,
	[token_10] [varchar](30) NULL,
	[token_11] [varchar](30) NULL,
	[token_12] [varchar](30) NULL,
	[token_13] [varchar](30) NULL,
	[token_14] [varchar](30) NULL,
	[token_15] [varchar](30) NULL,
	[token_16] [varchar](30) NULL,
	[token_17] [varchar](30) NULL,
	[token_18] [varchar](30) NULL,
	[token_19] [varchar](30) NULL,
	[user_key] [varchar](100) NULL,
	[created_on] [datetime] NULL
) ON [PRIMARY]

CREATE NONCLUSTERED INDEX [idx_file_line] ON [dbo].[fact] 
(
	[file_name] ASC,
	[line_number] ASC,
	[user_key] ASC,
	[created_on] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]

CREATE NONCLUSTERED INDEX [idx_token_0_9] ON [dbo].[fact] 
(
	[token_0] ASC,
	[token_1] ASC,
	[token_2] ASC,
	[token_3] ASC,
	[token_4] ASC,
	[token_5] ASC,
	[token_6] ASC,
	[token_7] ASC,
	[token_8] ASC,
	[token_9] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]

CREATE NONCLUSTERED INDEX [idx_token_10_19] ON [dbo].[fact] 
(
	[token_10] ASC,
	[token_11] ASC,
	[token_12] ASC,
	[token_13] ASC,
	[token_14] ASC,
	[token_15] ASC,
	[token_16] ASC,
	[token_17] ASC,
	[token_18] ASC,
	[token_19] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]

create view [dbo].[vw_common_index]
as
SELECT distinct     file_name, line_number, token_0 as token
FROM         dbo.fact
union
SELECT distinct    file_name, line_number, token_1 as token
FROM         dbo.fact
union
SELECT  distinct   file_name, line_number, token_2 as token
FROM         dbo.fact
union
SELECT  distinct   file_name, line_number,  token_3 as token
FROM         dbo.fact
union
SELECT  distinct   file_name, line_number,  token_4 as token
FROM         dbo.fact
union
SELECT  distinct   file_name, line_number,  token_5 as token
FROM         dbo.fact
union
SELECT  distinct   file_name, line_number,  token_6 as token
FROM         dbo.fact
union
SELECT  distinct   file_name, line_number,  token_7 as token
FROM         dbo.fact
union
SELECT  distinct   file_name, line_number,  token_8 as token
FROM         dbo.fact
union
SELECT  distinct   file_name, line_number, token_9 as token
FROM         dbo.fact
union
SELECT distinct     file_name, line_number, token_10 as token
FROM         dbo.fact
union
SELECT distinct    file_name, line_number, token_11 as token
FROM         dbo.fact
union
SELECT  distinct   file_name, line_number, token_12 as token
FROM         dbo.fact
union
SELECT  distinct   file_name, line_number,  token_13 as token
FROM         dbo.fact
union
SELECT  distinct   file_name, line_number,  token_14 as token
FROM         dbo.fact
union
SELECT  distinct   file_name, line_number,  token_15 as token
FROM         dbo.fact
union
SELECT  distinct   file_name, line_number,  token_16 as token
FROM         dbo.fact
union
SELECT  distinct   file_name, line_number,  token_17 as token
FROM         dbo.fact
union
SELECT  distinct   file_name, line_number,  token_18 as token
FROM         dbo.fact
union
SELECT  distinct   file_name, line_number, token_19 as token
FROM         dbo.fact

create view [dbo].[vw_available_files]
as
SELECT     file_name, MIN(line_number) as first_line, 
MAX(line_number) as last_line
FROM         fact
group by FILE_NAME

