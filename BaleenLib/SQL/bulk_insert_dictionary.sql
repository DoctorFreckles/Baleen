--truncate table predicate_npi_1
--truncate table fact_npi_1

--bulk insert predicate_npi_1
--from 'C:\test\op_npi\ordered_npi\b1096dee-c4ac-4b81-b607-0db38f5243f3_1.dict'
--with
--(
--firstrow = 1
--)

--bulk insert fact_npi_1
--from 'C:\test\op_npi\ordered_npi\b1096dee-c4ac-4b81-b607-0db38f5243f3_1.fact'
--with
--(
--firstrow = 1
--)

--USE [dndra_npi_1]
--GO
--/****** Object:  Table [dbo].[fact_npi_2]    Script Date: 03/17/2012 20:57:14 ******/
--SET ANSI_NULLS ON
--GO
--SET QUOTED_IDENTIFIER ON
--GO
--CREATE TABLE [dbo].[fact_npi_2](
--	[object_id] [bigint] NULL,
--	[predicate_id] [bigint] NULL,
--	[created_on] [datetime] NULL
--) ON [PRIMARY]
--GO
--CREATE NONCLUSTERED INDEX [idx_created_on] ON [dbo].[fact_npi_2] 
--(
--	[created_on] ASC
--)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
--GO
--CREATE NONCLUSTERED INDEX [idx_fact] ON [dbo].[fact_npi_2] 
--(
--	[object_id] ASC,
--	[predicate_id] ASC
--)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
--GO
--/****** Object:  Table [dbo].[dict_npi_2]    Script Date: 03/17/2012 20:57:14 ******/
--SET ANSI_NULLS ON
--GO
--SET QUOTED_IDENTIFIER ON
--GO
--CREATE TABLE [dbo].[dict_npi_2](
--	[dictionary_id] [bigint] NOT NULL,
--	[type_name] [nvarchar](200) NULL,
--	[type_value] [ntext] NULL,
--	[cardinality] [bigint] NULL,
--	[as_integer] [bigint] NULL,
--	[as_double] [float] NULL,
--	[as_year] [int] NULL,
--	[as_month] [int] NULL,
--	[as_day] [int] NULL,
--	[as_hour] [int] NULL,
--	[as_minute] [int] NULL,
--	[as_second] [int] NULL,
--	[as_millisecond] [int] NULL,
--	[set_type] [nvarchar](200) NULL,
-- CONSTRAINT [PK_predicate_npi_2] PRIMARY KEY CLUSTERED 
--(
--	[dictionary_id] ASC
--)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
--) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
--GO
--CREATE NONCLUSTERED INDEX [idx_cardinality] ON [dbo].[dict_npi_2] 
--(
--	[cardinality] ASC
--)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
--GO
--CREATE NONCLUSTERED INDEX [idx_double] ON [dbo].[dict_npi_2] 
--(
--	[as_double] ASC
--)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
--GO
--CREATE NONCLUSTERED INDEX [idx_integer] ON [dbo].[dict_npi_2] 
--(
--	[as_integer] ASC
--)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
--GO
--CREATE NONCLUSTERED INDEX [idx_pname] ON [dbo].[dict_npi_2] 
--(
--	[type_name] ASC
--)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
--GO
--CREATE NONCLUSTERED INDEX [idx_temporal] ON [dbo].[dict_npi_2] 
--(
--	[as_year] ASC,
--	[as_month] ASC,
--	[as_day] ASC,
--	[as_hour] ASC,
--	[as_minute] ASC,
--	[as_second] ASC,
--	[as_millisecond] ASC
--)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
--GO

bulk insert dict_npi_2
from 'C:\test\op_npi\ordered_npi\b1096dee-c4ac-4b81-b607-0db38f5243f3_2.dict'
with
(
firstrow = 1
)

bulk insert fact_npi_2
from 'C:\test\op_npi\ordered_npi\b1096dee-c4ac-4b81-b607-0db38f5243f3_2.fact'
with
(
firstrow = 1
)