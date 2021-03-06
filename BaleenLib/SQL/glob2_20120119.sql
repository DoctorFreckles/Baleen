
CREATE TABLE [dbo].[fact_small](
	[file_name] [varchar](100) NULL,
	[line_number] [bigint] NULL,
	[user_name] [varchar](50) NULL,
	[load_date] [datetime] NULL,
	[custom_index] [varchar](100) NULL,
	[data_value] [varchar](400) NULL
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
CREATE NONCLUSTERED INDEX [idx_custom_index] ON [dbo].[fact_small] 
(
	[custom_index] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [idx_data_value] ON [dbo].[fact_small] 
(
	[data_value] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [idx_file_info] ON [dbo].[fact_small] 
(
	[file_name] ASC,
	[line_number] ASC,
	[user_name] ASC,
	[load_date] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[fact_large]    Script Date: 01/19/2012 15:51:32 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[fact_large](
	[file_name] [varchar](100) NULL,
	[line_number] [bigint] NULL,
	[user_name] [varchar](50) NULL,
	[load_date] [datetime] NULL,
	[custom_index] [varchar](100) NULL,
	[data_value] [text] NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
CREATE NONCLUSTERED INDEX [idx_custom_index] ON [dbo].[fact_large] 
(
	[custom_index] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [idx_file_info] ON [dbo].[fact_large] 
(
	[file_name] ASC,
	[line_number] ASC,
	[user_name] ASC,
	[load_date] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO
/****** Object:  View [dbo].[vw_file_info]    Script Date: 01/19/2012 15:51:33 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create view [dbo].[vw_file_info]
as
select
combined.[file_name],
MIN(combined.first_line) as first_line,
min(combined.min_load_date) as min_load_date,
max(combined.max_load_date) as max_load_date,
sum(combined.total_lines) as total_lines

from
(SELECT 
	[file_name]
	,MIN(line_number) as first_line
    ,MIN([load_date]) as min_load_date
    ,MAX([load_date]) as max_load_date
	,count(*) as total_lines
FROM [fact_large]
group by [file_name]
union
SELECT 
	[file_name]
	,MIN(line_number) as first_line
    ,MIN([load_date]) as min_load_date
    ,MAX([load_date]) as max_load_date
	,count(*) as total_lines
FROM [fact_small]
group by [file_name]
) combined
group by combined.[file_name]
GO
/****** Object:  View [dbo].[vw_file_info_summary]    Script Date: 01/19/2012 15:51:33 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create view [dbo].[vw_file_info_summary]

as
SELECT     
vw_file_info.file_name, 
vw_file_info.first_line, 
vw_file_info.min_load_date, 
vw_file_info.max_load_date, 
vw_file_info.total_lines, 
coalesce(fact_small.data_value, fact_large.data_value) AS header_record
FROM         
vw_file_info 
LEFT OUTER JOIN
fact_small ON vw_file_info.file_name = fact_small.file_name 
AND vw_file_info.first_line = fact_small.line_number 
LEFT OUTER JOIN
fact_large ON vw_file_info.file_name = fact_large.file_name 
AND vw_file_info.first_line = fact_large.line_number
GO
