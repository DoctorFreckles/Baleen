
/****** Object:  Table [dbo].[fact_index]    Script Date: 01/15/2012 19:09:55 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[fact_index](
	[file_name] [varchar](100) NULL,
	[line_number] [int] NULL,
	[token] [nvarchar](50) NULL
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
CREATE NONCLUSTERED INDEX [idx_value_space] ON [dbo].[fact_index] 
(
	[token] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[fact]    Script Date: 01/15/2012 19:09:55 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[fact](
	[file_name] [varchar](100) NULL,
	[line_number] [int] NULL,
	[load_datetime] [datetime] NULL,
	[user_name] [varchar](100) NULL,
	[data_value] [ntext] NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
CREATE NONCLUSTERED INDEX [idx_fact] ON [dbo].[fact] 
(
	[file_name] ASC,
	[line_number] ASC,
	[load_datetime] ASC,
	[user_name] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO
/****** Object:  View [dbo].[vw_file_stats]    Script Date: 01/15/2012 19:09:56 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create view [dbo].[vw_file_stats]

as

SELECT     file_name, 
min(load_datetime) as min_load_date, 
max(load_datetime) as max_load_date, 
min(line_number) as first_line,
COUNT(*) as line_count
FROM         fact
group by file_name
GO
/****** Object:  View [dbo].[vw_file_tokens]    Script Date: 01/15/2012 19:09:56 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create view [dbo].[vw_file_tokens]
as
SELECT     file_name, token, COUNT(*) as frequency
FROM         fact_index
group by file_name, token
GO
/****** Object:  View [dbo].[vw_file_summary]    Script Date: 01/15/2012 19:09:56 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create view [dbo].[vw_file_summary]
as
SELECT     
	vw_file_stats.file_name, 
	vw_file_stats.min_load_date, 
	vw_file_stats.max_load_date, 
	vw_file_stats.first_line, 
	vw_file_stats.line_count, 
	fact.data_value
FROM vw_file_stats INNER JOIN
fact ON vw_file_stats.first_line = fact.line_number 
AND vw_file_stats.file_name = fact.file_name
GO
/****** Object:  View [dbo].[vw_token_pareto]    Script Date: 01/15/2012 19:09:56 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create view [dbo].[vw_token_pareto]
as
SELECT [token]
      ,sum([frequency]) as frequency
FROM [blnx_crime].[dbo].[vw_file_tokens]
group by token
GO
/****** Object:  View [dbo].[vw_word_pareto]    Script Date: 01/15/2012 19:09:56 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create view [dbo].[vw_word_pareto]
as
SELECT [token]
      ,[frequency]
FROM [blnx_crime].[dbo].[vw_token_pareto]
where ISNUMERIC(token) <> 1
GO
