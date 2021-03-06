USE [master]
GO
/****** Object:  Database [baleen_template]    Script Date: 01/26/2012 20:44:26 ******/
CREATE DATABASE [baleen_template] ON  PRIMARY 
( NAME = N'baleen_template', FILENAME = N'c:\Program Files\Microsoft SQL Server\MSSQL10_50.MSSQLSERVER\MSSQL\DATA\baleen_template.mdf' , SIZE = 2048KB , MAXSIZE = UNLIMITED, FILEGROWTH = 20%)
 LOG ON 
( NAME = N'baleen_template_log', FILENAME = N'c:\Program Files\Microsoft SQL Server\MSSQL10_50.MSSQLSERVER\MSSQL\DATA\baleen_template_log.ldf' , SIZE = 1024KB , MAXSIZE = 2048GB , FILEGROWTH = 10%)
GO
ALTER DATABASE [baleen_template] SET COMPATIBILITY_LEVEL = 100
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [baleen_template].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [baleen_template] SET ANSI_NULL_DEFAULT OFF
GO
ALTER DATABASE [baleen_template] SET ANSI_NULLS OFF
GO
ALTER DATABASE [baleen_template] SET ANSI_PADDING OFF
GO
ALTER DATABASE [baleen_template] SET ANSI_WARNINGS OFF
GO
ALTER DATABASE [baleen_template] SET ARITHABORT OFF
GO
ALTER DATABASE [baleen_template] SET AUTO_CLOSE OFF
GO
ALTER DATABASE [baleen_template] SET AUTO_CREATE_STATISTICS ON
GO
ALTER DATABASE [baleen_template] SET AUTO_SHRINK OFF
GO
ALTER DATABASE [baleen_template] SET AUTO_UPDATE_STATISTICS ON
GO
ALTER DATABASE [baleen_template] SET CURSOR_CLOSE_ON_COMMIT OFF
GO
ALTER DATABASE [baleen_template] SET CURSOR_DEFAULT  GLOBAL
GO
ALTER DATABASE [baleen_template] SET CONCAT_NULL_YIELDS_NULL OFF
GO
ALTER DATABASE [baleen_template] SET NUMERIC_ROUNDABORT OFF
GO
ALTER DATABASE [baleen_template] SET QUOTED_IDENTIFIER OFF
GO
ALTER DATABASE [baleen_template] SET RECURSIVE_TRIGGERS OFF
GO
ALTER DATABASE [baleen_template] SET  DISABLE_BROKER
GO
ALTER DATABASE [baleen_template] SET AUTO_UPDATE_STATISTICS_ASYNC OFF
GO
ALTER DATABASE [baleen_template] SET DATE_CORRELATION_OPTIMIZATION OFF
GO
ALTER DATABASE [baleen_template] SET TRUSTWORTHY OFF
GO
ALTER DATABASE [baleen_template] SET ALLOW_SNAPSHOT_ISOLATION OFF
GO
ALTER DATABASE [baleen_template] SET PARAMETERIZATION SIMPLE
GO
ALTER DATABASE [baleen_template] SET READ_COMMITTED_SNAPSHOT OFF
GO
ALTER DATABASE [baleen_template] SET HONOR_BROKER_PRIORITY OFF
GO
ALTER DATABASE [baleen_template] SET  READ_WRITE
GO
ALTER DATABASE [baleen_template] SET RECOVERY SIMPLE
GO
ALTER DATABASE [baleen_template] SET  MULTI_USER
GO
ALTER DATABASE [baleen_template] SET PAGE_VERIFY CHECKSUM
GO
ALTER DATABASE [baleen_template] SET DB_CHAINING OFF
GO
USE [baleen_template]
GO
/****** Object:  Table [dbo].[dim_text_small]    Script Date: 01/26/2012 20:44:28 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[dim_text_small](
	[dim_id] [bigint] IDENTITY(1,1) NOT NULL,
	[dim_value] [nvarchar](300) NULL,
 CONSTRAINT [PK_dim_small_text] PRIMARY KEY CLUSTERED 
(
	[dim_id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [idx_small_text] ON [dbo].[dim_text_small] 
(
	[dim_value] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[dim_text_large]    Script Date: 01/26/2012 20:44:28 ******/
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
/****** Object:  Table [dbo].[dim_property]    Script Date: 01/26/2012 20:44:28 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[dim_property](
	[type_name_stxt_key] [bigint] NOT NULL,
	[record_ordinal] [int] NOT NULL,
	[field_name_stxt_key] [bigint] NULL,
	[data_type_stxt_key] [bigint] NULL,
 CONSTRAINT [PK_dim_property] PRIMARY KEY CLUSTERED 
(
	[type_name_stxt_key] ASC,
	[record_ordinal] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[dim_object]    Script Date: 01/26/2012 20:44:28 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[dim_object](
	[object_id] [bigint] IDENTITY(1,1) NOT NULL,
	[external_key] [uniqueidentifier] NULL,
	[custom_index_stxt_key] [bigint] NULL,
	[type_name_stxt_key] [bigint] NULL,
	[created_on_dt_key] [bigint] NULL,
 CONSTRAINT [PK_bln_object] PRIMARY KEY CLUSTERED 
(
	[object_id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [idx_created_on] ON [dbo].[dim_object] 
(
	[created_on_dt_key] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [idx_custom] ON [dbo].[dim_object] 
(
	[custom_index_stxt_key] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [idx_external_key] ON [dbo].[dim_object] 
(
	[external_key] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [idx_type_name] ON [dbo].[dim_object] 
(
	[type_name_stxt_key] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[dim_integer]    Script Date: 01/26/2012 20:44:28 ******/
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
/****** Object:  Table [dbo].[dim_float]    Script Date: 01/26/2012 20:44:28 ******/
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
/****** Object:  Table [dbo].[dim_datetime]    Script Date: 01/26/2012 20:44:28 ******/
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
/****** Object:  Table [dbo].[baleen_200]    Script Date: 01/26/2012 20:44:28 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[baleen_200](
	[object_id] [bigint] NULL,
	[a_0] [bigint] NULL,
	[a_1] [bigint] NULL,
	[a_2] [bigint] NULL,
	[a_3] [bigint] NULL,
	[a_4] [bigint] NULL,
	[a_5] [bigint] NULL,
	[a_6] [bigint] NULL,
	[a_7] [bigint] NULL,
	[a_8] [bigint] NULL,
	[a_9] [bigint] NULL,
	[a_10] [bigint] NULL,
	[a_11] [bigint] NULL,
	[a_12] [bigint] NULL,
	[a_13] [bigint] NULL,
	[a_14] [bigint] NULL,
	[a_15] [bigint] NULL,
	[a_16] [bigint] NULL,
	[a_17] [bigint] NULL,
	[a_18] [bigint] NULL,
	[a_19] [bigint] NULL,
	[a_20] [bigint] NULL,
	[a_21] [bigint] NULL,
	[a_22] [bigint] NULL,
	[a_23] [bigint] NULL,
	[a_24] [bigint] NULL,
	[a_25] [bigint] NULL,
	[a_26] [bigint] NULL,
	[a_27] [bigint] NULL,
	[a_28] [bigint] NULL,
	[a_29] [bigint] NULL,
	[a_30] [bigint] NULL,
	[a_31] [bigint] NULL,
	[a_32] [bigint] NULL,
	[a_33] [bigint] NULL,
	[a_34] [bigint] NULL,
	[a_35] [bigint] NULL,
	[a_36] [bigint] NULL,
	[a_37] [bigint] NULL,
	[a_38] [bigint] NULL,
	[a_39] [bigint] NULL,
	[a_40] [bigint] NULL,
	[a_41] [bigint] NULL,
	[a_42] [bigint] NULL,
	[a_43] [bigint] NULL,
	[a_44] [bigint] NULL,
	[a_45] [bigint] NULL,
	[a_46] [bigint] NULL,
	[a_47] [bigint] NULL,
	[a_48] [bigint] NULL,
	[a_49] [bigint] NULL,
	[a_50] [bigint] NULL,
	[a_51] [bigint] NULL,
	[a_52] [bigint] NULL,
	[a_53] [bigint] NULL,
	[a_54] [bigint] NULL,
	[a_55] [bigint] NULL,
	[a_56] [bigint] NULL,
	[a_57] [bigint] NULL,
	[a_58] [bigint] NULL,
	[a_59] [bigint] NULL,
	[a_60] [bigint] NULL,
	[a_61] [bigint] NULL,
	[a_62] [bigint] NULL,
	[a_63] [bigint] NULL,
	[a_64] [bigint] NULL,
	[a_65] [bigint] NULL,
	[a_66] [bigint] NULL,
	[a_67] [bigint] NULL,
	[a_68] [bigint] NULL,
	[a_69] [bigint] NULL,
	[a_70] [bigint] NULL,
	[a_71] [bigint] NULL,
	[a_72] [bigint] NULL,
	[a_73] [bigint] NULL,
	[a_74] [bigint] NULL,
	[a_75] [bigint] NULL,
	[a_76] [bigint] NULL,
	[a_77] [bigint] NULL,
	[a_78] [bigint] NULL,
	[a_79] [bigint] NULL,
	[a_80] [bigint] NULL,
	[a_81] [bigint] NULL,
	[a_82] [bigint] NULL,
	[a_83] [bigint] NULL,
	[a_84] [bigint] NULL,
	[a_85] [bigint] NULL,
	[a_86] [bigint] NULL,
	[a_87] [bigint] NULL,
	[a_88] [bigint] NULL,
	[a_89] [bigint] NULL,
	[a_90] [bigint] NULL,
	[a_91] [bigint] NULL,
	[a_92] [bigint] NULL,
	[a_93] [bigint] NULL,
	[a_94] [bigint] NULL,
	[a_95] [bigint] NULL,
	[a_96] [bigint] NULL,
	[a_97] [bigint] NULL,
	[a_98] [bigint] NULL,
	[a_99] [bigint] NULL,
	[a_100] [bigint] NULL,
	[a_101] [bigint] NULL,
	[a_102] [bigint] NULL,
	[a_103] [bigint] NULL,
	[a_104] [bigint] NULL,
	[a_105] [bigint] NULL,
	[a_106] [bigint] NULL,
	[a_107] [bigint] NULL,
	[a_108] [bigint] NULL,
	[a_109] [bigint] NULL,
	[a_110] [bigint] NULL,
	[a_111] [bigint] NULL,
	[a_112] [bigint] NULL,
	[a_113] [bigint] NULL,
	[a_114] [bigint] NULL,
	[a_115] [bigint] NULL,
	[a_116] [bigint] NULL,
	[a_117] [bigint] NULL,
	[a_118] [bigint] NULL,
	[a_119] [bigint] NULL,
	[a_120] [bigint] NULL,
	[a_121] [bigint] NULL,
	[a_122] [bigint] NULL,
	[a_123] [bigint] NULL,
	[a_124] [bigint] NULL,
	[a_125] [bigint] NULL,
	[a_126] [bigint] NULL,
	[a_127] [bigint] NULL,
	[a_128] [bigint] NULL,
	[a_129] [bigint] NULL,
	[a_130] [bigint] NULL,
	[a_131] [bigint] NULL,
	[a_132] [bigint] NULL,
	[a_133] [bigint] NULL,
	[a_134] [bigint] NULL,
	[a_135] [bigint] NULL,
	[a_136] [bigint] NULL,
	[a_137] [bigint] NULL,
	[a_138] [bigint] NULL,
	[a_139] [bigint] NULL,
	[a_140] [bigint] NULL,
	[a_141] [bigint] NULL,
	[a_142] [bigint] NULL,
	[a_143] [bigint] NULL,
	[a_144] [bigint] NULL,
	[a_145] [bigint] NULL,
	[a_146] [bigint] NULL,
	[a_147] [bigint] NULL,
	[a_148] [bigint] NULL,
	[a_149] [bigint] NULL,
	[a_150] [bigint] NULL,
	[a_151] [bigint] NULL,
	[a_152] [bigint] NULL,
	[a_153] [bigint] NULL,
	[a_154] [bigint] NULL,
	[a_155] [bigint] NULL,
	[a_156] [bigint] NULL,
	[a_157] [bigint] NULL,
	[a_158] [bigint] NULL,
	[a_159] [bigint] NULL,
	[a_160] [bigint] NULL,
	[a_161] [bigint] NULL,
	[a_162] [bigint] NULL,
	[a_163] [bigint] NULL,
	[a_164] [bigint] NULL,
	[a_165] [bigint] NULL,
	[a_166] [bigint] NULL,
	[a_167] [bigint] NULL,
	[a_168] [bigint] NULL,
	[a_169] [bigint] NULL,
	[a_170] [bigint] NULL,
	[a_171] [bigint] NULL,
	[a_172] [bigint] NULL,
	[a_173] [bigint] NULL,
	[a_174] [bigint] NULL,
	[a_175] [bigint] NULL,
	[a_176] [bigint] NULL,
	[a_177] [bigint] NULL,
	[a_178] [bigint] NULL,
	[a_179] [bigint] NULL,
	[a_180] [bigint] NULL,
	[a_181] [bigint] NULL,
	[a_182] [bigint] NULL,
	[a_183] [bigint] NULL,
	[a_184] [bigint] NULL,
	[a_185] [bigint] NULL,
	[a_186] [bigint] NULL,
	[a_187] [bigint] NULL,
	[a_188] [bigint] NULL,
	[a_189] [bigint] NULL,
	[a_190] [bigint] NULL,
	[a_191] [bigint] NULL,
	[a_192] [bigint] NULL,
	[a_193] [bigint] NULL,
	[a_194] [bigint] NULL,
	[a_195] [bigint] NULL,
	[a_196] [bigint] NULL,
	[a_197] [bigint] NULL,
	[a_198] [bigint] NULL,
	[a_199] [bigint] NULL
) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [idx_object_ref] ON [dbo].[baleen_200] 
(
	[object_id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[baleen_100]    Script Date: 01/26/2012 20:44:28 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[baleen_100](
	[object_id] [bigint] NULL,
	[a_0] [bigint] NULL,
	[a_1] [bigint] NULL,
	[a_2] [bigint] NULL,
	[a_3] [bigint] NULL,
	[a_4] [bigint] NULL,
	[a_5] [bigint] NULL,
	[a_6] [bigint] NULL,
	[a_7] [bigint] NULL,
	[a_8] [bigint] NULL,
	[a_9] [bigint] NULL,
	[a_10] [bigint] NULL,
	[a_11] [bigint] NULL,
	[a_12] [bigint] NULL,
	[a_13] [bigint] NULL,
	[a_14] [bigint] NULL,
	[a_15] [bigint] NULL,
	[a_16] [bigint] NULL,
	[a_17] [bigint] NULL,
	[a_18] [bigint] NULL,
	[a_19] [bigint] NULL,
	[a_20] [bigint] NULL,
	[a_21] [bigint] NULL,
	[a_22] [bigint] NULL,
	[a_23] [bigint] NULL,
	[a_24] [bigint] NULL,
	[a_25] [bigint] NULL,
	[a_26] [bigint] NULL,
	[a_27] [bigint] NULL,
	[a_28] [bigint] NULL,
	[a_29] [bigint] NULL,
	[a_30] [bigint] NULL,
	[a_31] [bigint] NULL,
	[a_32] [bigint] NULL,
	[a_33] [bigint] NULL,
	[a_34] [bigint] NULL,
	[a_35] [bigint] NULL,
	[a_36] [bigint] NULL,
	[a_37] [bigint] NULL,
	[a_38] [bigint] NULL,
	[a_39] [bigint] NULL,
	[a_40] [bigint] NULL,
	[a_41] [bigint] NULL,
	[a_42] [bigint] NULL,
	[a_43] [bigint] NULL,
	[a_44] [bigint] NULL,
	[a_45] [bigint] NULL,
	[a_46] [bigint] NULL,
	[a_47] [bigint] NULL,
	[a_48] [bigint] NULL,
	[a_49] [bigint] NULL,
	[a_50] [bigint] NULL,
	[a_51] [bigint] NULL,
	[a_52] [bigint] NULL,
	[a_53] [bigint] NULL,
	[a_54] [bigint] NULL,
	[a_55] [bigint] NULL,
	[a_56] [bigint] NULL,
	[a_57] [bigint] NULL,
	[a_58] [bigint] NULL,
	[a_59] [bigint] NULL,
	[a_60] [bigint] NULL,
	[a_61] [bigint] NULL,
	[a_62] [bigint] NULL,
	[a_63] [bigint] NULL,
	[a_64] [bigint] NULL,
	[a_65] [bigint] NULL,
	[a_66] [bigint] NULL,
	[a_67] [bigint] NULL,
	[a_68] [bigint] NULL,
	[a_69] [bigint] NULL,
	[a_70] [bigint] NULL,
	[a_71] [bigint] NULL,
	[a_72] [bigint] NULL,
	[a_73] [bigint] NULL,
	[a_74] [bigint] NULL,
	[a_75] [bigint] NULL,
	[a_76] [bigint] NULL,
	[a_77] [bigint] NULL,
	[a_78] [bigint] NULL,
	[a_79] [bigint] NULL,
	[a_80] [bigint] NULL,
	[a_81] [bigint] NULL,
	[a_82] [bigint] NULL,
	[a_83] [bigint] NULL,
	[a_84] [bigint] NULL,
	[a_85] [bigint] NULL,
	[a_86] [bigint] NULL,
	[a_87] [bigint] NULL,
	[a_88] [bigint] NULL,
	[a_89] [bigint] NULL,
	[a_90] [bigint] NULL,
	[a_91] [bigint] NULL,
	[a_92] [bigint] NULL,
	[a_93] [bigint] NULL,
	[a_94] [bigint] NULL,
	[a_95] [bigint] NULL,
	[a_96] [bigint] NULL,
	[a_97] [bigint] NULL,
	[a_98] [bigint] NULL,
	[a_99] [bigint] NULL
) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [idx_object_ref] ON [dbo].[baleen_100] 
(
	[object_id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[baleen_090]    Script Date: 01/26/2012 20:44:28 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[baleen_090](
	[object_id] [bigint] NULL,
	[a_0] [bigint] NULL,
	[a_1] [bigint] NULL,
	[a_2] [bigint] NULL,
	[a_3] [bigint] NULL,
	[a_4] [bigint] NULL,
	[a_5] [bigint] NULL,
	[a_6] [bigint] NULL,
	[a_7] [bigint] NULL,
	[a_8] [bigint] NULL,
	[a_9] [bigint] NULL,
	[a_10] [bigint] NULL,
	[a_11] [bigint] NULL,
	[a_12] [bigint] NULL,
	[a_13] [bigint] NULL,
	[a_14] [bigint] NULL,
	[a_15] [bigint] NULL,
	[a_16] [bigint] NULL,
	[a_17] [bigint] NULL,
	[a_18] [bigint] NULL,
	[a_19] [bigint] NULL,
	[a_20] [bigint] NULL,
	[a_21] [bigint] NULL,
	[a_22] [bigint] NULL,
	[a_23] [bigint] NULL,
	[a_24] [bigint] NULL,
	[a_25] [bigint] NULL,
	[a_26] [bigint] NULL,
	[a_27] [bigint] NULL,
	[a_28] [bigint] NULL,
	[a_29] [bigint] NULL,
	[a_30] [bigint] NULL,
	[a_31] [bigint] NULL,
	[a_32] [bigint] NULL,
	[a_33] [bigint] NULL,
	[a_34] [bigint] NULL,
	[a_35] [bigint] NULL,
	[a_36] [bigint] NULL,
	[a_37] [bigint] NULL,
	[a_38] [bigint] NULL,
	[a_39] [bigint] NULL,
	[a_40] [bigint] NULL,
	[a_41] [bigint] NULL,
	[a_42] [bigint] NULL,
	[a_43] [bigint] NULL,
	[a_44] [bigint] NULL,
	[a_45] [bigint] NULL,
	[a_46] [bigint] NULL,
	[a_47] [bigint] NULL,
	[a_48] [bigint] NULL,
	[a_49] [bigint] NULL,
	[a_50] [bigint] NULL,
	[a_51] [bigint] NULL,
	[a_52] [bigint] NULL,
	[a_53] [bigint] NULL,
	[a_54] [bigint] NULL,
	[a_55] [bigint] NULL,
	[a_56] [bigint] NULL,
	[a_57] [bigint] NULL,
	[a_58] [bigint] NULL,
	[a_59] [bigint] NULL,
	[a_60] [bigint] NULL,
	[a_61] [bigint] NULL,
	[a_62] [bigint] NULL,
	[a_63] [bigint] NULL,
	[a_64] [bigint] NULL,
	[a_65] [bigint] NULL,
	[a_66] [bigint] NULL,
	[a_67] [bigint] NULL,
	[a_68] [bigint] NULL,
	[a_69] [bigint] NULL,
	[a_70] [bigint] NULL,
	[a_71] [bigint] NULL,
	[a_72] [bigint] NULL,
	[a_73] [bigint] NULL,
	[a_74] [bigint] NULL,
	[a_75] [bigint] NULL,
	[a_76] [bigint] NULL,
	[a_77] [bigint] NULL,
	[a_78] [bigint] NULL,
	[a_79] [bigint] NULL,
	[a_80] [bigint] NULL,
	[a_81] [bigint] NULL,
	[a_82] [bigint] NULL,
	[a_83] [bigint] NULL,
	[a_84] [bigint] NULL,
	[a_85] [bigint] NULL,
	[a_86] [bigint] NULL,
	[a_87] [bigint] NULL,
	[a_88] [bigint] NULL,
	[a_89] [bigint] NULL
) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [idx_object_ref] ON [dbo].[baleen_090] 
(
	[object_id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[baleen_080]    Script Date: 01/26/2012 20:44:28 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[baleen_080](
	[object_id] [bigint] NULL,
	[a_0] [bigint] NULL,
	[a_1] [bigint] NULL,
	[a_2] [bigint] NULL,
	[a_3] [bigint] NULL,
	[a_4] [bigint] NULL,
	[a_5] [bigint] NULL,
	[a_6] [bigint] NULL,
	[a_7] [bigint] NULL,
	[a_8] [bigint] NULL,
	[a_9] [bigint] NULL,
	[a_10] [bigint] NULL,
	[a_11] [bigint] NULL,
	[a_12] [bigint] NULL,
	[a_13] [bigint] NULL,
	[a_14] [bigint] NULL,
	[a_15] [bigint] NULL,
	[a_16] [bigint] NULL,
	[a_17] [bigint] NULL,
	[a_18] [bigint] NULL,
	[a_19] [bigint] NULL,
	[a_20] [bigint] NULL,
	[a_21] [bigint] NULL,
	[a_22] [bigint] NULL,
	[a_23] [bigint] NULL,
	[a_24] [bigint] NULL,
	[a_25] [bigint] NULL,
	[a_26] [bigint] NULL,
	[a_27] [bigint] NULL,
	[a_28] [bigint] NULL,
	[a_29] [bigint] NULL,
	[a_30] [bigint] NULL,
	[a_31] [bigint] NULL,
	[a_32] [bigint] NULL,
	[a_33] [bigint] NULL,
	[a_34] [bigint] NULL,
	[a_35] [bigint] NULL,
	[a_36] [bigint] NULL,
	[a_37] [bigint] NULL,
	[a_38] [bigint] NULL,
	[a_39] [bigint] NULL,
	[a_40] [bigint] NULL,
	[a_41] [bigint] NULL,
	[a_42] [bigint] NULL,
	[a_43] [bigint] NULL,
	[a_44] [bigint] NULL,
	[a_45] [bigint] NULL,
	[a_46] [bigint] NULL,
	[a_47] [bigint] NULL,
	[a_48] [bigint] NULL,
	[a_49] [bigint] NULL,
	[a_50] [bigint] NULL,
	[a_51] [bigint] NULL,
	[a_52] [bigint] NULL,
	[a_53] [bigint] NULL,
	[a_54] [bigint] NULL,
	[a_55] [bigint] NULL,
	[a_56] [bigint] NULL,
	[a_57] [bigint] NULL,
	[a_58] [bigint] NULL,
	[a_59] [bigint] NULL,
	[a_60] [bigint] NULL,
	[a_61] [bigint] NULL,
	[a_62] [bigint] NULL,
	[a_63] [bigint] NULL,
	[a_64] [bigint] NULL,
	[a_65] [bigint] NULL,
	[a_66] [bigint] NULL,
	[a_67] [bigint] NULL,
	[a_68] [bigint] NULL,
	[a_69] [bigint] NULL,
	[a_70] [bigint] NULL,
	[a_71] [bigint] NULL,
	[a_72] [bigint] NULL,
	[a_73] [bigint] NULL,
	[a_74] [bigint] NULL,
	[a_75] [bigint] NULL,
	[a_76] [bigint] NULL,
	[a_77] [bigint] NULL,
	[a_78] [bigint] NULL,
	[a_79] [bigint] NULL
) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [idx_object_ref] ON [dbo].[baleen_080] 
(
	[object_id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[baleen_070]    Script Date: 01/26/2012 20:44:28 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[baleen_070](
	[object_id] [bigint] NULL,
	[a_0] [bigint] NULL,
	[a_1] [bigint] NULL,
	[a_2] [bigint] NULL,
	[a_3] [bigint] NULL,
	[a_4] [bigint] NULL,
	[a_5] [bigint] NULL,
	[a_6] [bigint] NULL,
	[a_7] [bigint] NULL,
	[a_8] [bigint] NULL,
	[a_9] [bigint] NULL,
	[a_10] [bigint] NULL,
	[a_11] [bigint] NULL,
	[a_12] [bigint] NULL,
	[a_13] [bigint] NULL,
	[a_14] [bigint] NULL,
	[a_15] [bigint] NULL,
	[a_16] [bigint] NULL,
	[a_17] [bigint] NULL,
	[a_18] [bigint] NULL,
	[a_19] [bigint] NULL,
	[a_20] [bigint] NULL,
	[a_21] [bigint] NULL,
	[a_22] [bigint] NULL,
	[a_23] [bigint] NULL,
	[a_24] [bigint] NULL,
	[a_25] [bigint] NULL,
	[a_26] [bigint] NULL,
	[a_27] [bigint] NULL,
	[a_28] [bigint] NULL,
	[a_29] [bigint] NULL,
	[a_30] [bigint] NULL,
	[a_31] [bigint] NULL,
	[a_32] [bigint] NULL,
	[a_33] [bigint] NULL,
	[a_34] [bigint] NULL,
	[a_35] [bigint] NULL,
	[a_36] [bigint] NULL,
	[a_37] [bigint] NULL,
	[a_38] [bigint] NULL,
	[a_39] [bigint] NULL,
	[a_40] [bigint] NULL,
	[a_41] [bigint] NULL,
	[a_42] [bigint] NULL,
	[a_43] [bigint] NULL,
	[a_44] [bigint] NULL,
	[a_45] [bigint] NULL,
	[a_46] [bigint] NULL,
	[a_47] [bigint] NULL,
	[a_48] [bigint] NULL,
	[a_49] [bigint] NULL,
	[a_50] [bigint] NULL,
	[a_51] [bigint] NULL,
	[a_52] [bigint] NULL,
	[a_53] [bigint] NULL,
	[a_54] [bigint] NULL,
	[a_55] [bigint] NULL,
	[a_56] [bigint] NULL,
	[a_57] [bigint] NULL,
	[a_58] [bigint] NULL,
	[a_59] [bigint] NULL,
	[a_60] [bigint] NULL,
	[a_61] [bigint] NULL,
	[a_62] [bigint] NULL,
	[a_63] [bigint] NULL,
	[a_64] [bigint] NULL,
	[a_65] [bigint] NULL,
	[a_66] [bigint] NULL,
	[a_67] [bigint] NULL,
	[a_68] [bigint] NULL,
	[a_69] [bigint] NULL
) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [idx_object_ref] ON [dbo].[baleen_070] 
(
	[object_id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[baleen_060]    Script Date: 01/26/2012 20:44:28 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[baleen_060](
	[object_id] [bigint] NULL,
	[a_0] [bigint] NULL,
	[a_1] [bigint] NULL,
	[a_2] [bigint] NULL,
	[a_3] [bigint] NULL,
	[a_4] [bigint] NULL,
	[a_5] [bigint] NULL,
	[a_6] [bigint] NULL,
	[a_7] [bigint] NULL,
	[a_8] [bigint] NULL,
	[a_9] [bigint] NULL,
	[a_10] [bigint] NULL,
	[a_11] [bigint] NULL,
	[a_12] [bigint] NULL,
	[a_13] [bigint] NULL,
	[a_14] [bigint] NULL,
	[a_15] [bigint] NULL,
	[a_16] [bigint] NULL,
	[a_17] [bigint] NULL,
	[a_18] [bigint] NULL,
	[a_19] [bigint] NULL,
	[a_20] [bigint] NULL,
	[a_21] [bigint] NULL,
	[a_22] [bigint] NULL,
	[a_23] [bigint] NULL,
	[a_24] [bigint] NULL,
	[a_25] [bigint] NULL,
	[a_26] [bigint] NULL,
	[a_27] [bigint] NULL,
	[a_28] [bigint] NULL,
	[a_29] [bigint] NULL,
	[a_30] [bigint] NULL,
	[a_31] [bigint] NULL,
	[a_32] [bigint] NULL,
	[a_33] [bigint] NULL,
	[a_34] [bigint] NULL,
	[a_35] [bigint] NULL,
	[a_36] [bigint] NULL,
	[a_37] [bigint] NULL,
	[a_38] [bigint] NULL,
	[a_39] [bigint] NULL,
	[a_40] [bigint] NULL,
	[a_41] [bigint] NULL,
	[a_42] [bigint] NULL,
	[a_43] [bigint] NULL,
	[a_44] [bigint] NULL,
	[a_45] [bigint] NULL,
	[a_46] [bigint] NULL,
	[a_47] [bigint] NULL,
	[a_48] [bigint] NULL,
	[a_49] [bigint] NULL,
	[a_50] [bigint] NULL,
	[a_51] [bigint] NULL,
	[a_52] [bigint] NULL,
	[a_53] [bigint] NULL,
	[a_54] [bigint] NULL,
	[a_55] [bigint] NULL,
	[a_56] [bigint] NULL,
	[a_57] [bigint] NULL,
	[a_58] [bigint] NULL,
	[a_59] [bigint] NULL
) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [idx_object_ref] ON [dbo].[baleen_060] 
(
	[object_id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[baleen_050]    Script Date: 01/26/2012 20:44:28 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[baleen_050](
	[object_id] [bigint] NULL,
	[a_0] [bigint] NULL,
	[a_1] [bigint] NULL,
	[a_2] [bigint] NULL,
	[a_3] [bigint] NULL,
	[a_4] [bigint] NULL,
	[a_5] [bigint] NULL,
	[a_6] [bigint] NULL,
	[a_7] [bigint] NULL,
	[a_8] [bigint] NULL,
	[a_9] [bigint] NULL,
	[a_10] [bigint] NULL,
	[a_11] [bigint] NULL,
	[a_12] [bigint] NULL,
	[a_13] [bigint] NULL,
	[a_14] [bigint] NULL,
	[a_15] [bigint] NULL,
	[a_16] [bigint] NULL,
	[a_17] [bigint] NULL,
	[a_18] [bigint] NULL,
	[a_19] [bigint] NULL,
	[a_20] [bigint] NULL,
	[a_21] [bigint] NULL,
	[a_22] [bigint] NULL,
	[a_23] [bigint] NULL,
	[a_24] [bigint] NULL,
	[a_25] [bigint] NULL,
	[a_26] [bigint] NULL,
	[a_27] [bigint] NULL,
	[a_28] [bigint] NULL,
	[a_29] [bigint] NULL,
	[a_30] [bigint] NULL,
	[a_31] [bigint] NULL,
	[a_32] [bigint] NULL,
	[a_33] [bigint] NULL,
	[a_34] [bigint] NULL,
	[a_35] [bigint] NULL,
	[a_36] [bigint] NULL,
	[a_37] [bigint] NULL,
	[a_38] [bigint] NULL,
	[a_39] [bigint] NULL,
	[a_40] [bigint] NULL,
	[a_41] [bigint] NULL,
	[a_42] [bigint] NULL,
	[a_43] [bigint] NULL,
	[a_44] [bigint] NULL,
	[a_45] [bigint] NULL,
	[a_46] [bigint] NULL,
	[a_47] [bigint] NULL,
	[a_48] [bigint] NULL,
	[a_49] [bigint] NULL
) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [idx_object_ref] ON [dbo].[baleen_050] 
(
	[object_id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[baleen_040]    Script Date: 01/26/2012 20:44:28 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[baleen_040](
	[object_id] [bigint] NULL,
	[a_0] [bigint] NULL,
	[a_1] [bigint] NULL,
	[a_2] [bigint] NULL,
	[a_3] [bigint] NULL,
	[a_4] [bigint] NULL,
	[a_5] [bigint] NULL,
	[a_6] [bigint] NULL,
	[a_7] [bigint] NULL,
	[a_8] [bigint] NULL,
	[a_9] [bigint] NULL,
	[a_10] [bigint] NULL,
	[a_11] [bigint] NULL,
	[a_12] [bigint] NULL,
	[a_13] [bigint] NULL,
	[a_14] [bigint] NULL,
	[a_15] [bigint] NULL,
	[a_16] [bigint] NULL,
	[a_17] [bigint] NULL,
	[a_18] [bigint] NULL,
	[a_19] [bigint] NULL,
	[a_20] [bigint] NULL,
	[a_21] [bigint] NULL,
	[a_22] [bigint] NULL,
	[a_23] [bigint] NULL,
	[a_24] [bigint] NULL,
	[a_25] [bigint] NULL,
	[a_26] [bigint] NULL,
	[a_27] [bigint] NULL,
	[a_28] [bigint] NULL,
	[a_29] [bigint] NULL,
	[a_30] [bigint] NULL,
	[a_31] [bigint] NULL,
	[a_32] [bigint] NULL,
	[a_33] [bigint] NULL,
	[a_34] [bigint] NULL,
	[a_35] [bigint] NULL,
	[a_36] [bigint] NULL,
	[a_37] [bigint] NULL,
	[a_38] [bigint] NULL,
	[a_39] [bigint] NULL
) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [idx_object_ref] ON [dbo].[baleen_040] 
(
	[object_id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[baleen_030]    Script Date: 01/26/2012 20:44:28 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[baleen_030](
	[object_id] [bigint] NULL,
	[a_0] [bigint] NULL,
	[a_1] [bigint] NULL,
	[a_2] [bigint] NULL,
	[a_3] [bigint] NULL,
	[a_4] [bigint] NULL,
	[a_5] [bigint] NULL,
	[a_6] [bigint] NULL,
	[a_7] [bigint] NULL,
	[a_8] [bigint] NULL,
	[a_9] [bigint] NULL,
	[a_10] [bigint] NULL,
	[a_11] [bigint] NULL,
	[a_12] [bigint] NULL,
	[a_13] [bigint] NULL,
	[a_14] [bigint] NULL,
	[a_15] [bigint] NULL,
	[a_16] [bigint] NULL,
	[a_17] [bigint] NULL,
	[a_18] [bigint] NULL,
	[a_19] [bigint] NULL,
	[a_20] [bigint] NULL,
	[a_21] [bigint] NULL,
	[a_22] [bigint] NULL,
	[a_23] [bigint] NULL,
	[a_24] [bigint] NULL,
	[a_25] [bigint] NULL,
	[a_26] [bigint] NULL,
	[a_27] [bigint] NULL,
	[a_28] [bigint] NULL,
	[a_29] [bigint] NULL
) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [idx_object_ref] ON [dbo].[baleen_030] 
(
	[object_id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[baleen_020]    Script Date: 01/26/2012 20:44:28 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[baleen_020](
	[object_id] [bigint] NULL,
	[a_0] [bigint] NULL,
	[a_1] [bigint] NULL,
	[a_2] [bigint] NULL,
	[a_3] [bigint] NULL,
	[a_4] [bigint] NULL,
	[a_5] [bigint] NULL,
	[a_6] [bigint] NULL,
	[a_7] [bigint] NULL,
	[a_8] [bigint] NULL,
	[a_9] [bigint] NULL,
	[a_10] [bigint] NULL,
	[a_11] [bigint] NULL,
	[a_12] [bigint] NULL,
	[a_13] [bigint] NULL,
	[a_14] [bigint] NULL,
	[a_15] [bigint] NULL,
	[a_16] [bigint] NULL,
	[a_17] [bigint] NULL,
	[a_18] [bigint] NULL,
	[a_19] [bigint] NULL
) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [idx_object_ref] ON [dbo].[baleen_020] 
(
	[object_id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[baleen_010]    Script Date: 01/26/2012 20:44:28 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[baleen_010](
	[object_id] [bigint] NULL,
	[a_0] [bigint] NULL,
	[a_1] [bigint] NULL,
	[a_2] [bigint] NULL,
	[a_3] [bigint] NULL,
	[a_4] [bigint] NULL,
	[a_5] [bigint] NULL,
	[a_6] [bigint] NULL,
	[a_7] [bigint] NULL,
	[a_8] [bigint] NULL,
	[a_9] [bigint] NULL
) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [idx_object_ref] ON [dbo].[baleen_010] 
(
	[object_id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO
