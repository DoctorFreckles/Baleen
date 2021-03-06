USE [master]
GO
/****** Object:  Database [<<REPLACE_DB_NAME>>]    Script Date: 01/28/2012 20:59:39 ******/
CREATE DATABASE [<<REPLACE_DB_NAME>>] ON  PRIMARY 
( NAME = N'<<REPLACE_DB_NAME>>', FILENAME = N'c:\Program Files\Microsoft SQL Server\MSSQL10_50.MSSQLSERVER\MSSQL\DATA\<<REPLACE_DB_NAME>>.mdf' , SIZE = 315392KB , MAXSIZE = UNLIMITED, FILEGROWTH = 20%)
 LOG ON 
( NAME = N'<<REPLACE_DB_NAME>>_log', FILENAME = N'c:\Program Files\Microsoft SQL Server\MSSQL10_50.MSSQLSERVER\MSSQL\DATA\<<REPLACE_DB_NAME>>_log.ldf' , SIZE = 1024KB , MAXSIZE = 2048GB , FILEGROWTH = 10%)
GO
ALTER DATABASE [<<REPLACE_DB_NAME>>] SET COMPATIBILITY_LEVEL = 100
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [<<REPLACE_DB_NAME>>].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [<<REPLACE_DB_NAME>>] SET ANSI_NULL_DEFAULT OFF
GO
ALTER DATABASE [<<REPLACE_DB_NAME>>] SET ANSI_NULLS OFF
GO
ALTER DATABASE [<<REPLACE_DB_NAME>>] SET ANSI_PADDING OFF
GO
ALTER DATABASE [<<REPLACE_DB_NAME>>] SET ANSI_WARNINGS OFF
GO
ALTER DATABASE [<<REPLACE_DB_NAME>>] SET ARITHABORT OFF
GO
ALTER DATABASE [<<REPLACE_DB_NAME>>] SET AUTO_CLOSE OFF
GO
ALTER DATABASE [<<REPLACE_DB_NAME>>] SET AUTO_CREATE_STATISTICS ON
GO
ALTER DATABASE [<<REPLACE_DB_NAME>>] SET AUTO_SHRINK OFF
GO
ALTER DATABASE [<<REPLACE_DB_NAME>>] SET AUTO_UPDATE_STATISTICS ON
GO
ALTER DATABASE [<<REPLACE_DB_NAME>>] SET CURSOR_CLOSE_ON_COMMIT OFF
GO
ALTER DATABASE [<<REPLACE_DB_NAME>>] SET CURSOR_DEFAULT  GLOBAL
GO
ALTER DATABASE [<<REPLACE_DB_NAME>>] SET CONCAT_NULL_YIELDS_NULL OFF
GO
ALTER DATABASE [<<REPLACE_DB_NAME>>] SET NUMERIC_ROUNDABORT OFF
GO
ALTER DATABASE [<<REPLACE_DB_NAME>>] SET QUOTED_IDENTIFIER OFF
GO
ALTER DATABASE [<<REPLACE_DB_NAME>>] SET RECURSIVE_TRIGGERS OFF
GO
ALTER DATABASE [<<REPLACE_DB_NAME>>] SET  DISABLE_BROKER
GO
ALTER DATABASE [<<REPLACE_DB_NAME>>] SET AUTO_UPDATE_STATISTICS_ASYNC OFF
GO
ALTER DATABASE [<<REPLACE_DB_NAME>>] SET DATE_CORRELATION_OPTIMIZATION OFF
GO
ALTER DATABASE [<<REPLACE_DB_NAME>>] SET TRUSTWORTHY OFF
GO
ALTER DATABASE [<<REPLACE_DB_NAME>>] SET ALLOW_SNAPSHOT_ISOLATION OFF
GO
ALTER DATABASE [<<REPLACE_DB_NAME>>] SET PARAMETERIZATION SIMPLE
GO
ALTER DATABASE [<<REPLACE_DB_NAME>>] SET READ_COMMITTED_SNAPSHOT OFF
GO
ALTER DATABASE [<<REPLACE_DB_NAME>>] SET HONOR_BROKER_PRIORITY OFF
GO
ALTER DATABASE [<<REPLACE_DB_NAME>>] SET  READ_WRITE
GO
ALTER DATABASE [<<REPLACE_DB_NAME>>] SET RECOVERY SIMPLE
GO
ALTER DATABASE [<<REPLACE_DB_NAME>>] SET  MULTI_USER
GO
ALTER DATABASE [<<REPLACE_DB_NAME>>] SET PAGE_VERIFY CHECKSUM
GO
ALTER DATABASE [<<REPLACE_DB_NAME>>] SET DB_CHAINING OFF
GO
USE [<<REPLACE_DB_NAME>>]
GO
/****** Object:  Table [dbo].[dim_text_small]    Script Date: 01/28/2012 20:59:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[dim_text_small](
	[dim_id] [bigint] IDENTITY(1,1) NOT NULL,
	[dim_value] [nvarchar](350) NULL,
	[external_id] [uniqueidentifier] NULL,
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
/****** Object:  Table [dbo].[dim_text_large]    Script Date: 01/28/2012 20:59:40 ******/
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
/****** Object:  Table [dbo].[dim_integer]    Script Date: 01/28/2012 20:59:40 ******/
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
/****** Object:  Table [dbo].[dim_float]    Script Date: 01/28/2012 20:59:40 ******/
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
/****** Object:  Table [dbo].[dim_datetime]    Script Date: 01/28/2012 20:59:40 ******/
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
/****** Object:  Table [dbo].[baleen_200]    Script Date: 01/28/2012 20:59:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[baleen_200](
	[table_key] [bigint] IDENTITY(1,1) NOT NULL,
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
	[a_199] [bigint] NULL,
	[created_on_key] [bigint] NULL,
	[created_by_key] [bigint] NULL,
	[updated_on_key] [bigint] NULL,
	[updated_by_key] [bigint] NULL,
	[type_or_file_key] [bigint] NULL,
	[is_line_1] [bit] NULL,
 CONSTRAINT [PK_baleen_200] PRIMARY KEY CLUSTERED 
(
	[table_key] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [idx_line_1] ON [dbo].[baleen_200] 
(
	[is_line_1] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [idx_line_info] ON [dbo].[baleen_200] 
(
	[created_on_key] ASC,
	[created_by_key] ASC,
	[updated_on_key] ASC,
	[updated_by_key] ASC,
	[type_or_file_key] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[baleen_100]    Script Date: 01/28/2012 20:59:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[baleen_100](
	[table_key] [bigint] IDENTITY(1,1) NOT NULL,
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
	[created_on_key] [bigint] NULL,
	[created_by_key] [bigint] NULL,
	[updated_on_key] [bigint] NULL,
	[updated_by_key] [bigint] NULL,
	[type_or_file_key] [bigint] NULL,
	[is_line_1] [bit] NULL,
 CONSTRAINT [PK_baleen_100] PRIMARY KEY CLUSTERED 
(
	[table_key] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [idx_line_1] ON [dbo].[baleen_100] 
(
	[is_line_1] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [idx_line_info] ON [dbo].[baleen_100] 
(
	[created_on_key] ASC,
	[created_by_key] ASC,
	[updated_on_key] ASC,
	[updated_by_key] ASC,
	[type_or_file_key] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[baleen_090]    Script Date: 01/28/2012 20:59:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[baleen_090](
	[table_key] [bigint] IDENTITY(1,1) NOT NULL,
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
	[created_on_key] [bigint] NULL,
	[created_by_key] [bigint] NULL,
	[updated_on_key] [bigint] NULL,
	[updated_by_key] [bigint] NULL,
	[type_or_file_key] [bigint] NULL,
	[is_line_1] [bit] NULL,
 CONSTRAINT [PK_baleen_090] PRIMARY KEY CLUSTERED 
(
	[table_key] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [idx_line_1] ON [dbo].[baleen_090] 
(
	[is_line_1] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [idx_line_info] ON [dbo].[baleen_090] 
(
	[created_on_key] ASC,
	[created_by_key] ASC,
	[updated_on_key] ASC,
	[updated_by_key] ASC,
	[type_or_file_key] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[baleen_080]    Script Date: 01/28/2012 20:59:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[baleen_080](
	[table_key] [bigint] IDENTITY(1,1) NOT NULL,
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
	[created_on_key] [bigint] NULL,
	[created_by_key] [bigint] NULL,
	[updated_on_key] [bigint] NULL,
	[updated_by_key] [bigint] NULL,
	[type_or_file_key] [bigint] NULL,
	[is_line_1] [bit] NULL,
 CONSTRAINT [PK_baleen_080] PRIMARY KEY CLUSTERED 
(
	[table_key] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [idx_line_1] ON [dbo].[baleen_080] 
(
	[is_line_1] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [idx_line_info] ON [dbo].[baleen_080] 
(
	[created_on_key] ASC,
	[created_by_key] ASC,
	[updated_on_key] ASC,
	[updated_by_key] ASC,
	[type_or_file_key] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[baleen_070]    Script Date: 01/28/2012 20:59:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[baleen_070](
	[table_key] [bigint] IDENTITY(1,1) NOT NULL,
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
	[created_on_key] [bigint] NULL,
	[created_by_key] [bigint] NULL,
	[updated_on_key] [bigint] NULL,
	[updated_by_key] [bigint] NULL,
	[type_or_file_key] [bigint] NULL,
	[is_line_1] [bit] NULL,
 CONSTRAINT [PK_baleen_070] PRIMARY KEY CLUSTERED 
(
	[table_key] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [idx_line_1] ON [dbo].[baleen_070] 
(
	[is_line_1] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [idx_line_info] ON [dbo].[baleen_070] 
(
	[created_on_key] ASC,
	[created_by_key] ASC,
	[updated_on_key] ASC,
	[updated_by_key] ASC,
	[type_or_file_key] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[baleen_060]    Script Date: 01/28/2012 20:59:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[baleen_060](
	[table_key] [bigint] IDENTITY(1,1) NOT NULL,
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
	[created_on_key] [bigint] NULL,
	[created_by_key] [bigint] NULL,
	[updated_on_key] [bigint] NULL,
	[updated_by_key] [bigint] NULL,
	[type_or_file_key] [bigint] NULL,
	[is_line_1] [bit] NULL,
 CONSTRAINT [PK_baleen_060] PRIMARY KEY CLUSTERED 
(
	[table_key] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [idx_line_1] ON [dbo].[baleen_060] 
(
	[is_line_1] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [idx_line_info] ON [dbo].[baleen_060] 
(
	[created_on_key] ASC,
	[created_by_key] ASC,
	[updated_on_key] ASC,
	[updated_by_key] ASC,
	[type_or_file_key] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[baleen_050]    Script Date: 01/28/2012 20:59:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[baleen_050](
	[table_key] [bigint] IDENTITY(1,1) NOT NULL,
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
	[created_on_key] [bigint] NULL,
	[created_by_key] [bigint] NULL,
	[updated_on_key] [bigint] NULL,
	[updated_by_key] [bigint] NULL,
	[type_or_file_key] [bigint] NULL,
	[is_line_1] [bit] NULL,
 CONSTRAINT [PK_baleen_050] PRIMARY KEY CLUSTERED 
(
	[table_key] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [idx_line_1] ON [dbo].[baleen_050] 
(
	[is_line_1] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [idx_line_info] ON [dbo].[baleen_050] 
(
	[created_on_key] ASC,
	[created_by_key] ASC,
	[updated_on_key] ASC,
	[updated_by_key] ASC,
	[type_or_file_key] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[baleen_040]    Script Date: 01/28/2012 20:59:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[baleen_040](
	[table_key] [bigint] IDENTITY(1,1) NOT NULL,
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
	[created_on_key] [bigint] NULL,
	[created_by_key] [bigint] NULL,
	[updated_on_key] [bigint] NULL,
	[updated_by_key] [bigint] NULL,
	[type_or_file_key] [bigint] NULL,
	[is_line_1] [bit] NULL,
 CONSTRAINT [PK_baleen_040] PRIMARY KEY CLUSTERED 
(
	[table_key] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [idx_line_1] ON [dbo].[baleen_040] 
(
	[is_line_1] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [idx_line_info] ON [dbo].[baleen_040] 
(
	[created_on_key] ASC,
	[created_by_key] ASC,
	[updated_on_key] ASC,
	[updated_by_key] ASC,
	[type_or_file_key] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[baleen_030]    Script Date: 01/28/2012 20:59:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[baleen_030](
	[table_key] [bigint] IDENTITY(1,1) NOT NULL,
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
	[created_on_key] [bigint] NULL,
	[created_by_key] [bigint] NULL,
	[updated_on_key] [bigint] NULL,
	[updated_by_key] [bigint] NULL,
	[type_or_file_key] [bigint] NULL,
	[is_line_1] [bit] NULL,
 CONSTRAINT [PK_baleen_030] PRIMARY KEY CLUSTERED 
(
	[table_key] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [idx_line_1] ON [dbo].[baleen_030] 
(
	[is_line_1] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [idx_line_info] ON [dbo].[baleen_030] 
(
	[created_on_key] ASC,
	[created_by_key] ASC,
	[updated_on_key] ASC,
	[updated_by_key] ASC,
	[type_or_file_key] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[baleen_020]    Script Date: 01/28/2012 20:59:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[baleen_020](
	[table_key] [bigint] IDENTITY(1,1) NOT NULL,
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
	[created_on_key] [bigint] NULL,
	[created_by_key] [bigint] NULL,
	[updated_on_key] [bigint] NULL,
	[updated_by_key] [bigint] NULL,
	[type_or_file_key] [bigint] NULL,
	[is_line_1] [bit] NULL,
 CONSTRAINT [PK_baleen_020] PRIMARY KEY CLUSTERED 
(
	[table_key] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [idx_line_1] ON [dbo].[baleen_020] 
(
	[is_line_1] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [idx_line_info] ON [dbo].[baleen_020] 
(
	[created_on_key] ASC,
	[created_by_key] ASC,
	[updated_on_key] ASC,
	[updated_by_key] ASC,
	[type_or_file_key] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[baleen_010]    Script Date: 01/28/2012 20:59:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[baleen_010](
	[table_key] [bigint] IDENTITY(1,1) NOT NULL,
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
	[created_on_key] [bigint] NULL,
	[created_by_key] [bigint] NULL,
	[updated_on_key] [bigint] NULL,
	[updated_by_key] [bigint] NULL,
	[type_or_file_key] [bigint] NULL,
	[is_line_1] [bit] NULL,
 CONSTRAINT [PK_baleen_010] PRIMARY KEY CLUSTERED 
(
	[table_key] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [idx_line_1] ON [dbo].[baleen_010] 
(
	[is_line_1] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [idx_line_info] ON [dbo].[baleen_010] 
(
	[created_on_key] ASC,
	[created_by_key] ASC,
	[updated_on_key] ASC,
	[updated_by_key] ASC,
	[type_or_file_key] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO
/****** Object:  Default [DF_dim_text_small_external_id]    Script Date: 01/28/2012 20:59:40 ******/
ALTER TABLE [dbo].[dim_text_small] ADD  CONSTRAINT [DF_dim_text_small_external_id]  DEFAULT (newid()) FOR [external_id]
GO
/****** Object:  Default [DF_baleen_200_is_line_1]    Script Date: 01/28/2012 20:59:40 ******/
ALTER TABLE [dbo].[baleen_200] ADD  CONSTRAINT [DF_baleen_200_is_line_1]  DEFAULT ((0)) FOR [is_line_1]
GO
/****** Object:  Default [DF_baleen_100_is_line_1]    Script Date: 01/28/2012 20:59:40 ******/
ALTER TABLE [dbo].[baleen_100] ADD  CONSTRAINT [DF_baleen_100_is_line_1]  DEFAULT ((0)) FOR [is_line_1]
GO
/****** Object:  Default [DF_baleen_090_is_line_1]    Script Date: 01/28/2012 20:59:40 ******/
ALTER TABLE [dbo].[baleen_090] ADD  CONSTRAINT [DF_baleen_090_is_line_1]  DEFAULT ((0)) FOR [is_line_1]
GO
/****** Object:  Default [DF_baleen_070_is_line_1]    Script Date: 01/28/2012 20:59:40 ******/
ALTER TABLE [dbo].[baleen_070] ADD  CONSTRAINT [DF_baleen_070_is_line_1]  DEFAULT ((0)) FOR [is_line_1]
GO
/****** Object:  Default [DF_baleen_060_is_line_1]    Script Date: 01/28/2012 20:59:40 ******/
ALTER TABLE [dbo].[baleen_060] ADD  CONSTRAINT [DF_baleen_060_is_line_1]  DEFAULT ((0)) FOR [is_line_1]
GO
/****** Object:  Default [DF_baleen_050_is_line_1]    Script Date: 01/28/2012 20:59:40 ******/
ALTER TABLE [dbo].[baleen_050] ADD  CONSTRAINT [DF_baleen_050_is_line_1]  DEFAULT ((0)) FOR [is_line_1]
GO
/****** Object:  Default [DF_baleen_040_is_line_1]    Script Date: 01/28/2012 20:59:40 ******/
ALTER TABLE [dbo].[baleen_040] ADD  CONSTRAINT [DF_baleen_040_is_line_1]  DEFAULT ((0)) FOR [is_line_1]
GO
/****** Object:  Default [DF_baleen_030_is_line_1]    Script Date: 01/28/2012 20:59:40 ******/
ALTER TABLE [dbo].[baleen_030] ADD  CONSTRAINT [DF_baleen_030_is_line_1]  DEFAULT ((0)) FOR [is_line_1]
GO
/****** Object:  Default [DF_baleen_020_is_line_1]    Script Date: 01/28/2012 20:59:40 ******/
ALTER TABLE [dbo].[baleen_020] ADD  CONSTRAINT [DF_baleen_020_is_line_1]  DEFAULT ((0)) FOR [is_line_1]
GO
/****** Object:  Default [DF_baleen_010_is_line_1]    Script Date: 01/28/2012 20:59:40 ******/
ALTER TABLE [dbo].[baleen_010] ADD  CONSTRAINT [DF_baleen_010_is_line_1]  DEFAULT ((0)) FOR [is_line_1]
GO
