USE [master]
GO
/****** Object:  Database [dndx_ontology]    Script Date: 03/18/2012 15:10:22 ******/
CREATE DATABASE [dndx_ontology] ON  PRIMARY 
( NAME = N'dndx_ontology', FILENAME = N'c:\Program Files\Microsoft SQL Server\MSSQL10_50.MSSQLSERVER\MSSQL\DATA\dndx_ontology.mdf' , SIZE = 1508352KB , MAXSIZE = UNLIMITED, FILEGROWTH = 1024KB )
 LOG ON 
( NAME = N'dndx_ontology_log', FILENAME = N'c:\Program Files\Microsoft SQL Server\MSSQL10_50.MSSQLSERVER\MSSQL\DATA\dndx_ontology_log.ldf' , SIZE = 2876352KB , MAXSIZE = 2048GB , FILEGROWTH = 10%)
GO
ALTER DATABASE [dndx_ontology] SET COMPATIBILITY_LEVEL = 100
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [dndx_ontology].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [dndx_ontology] SET ANSI_NULL_DEFAULT OFF
GO
ALTER DATABASE [dndx_ontology] SET ANSI_NULLS OFF
GO
ALTER DATABASE [dndx_ontology] SET ANSI_PADDING OFF
GO
ALTER DATABASE [dndx_ontology] SET ANSI_WARNINGS OFF
GO
ALTER DATABASE [dndx_ontology] SET ARITHABORT OFF
GO
ALTER DATABASE [dndx_ontology] SET AUTO_CLOSE OFF
GO
ALTER DATABASE [dndx_ontology] SET AUTO_CREATE_STATISTICS ON
GO
ALTER DATABASE [dndx_ontology] SET AUTO_SHRINK OFF
GO
ALTER DATABASE [dndx_ontology] SET AUTO_UPDATE_STATISTICS ON
GO
ALTER DATABASE [dndx_ontology] SET CURSOR_CLOSE_ON_COMMIT OFF
GO
ALTER DATABASE [dndx_ontology] SET CURSOR_DEFAULT  GLOBAL
GO
ALTER DATABASE [dndx_ontology] SET CONCAT_NULL_YIELDS_NULL OFF
GO
ALTER DATABASE [dndx_ontology] SET NUMERIC_ROUNDABORT OFF
GO
ALTER DATABASE [dndx_ontology] SET QUOTED_IDENTIFIER OFF
GO
ALTER DATABASE [dndx_ontology] SET RECURSIVE_TRIGGERS OFF
GO
ALTER DATABASE [dndx_ontology] SET  DISABLE_BROKER
GO
ALTER DATABASE [dndx_ontology] SET AUTO_UPDATE_STATISTICS_ASYNC OFF
GO
ALTER DATABASE [dndx_ontology] SET DATE_CORRELATION_OPTIMIZATION OFF
GO
ALTER DATABASE [dndx_ontology] SET TRUSTWORTHY OFF
GO
ALTER DATABASE [dndx_ontology] SET ALLOW_SNAPSHOT_ISOLATION OFF
GO
ALTER DATABASE [dndx_ontology] SET PARAMETERIZATION SIMPLE
GO
ALTER DATABASE [dndx_ontology] SET READ_COMMITTED_SNAPSHOT OFF
GO
ALTER DATABASE [dndx_ontology] SET HONOR_BROKER_PRIORITY OFF
GO
ALTER DATABASE [dndx_ontology] SET  READ_WRITE
GO
ALTER DATABASE [dndx_ontology] SET RECOVERY SIMPLE
GO
ALTER DATABASE [dndx_ontology] SET  MULTI_USER
GO
ALTER DATABASE [dndx_ontology] SET PAGE_VERIFY CHECKSUM
GO
ALTER DATABASE [dndx_ontology] SET DB_CHAINING OFF
GO
USE [dndx_ontology]
GO
/****** Object:  Table [dbo].[ontology_dictionary]    Script Date: 03/18/2012 15:10:23 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ontology_dictionary](
	[database_name] [nvarchar](100) NOT NULL,
	[table_name] [nvarchar](100) NOT NULL,
	[dictionary_id] [bigint] NOT NULL,
	[type_name] [nvarchar](200) NULL,
	[type_value] [nvarchar](400) NULL,
	[cardinality] [bigint] NULL,
	[as_integer] [bigint] NULL,
	[as_double] [float] NULL,
	[as_year] [int] NULL,
	[as_month] [int] NULL,
	[as_day] [int] NULL,
	[as_hour] [int] NULL,
	[as_minute] [int] NULL,
	[as_second] [int] NULL,
	[as_millisecond] [int] NULL,
	[set_name] [nvarchar](100) NULL,
	[sub_set_name] [nvarchar](100) NULL,
 CONSTRAINT [PK_ontology_dictionary] PRIMARY KEY CLUSTERED 
(
	[database_name] ASC,
	[table_name] ASC,
	[dictionary_id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [idx_cardinality] ON [dbo].[ontology_dictionary] 
(
	[cardinality] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [idx_numeric] ON [dbo].[ontology_dictionary] 
(
	[as_integer] ASC,
	[as_double] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [idx_sets] ON [dbo].[ontology_dictionary] 
(
	[set_name] ASC,
	[sub_set_name] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [idx_temporal] ON [dbo].[ontology_dictionary] 
(
	[as_year] ASC,
	[as_month] ASC,
	[as_day] ASC,
	[as_hour] ASC,
	[as_minute] ASC,
	[as_second] ASC,
	[as_millisecond] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [idx_type_name] ON [dbo].[ontology_dictionary] 
(
	[type_name] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [idx_type_value] ON [dbo].[ontology_dictionary] 
(
	[type_value] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO
/****** Object:  View [dbo].[vw_ontology_dictionary_counts]    Script Date: 03/18/2012 15:10:24 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create view [dbo].[vw_ontology_dictionary_counts]
as
SELECT     [type_name], type_value, sum(cardinality) as Cardinality
FROM         ontology_dictionary
group by [type_name], type_value
GO
/****** Object:  View [dbo].[vw_distinct_type_sets]    Script Date: 03/18/2012 15:10:24 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create view [dbo].[vw_distinct_type_sets]
as
SELECT distinct [type_name]
      ,[set_name]
      ,[sub_set_name]
FROM [dndx_ontology].[dbo].[ontology_dictionary]
where not set_name is null
GO
/****** Object:  View [dbo].[vw_defined_sets]    Script Date: 03/18/2012 15:10:24 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create view [dbo].[vw_defined_sets]
as
SELECT [database_name]
      ,[table_name]
      ,[dictionary_id]
      ,[type_value]
      ,[set_name]
      ,[sub_set_name]
FROM [dndx_ontology].[dbo].[ontology_dictionary]
where not [set_name] is null
GO
/****** Object:  View [dbo].[vw_type_uniqueness]    Script Date: 03/18/2012 15:10:24 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[vw_type_uniqueness]
AS
SELECT     type_name, COUNT(*) AS type_cardinality
FROM         dbo.vw_ontology_dictionary_counts
GROUP BY type_name
HAVING      (COUNT(*) > 1)
GO
/****** Object:  View [dbo].[vw_type_set_uniqueness]    Script Date: 03/18/2012 15:10:24 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create view [dbo].[vw_type_set_uniqueness]
as
SELECT     vw_distinct_type_sets.type_name, vw_distinct_type_sets.set_name, vw_distinct_type_sets.sub_set_name, vw_type_uniqueness.type_cardinality
FROM         vw_distinct_type_sets INNER JOIN
vw_type_uniqueness ON vw_distinct_type_sets.type_name = vw_type_uniqueness.type_name
GO
