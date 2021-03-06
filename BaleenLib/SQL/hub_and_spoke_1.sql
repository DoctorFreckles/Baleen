USE [master]
GO
/****** Object:  Database [hns_medical_billing]    Script Date: 02/12/2012 17:20:44 ******/
CREATE DATABASE [hns_medical_billing] ON  PRIMARY 
( NAME = N'hns_medical_billing', FILENAME = N'o:\dbfiles\hns_medical_billing.mdf' , SIZE = 1945600KB , MAXSIZE = UNLIMITED, FILEGROWTH = 20%)
 LOG ON 
( NAME = N'hns_medical_billing_log', FILENAME = N'o:\dbfiles\hns_medical_billing_log.ldf' , SIZE = 16576KB , MAXSIZE = 2048GB , FILEGROWTH = 10%)
GO
ALTER DATABASE [hns_medical_billing] SET COMPATIBILITY_LEVEL = 100
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [hns_medical_billing].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [hns_medical_billing] SET ANSI_NULL_DEFAULT OFF
GO
ALTER DATABASE [hns_medical_billing] SET ANSI_NULLS OFF
GO
ALTER DATABASE [hns_medical_billing] SET ANSI_PADDING OFF
GO
ALTER DATABASE [hns_medical_billing] SET ANSI_WARNINGS OFF
GO
ALTER DATABASE [hns_medical_billing] SET ARITHABORT OFF
GO
ALTER DATABASE [hns_medical_billing] SET AUTO_CLOSE ON
GO
ALTER DATABASE [hns_medical_billing] SET AUTO_CREATE_STATISTICS ON
GO
ALTER DATABASE [hns_medical_billing] SET AUTO_SHRINK OFF
GO
ALTER DATABASE [hns_medical_billing] SET AUTO_UPDATE_STATISTICS ON
GO
ALTER DATABASE [hns_medical_billing] SET CURSOR_CLOSE_ON_COMMIT OFF
GO
ALTER DATABASE [hns_medical_billing] SET CURSOR_DEFAULT  GLOBAL
GO
ALTER DATABASE [hns_medical_billing] SET CONCAT_NULL_YIELDS_NULL OFF
GO
ALTER DATABASE [hns_medical_billing] SET NUMERIC_ROUNDABORT OFF
GO
ALTER DATABASE [hns_medical_billing] SET QUOTED_IDENTIFIER OFF
GO
ALTER DATABASE [hns_medical_billing] SET RECURSIVE_TRIGGERS OFF
GO
ALTER DATABASE [hns_medical_billing] SET  DISABLE_BROKER
GO
ALTER DATABASE [hns_medical_billing] SET AUTO_UPDATE_STATISTICS_ASYNC OFF
GO
ALTER DATABASE [hns_medical_billing] SET DATE_CORRELATION_OPTIMIZATION OFF
GO
ALTER DATABASE [hns_medical_billing] SET TRUSTWORTHY OFF
GO
ALTER DATABASE [hns_medical_billing] SET ALLOW_SNAPSHOT_ISOLATION OFF
GO
ALTER DATABASE [hns_medical_billing] SET PARAMETERIZATION SIMPLE
GO
ALTER DATABASE [hns_medical_billing] SET READ_COMMITTED_SNAPSHOT OFF
GO
ALTER DATABASE [hns_medical_billing] SET HONOR_BROKER_PRIORITY OFF
GO
ALTER DATABASE [hns_medical_billing] SET  READ_WRITE
GO
ALTER DATABASE [hns_medical_billing] SET RECOVERY SIMPLE
GO
ALTER DATABASE [hns_medical_billing] SET  MULTI_USER
GO
ALTER DATABASE [hns_medical_billing] SET PAGE_VERIFY CHECKSUM
GO
ALTER DATABASE [hns_medical_billing] SET DB_CHAINING OFF
GO
USE [hns_medical_billing]
GO
/****** Object:  Table [dbo].[fact]    Script Date: 02/12/2012 17:20:46 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[fact](
	[object_key] [bigint] NULL,
	[field_key] [bigint] NULL,
	[value_key] [bigint] NULL,
	[created_on] [datetime] NULL
) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [idx_created_on] ON [dbo].[fact] 
(
	[created_on] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [idx_field] ON [dbo].[fact] 
(
	[field_key] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [idx_object] ON [dbo].[fact] 
(
	[object_key] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [idx_value] ON [dbo].[fact] 
(
	[value_key] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[dim_text_small]    Script Date: 02/12/2012 17:20:46 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[dim_text_small](
	[dim_id] [bigint] IDENTITY(1,1) NOT NULL,
	[dim_value] [nvarchar](350) NULL,
 CONSTRAINT [PK_dim_small_text] PRIMARY KEY CLUSTERED 
(
	[dim_id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [idx_text_small] ON [dbo].[dim_text_small] 
(
	[dim_value] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[dim_text_large]    Script Date: 02/12/2012 17:20:46 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[dim_text_large](
	[dim_id] [bigint] NOT NULL,
	[dim_value] [ntext] NULL,
 CONSTRAINT [PK_dim_large_text] PRIMARY KEY CLUSTERED 
(
	[dim_id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[dim_integer]    Script Date: 02/12/2012 17:20:46 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[dim_integer](
	[dim_id] [bigint] NOT NULL,
	[dim_value] [bigint] NULL,
 CONSTRAINT [PK_dim_integer] PRIMARY KEY CLUSTERED 
(
	[dim_id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [idx_integer] ON [dbo].[dim_integer] 
(
	[dim_value] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[dim_float]    Script Date: 02/12/2012 17:20:46 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[dim_float](
	[dim_id] [bigint] NOT NULL,
	[dim_value] [float] NULL,
 CONSTRAINT [PK_dim_float] PRIMARY KEY CLUSTERED 
(
	[dim_id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [idx_float] ON [dbo].[dim_float] 
(
	[dim_value] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[dim_datetime]    Script Date: 02/12/2012 17:20:46 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[dim_datetime](
	[dim_id] [bigint] NOT NULL,
	[dim_value] [datetime] NULL,
 CONSTRAINT [PK_dim_datetime] PRIMARY KEY CLUSTERED 
(
	[dim_id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [idx_datetime] ON [dbo].[dim_datetime] 
(
	[dim_value] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO
/****** Object:  View [dbo].[vw_objects]    Script Date: 02/12/2012 17:20:46 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create view [dbo].[vw_objects]
as
SELECT  
	dim_text_small.dim_id, 
	dim_text_small.dim_value as 'Object Name',
	COUNT(*) as 'Object Count'
FROM         fact INNER JOIN
                      dim_text_small AS dim_text_small_1 ON fact.field_key = dim_text_small_1.dim_id INNER JOIN
                      dim_text_small ON fact.value_key = dim_text_small.dim_id
                      
                      
where dim_text_small_1.dim_value = 'OBJECT_TYPE'

group by 	dim_text_small.dim_id, 
	dim_text_small.dim_value
GO
/****** Object:  Default [DF_fact_created_on]    Script Date: 02/12/2012 17:20:46 ******/
ALTER TABLE [dbo].[fact] ADD  CONSTRAINT [DF_fact_created_on]  DEFAULT (getdate()) FOR [created_on]
GO
