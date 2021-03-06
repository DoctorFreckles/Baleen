USE [master]
GO
/****** Object:  Database [dndx_npi_3]    Script Date: 03/18/2012 09:25:07 ******/
CREATE DATABASE [dndx_npi_3] ON  PRIMARY 
( NAME = N'dndx_npi_3', FILENAME = N'c:\Program Files\Microsoft SQL Server\MSSQL10_50.MSSQLSERVER\MSSQL\DATA\dndx_npi_3.mdf' , SIZE = 7460992KB , MAXSIZE = UNLIMITED, FILEGROWTH = 10%)
 LOG ON 
( NAME = N'dndx_npi_3_log', FILENAME = N'c:\Program Files\Microsoft SQL Server\MSSQL10_50.MSSQLSERVER\MSSQL\DATA\dndx_npi_3_log.ldf' , SIZE = 9930624KB , MAXSIZE = 2048GB , FILEGROWTH = 10%)
GO
ALTER DATABASE [dndx_npi_3] SET COMPATIBILITY_LEVEL = 100
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [dndx_npi_3].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [dndx_npi_3] SET ANSI_NULL_DEFAULT OFF
GO
ALTER DATABASE [dndx_npi_3] SET ANSI_NULLS OFF
GO
ALTER DATABASE [dndx_npi_3] SET ANSI_PADDING OFF
GO
ALTER DATABASE [dndx_npi_3] SET ANSI_WARNINGS OFF
GO
ALTER DATABASE [dndx_npi_3] SET ARITHABORT OFF
GO
ALTER DATABASE [dndx_npi_3] SET AUTO_CLOSE OFF
GO
ALTER DATABASE [dndx_npi_3] SET AUTO_CREATE_STATISTICS ON
GO
ALTER DATABASE [dndx_npi_3] SET AUTO_SHRINK OFF
GO
ALTER DATABASE [dndx_npi_3] SET AUTO_UPDATE_STATISTICS ON
GO
ALTER DATABASE [dndx_npi_3] SET CURSOR_CLOSE_ON_COMMIT OFF
GO
ALTER DATABASE [dndx_npi_3] SET CURSOR_DEFAULT  GLOBAL
GO
ALTER DATABASE [dndx_npi_3] SET CONCAT_NULL_YIELDS_NULL OFF
GO
ALTER DATABASE [dndx_npi_3] SET NUMERIC_ROUNDABORT OFF
GO
ALTER DATABASE [dndx_npi_3] SET QUOTED_IDENTIFIER OFF
GO
ALTER DATABASE [dndx_npi_3] SET RECURSIVE_TRIGGERS OFF
GO
ALTER DATABASE [dndx_npi_3] SET  DISABLE_BROKER
GO
ALTER DATABASE [dndx_npi_3] SET AUTO_UPDATE_STATISTICS_ASYNC OFF
GO
ALTER DATABASE [dndx_npi_3] SET DATE_CORRELATION_OPTIMIZATION OFF
GO
ALTER DATABASE [dndx_npi_3] SET TRUSTWORTHY OFF
GO
ALTER DATABASE [dndx_npi_3] SET ALLOW_SNAPSHOT_ISOLATION OFF
GO
ALTER DATABASE [dndx_npi_3] SET PARAMETERIZATION SIMPLE
GO
ALTER DATABASE [dndx_npi_3] SET READ_COMMITTED_SNAPSHOT OFF
GO
ALTER DATABASE [dndx_npi_3] SET HONOR_BROKER_PRIORITY OFF
GO
ALTER DATABASE [dndx_npi_3] SET  READ_WRITE
GO
ALTER DATABASE [dndx_npi_3] SET RECOVERY SIMPLE
GO
ALTER DATABASE [dndx_npi_3] SET  MULTI_USER
GO
ALTER DATABASE [dndx_npi_3] SET PAGE_VERIFY CHECKSUM
GO
ALTER DATABASE [dndx_npi_3] SET DB_CHAINING OFF
GO
USE [dndx_npi_3]
GO
/****** Object:  Table [dbo].[fact_npi_9]    Script Date: 03/18/2012 09:25:08 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[fact_npi_9](
	[object_id] [bigint] NULL,
	[dictionary_id] [bigint] NULL,
	[created_on] [datetime] NULL
) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [idx_created_on] ON [dbo].[fact_npi_9] 
(
	[created_on] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [idx_fact] ON [dbo].[fact_npi_9] 
(
	[object_id] ASC,
	[dictionary_id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[fact_npi_8]    Script Date: 03/18/2012 09:25:08 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[fact_npi_8](
	[object_id] [bigint] NULL,
	[dictionary_id] [bigint] NULL,
	[created_on] [datetime] NULL
) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [idx_created_on] ON [dbo].[fact_npi_8] 
(
	[created_on] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [idx_fact] ON [dbo].[fact_npi_8] 
(
	[object_id] ASC,
	[dictionary_id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[fact_npi_7]    Script Date: 03/18/2012 09:25:08 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[fact_npi_7](
	[object_id] [bigint] NULL,
	[dictionary_id] [bigint] NULL,
	[created_on] [datetime] NULL
) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [idx_created_on] ON [dbo].[fact_npi_7] 
(
	[created_on] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [idx_fact] ON [dbo].[fact_npi_7] 
(
	[object_id] ASC,
	[dictionary_id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[dict_npi_9]    Script Date: 03/18/2012 09:25:08 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[dict_npi_9](
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
 CONSTRAINT [PK_predicate_npi_9] PRIMARY KEY CLUSTERED 
(
	[dictionary_id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [idx_cardinality] ON [dbo].[dict_npi_9] 
(
	[cardinality] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [idx_double] ON [dbo].[dict_npi_9] 
(
	[as_double] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [idx_integer] ON [dbo].[dict_npi_9] 
(
	[as_integer] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [idx_pname] ON [dbo].[dict_npi_9] 
(
	[type_name] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [idx_temporal] ON [dbo].[dict_npi_9] 
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
CREATE NONCLUSTERED INDEX [idx_type_value] ON [dbo].[dict_npi_9] 
(
	[type_value] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[dict_npi_8]    Script Date: 03/18/2012 09:25:08 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[dict_npi_8](
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
 CONSTRAINT [PK_predicate_npi_8] PRIMARY KEY CLUSTERED 
(
	[dictionary_id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [idx_cardinality] ON [dbo].[dict_npi_8] 
(
	[cardinality] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [idx_double] ON [dbo].[dict_npi_8] 
(
	[as_double] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [idx_integer] ON [dbo].[dict_npi_8] 
(
	[as_integer] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [idx_pname] ON [dbo].[dict_npi_8] 
(
	[type_name] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [idx_temporal] ON [dbo].[dict_npi_8] 
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
CREATE NONCLUSTERED INDEX [idx_type_value] ON [dbo].[dict_npi_8] 
(
	[type_value] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[dict_npi_7]    Script Date: 03/18/2012 09:25:08 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[dict_npi_7](
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
 CONSTRAINT [PK_predicate_npi_7] PRIMARY KEY CLUSTERED 
(
	[dictionary_id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [idx_cardinality] ON [dbo].[dict_npi_7] 
(
	[cardinality] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [idx_double] ON [dbo].[dict_npi_7] 
(
	[as_double] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [idx_integer] ON [dbo].[dict_npi_7] 
(
	[as_integer] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [idx_pname] ON [dbo].[dict_npi_7] 
(
	[type_name] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [idx_temporal] ON [dbo].[dict_npi_7] 
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
CREATE NONCLUSTERED INDEX [idx_type_value] ON [dbo].[dict_npi_7] 
(
	[type_value] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO
