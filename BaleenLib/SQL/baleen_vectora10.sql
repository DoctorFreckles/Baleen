USE [master]
GO
/****** Object:  Database [<<DBTEMPLATE>>]    Script Date: 02/01/2012 05:45:05 ******/
CREATE DATABASE [<<DBTEMPLATE>>] ON  PRIMARY 
( NAME = N'<<DBTEMPLATE>>', FILENAME = N'<<DBFILEFOLDER>><<DBTEMPLATE>>.mdf' , SIZE = 4861312KB , MAXSIZE = UNLIMITED, FILEGROWTH = 20%)
 LOG ON 
( NAME = N'<<DBTEMPLATE>>_log', FILENAME = N'<<DBFILEFOLDER>><<DBTEMPLATE>>_log.ldf' , SIZE = 16576KB , MAXSIZE = 2048GB , FILEGROWTH = 10%)
GO
ALTER DATABASE [<<DBTEMPLATE>>] SET COMPATIBILITY_LEVEL = 100
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [<<DBTEMPLATE>>].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [<<DBTEMPLATE>>] SET ANSI_NULL_DEFAULT OFF
GO
ALTER DATABASE [<<DBTEMPLATE>>] SET ANSI_NULLS OFF
GO
ALTER DATABASE [<<DBTEMPLATE>>] SET ANSI_PADDING OFF
GO
ALTER DATABASE [<<DBTEMPLATE>>] SET ANSI_WARNINGS OFF
GO
ALTER DATABASE [<<DBTEMPLATE>>] SET ARITHABORT OFF
GO
ALTER DATABASE [<<DBTEMPLATE>>] SET AUTO_CLOSE ON
GO
ALTER DATABASE [<<DBTEMPLATE>>] SET AUTO_CREATE_STATISTICS ON
GO
ALTER DATABASE [<<DBTEMPLATE>>] SET AUTO_SHRINK OFF
GO
ALTER DATABASE [<<DBTEMPLATE>>] SET AUTO_UPDATE_STATISTICS ON
GO
ALTER DATABASE [<<DBTEMPLATE>>] SET CURSOR_CLOSE_ON_COMMIT OFF
GO
ALTER DATABASE [<<DBTEMPLATE>>] SET CURSOR_DEFAULT  GLOBAL
GO
ALTER DATABASE [<<DBTEMPLATE>>] SET CONCAT_NULL_YIELDS_NULL OFF
GO
ALTER DATABASE [<<DBTEMPLATE>>] SET NUMERIC_ROUNDABORT OFF
GO
ALTER DATABASE [<<DBTEMPLATE>>] SET QUOTED_IDENTIFIER OFF
GO
ALTER DATABASE [<<DBTEMPLATE>>] SET RECURSIVE_TRIGGERS OFF
GO
ALTER DATABASE [<<DBTEMPLATE>>] SET  DISABLE_BROKER
GO
ALTER DATABASE [<<DBTEMPLATE>>] SET AUTO_UPDATE_STATISTICS_ASYNC OFF
GO
ALTER DATABASE [<<DBTEMPLATE>>] SET DATE_CORRELATION_OPTIMIZATION OFF
GO
ALTER DATABASE [<<DBTEMPLATE>>] SET TRUSTWORTHY OFF
GO
ALTER DATABASE [<<DBTEMPLATE>>] SET ALLOW_SNAPSHOT_ISOLATION OFF
GO
ALTER DATABASE [<<DBTEMPLATE>>] SET PARAMETERIZATION SIMPLE
GO
ALTER DATABASE [<<DBTEMPLATE>>] SET READ_COMMITTED_SNAPSHOT OFF
GO
ALTER DATABASE [<<DBTEMPLATE>>] SET HONOR_BROKER_PRIORITY OFF
GO
ALTER DATABASE [<<DBTEMPLATE>>] SET  READ_WRITE
GO
ALTER DATABASE [<<DBTEMPLATE>>] SET RECOVERY SIMPLE
GO
ALTER DATABASE [<<DBTEMPLATE>>] SET  MULTI_USER
GO
ALTER DATABASE [<<DBTEMPLATE>>] SET PAGE_VERIFY CHECKSUM
GO
ALTER DATABASE [<<DBTEMPLATE>>] SET DB_CHAINING OFF
GO
USE [<<DBTEMPLATE>>]
GO
/****** Object:  Table [dbo].[dim_text_small]    Script Date: 02/01/2012 05:45:06 ******/
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
CREATE UNIQUE NONCLUSTERED INDEX [idx_text_small] ON [dbo].[dim_text_small] 
(
	[dim_value] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[dim_text_large]    Script Date: 02/01/2012 05:45:07 ******/
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
/****** Object:  Table [dbo].[dim_integer]    Script Date: 02/01/2012 05:45:07 ******/
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
CREATE UNIQUE NONCLUSTERED INDEX [idx_integer] ON [dbo].[dim_integer] 
(
	[dim_value] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[dim_float]    Script Date: 02/01/2012 05:45:07 ******/
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
CREATE UNIQUE NONCLUSTERED INDEX [idx_float] ON [dbo].[dim_float] 
(
	[dim_value] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[dim_datetime]    Script Date: 02/01/2012 05:45:07 ******/
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
CREATE UNIQUE NONCLUSTERED INDEX [idx_datetime] ON [dbo].[dim_datetime] 
(
	[dim_value] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[baleen_400]    Script Date: 02/01/2012 05:45:07 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[baleen_400](
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
	[a_200] [bigint] NULL,
	[a_201] [bigint] NULL,
	[a_202] [bigint] NULL,
	[a_203] [bigint] NULL,
	[a_204] [bigint] NULL,
	[a_205] [bigint] NULL,
	[a_206] [bigint] NULL,
	[a_207] [bigint] NULL,
	[a_208] [bigint] NULL,
	[a_209] [bigint] NULL,
	[a_210] [bigint] NULL,
	[a_211] [bigint] NULL,
	[a_212] [bigint] NULL,
	[a_213] [bigint] NULL,
	[a_214] [bigint] NULL,
	[a_215] [bigint] NULL,
	[a_216] [bigint] NULL,
	[a_217] [bigint] NULL,
	[a_218] [bigint] NULL,
	[a_219] [bigint] NULL,
	[a_220] [bigint] NULL,
	[a_221] [bigint] NULL,
	[a_222] [bigint] NULL,
	[a_223] [bigint] NULL,
	[a_224] [bigint] NULL,
	[a_225] [bigint] NULL,
	[a_226] [bigint] NULL,
	[a_227] [bigint] NULL,
	[a_228] [bigint] NULL,
	[a_229] [bigint] NULL,
	[a_230] [bigint] NULL,
	[a_231] [bigint] NULL,
	[a_232] [bigint] NULL,
	[a_233] [bigint] NULL,
	[a_234] [bigint] NULL,
	[a_235] [bigint] NULL,
	[a_236] [bigint] NULL,
	[a_237] [bigint] NULL,
	[a_238] [bigint] NULL,
	[a_239] [bigint] NULL,
	[a_240] [bigint] NULL,
	[a_241] [bigint] NULL,
	[a_242] [bigint] NULL,
	[a_243] [bigint] NULL,
	[a_244] [bigint] NULL,
	[a_245] [bigint] NULL,
	[a_246] [bigint] NULL,
	[a_247] [bigint] NULL,
	[a_248] [bigint] NULL,
	[a_249] [bigint] NULL,
	[a_250] [bigint] NULL,
	[a_251] [bigint] NULL,
	[a_252] [bigint] NULL,
	[a_253] [bigint] NULL,
	[a_254] [bigint] NULL,
	[a_255] [bigint] NULL,
	[a_256] [bigint] NULL,
	[a_257] [bigint] NULL,
	[a_258] [bigint] NULL,
	[a_259] [bigint] NULL,
	[a_260] [bigint] NULL,
	[a_261] [bigint] NULL,
	[a_262] [bigint] NULL,
	[a_263] [bigint] NULL,
	[a_264] [bigint] NULL,
	[a_265] [bigint] NULL,
	[a_266] [bigint] NULL,
	[a_267] [bigint] NULL,
	[a_268] [bigint] NULL,
	[a_269] [bigint] NULL,
	[a_270] [bigint] NULL,
	[a_271] [bigint] NULL,
	[a_272] [bigint] NULL,
	[a_273] [bigint] NULL,
	[a_274] [bigint] NULL,
	[a_275] [bigint] NULL,
	[a_276] [bigint] NULL,
	[a_277] [bigint] NULL,
	[a_278] [bigint] NULL,
	[a_279] [bigint] NULL,
	[a_280] [bigint] NULL,
	[a_281] [bigint] NULL,
	[a_282] [bigint] NULL,
	[a_283] [bigint] NULL,
	[a_284] [bigint] NULL,
	[a_285] [bigint] NULL,
	[a_286] [bigint] NULL,
	[a_287] [bigint] NULL,
	[a_288] [bigint] NULL,
	[a_289] [bigint] NULL,
	[a_290] [bigint] NULL,
	[a_291] [bigint] NULL,
	[a_292] [bigint] NULL,
	[a_293] [bigint] NULL,
	[a_294] [bigint] NULL,
	[a_295] [bigint] NULL,
	[a_296] [bigint] NULL,
	[a_297] [bigint] NULL,
	[a_298] [bigint] NULL,
	[a_299] [bigint] NULL,
	[a_300] [bigint] NULL,
	[a_301] [bigint] NULL,
	[a_302] [bigint] NULL,
	[a_303] [bigint] NULL,
	[a_304] [bigint] NULL,
	[a_305] [bigint] NULL,
	[a_306] [bigint] NULL,
	[a_307] [bigint] NULL,
	[a_308] [bigint] NULL,
	[a_309] [bigint] NULL,
	[a_310] [bigint] NULL,
	[a_311] [bigint] NULL,
	[a_312] [bigint] NULL,
	[a_313] [bigint] NULL,
	[a_314] [bigint] NULL,
	[a_315] [bigint] NULL,
	[a_316] [bigint] NULL,
	[a_317] [bigint] NULL,
	[a_318] [bigint] NULL,
	[a_319] [bigint] NULL,
	[a_320] [bigint] NULL,
	[a_321] [bigint] NULL,
	[a_322] [bigint] NULL,
	[a_323] [bigint] NULL,
	[a_324] [bigint] NULL,
	[a_325] [bigint] NULL,
	[a_326] [bigint] NULL,
	[a_327] [bigint] NULL,
	[a_328] [bigint] NULL,
	[a_329] [bigint] NULL,
	[a_330] [bigint] NULL,
	[a_331] [bigint] NULL,
	[a_332] [bigint] NULL,
	[a_333] [bigint] NULL,
	[a_334] [bigint] NULL,
	[a_335] [bigint] NULL,
	[a_336] [bigint] NULL,
	[a_337] [bigint] NULL,
	[a_338] [bigint] NULL,
	[a_339] [bigint] NULL,
	[a_340] [bigint] NULL,
	[a_341] [bigint] NULL,
	[a_342] [bigint] NULL,
	[a_343] [bigint] NULL,
	[a_344] [bigint] NULL,
	[a_345] [bigint] NULL,
	[a_346] [bigint] NULL,
	[a_347] [bigint] NULL,
	[a_348] [bigint] NULL,
	[a_349] [bigint] NULL,
	[a_350] [bigint] NULL,
	[a_351] [bigint] NULL,
	[a_352] [bigint] NULL,
	[a_353] [bigint] NULL,
	[a_354] [bigint] NULL,
	[a_355] [bigint] NULL,
	[a_356] [bigint] NULL,
	[a_357] [bigint] NULL,
	[a_358] [bigint] NULL,
	[a_359] [bigint] NULL,
	[a_360] [bigint] NULL,
	[a_361] [bigint] NULL,
	[a_362] [bigint] NULL,
	[a_363] [bigint] NULL,
	[a_364] [bigint] NULL,
	[a_365] [bigint] NULL,
	[a_366] [bigint] NULL,
	[a_367] [bigint] NULL,
	[a_368] [bigint] NULL,
	[a_369] [bigint] NULL,
	[a_370] [bigint] NULL,
	[a_371] [bigint] NULL,
	[a_372] [bigint] NULL,
	[a_373] [bigint] NULL,
	[a_374] [bigint] NULL,
	[a_375] [bigint] NULL,
	[a_376] [bigint] NULL,
	[a_377] [bigint] NULL,
	[a_378] [bigint] NULL,
	[a_379] [bigint] NULL,
	[a_380] [bigint] NULL,
	[a_381] [bigint] NULL,
	[a_382] [bigint] NULL,
	[a_383] [bigint] NULL,
	[a_384] [bigint] NULL,
	[a_385] [bigint] NULL,
	[a_386] [bigint] NULL,
	[a_387] [bigint] NULL,
	[a_388] [bigint] NULL,
	[a_389] [bigint] NULL,
	[a_390] [bigint] NULL,
	[a_391] [bigint] NULL,
	[a_392] [bigint] NULL,
	[a_393] [bigint] NULL,
	[a_394] [bigint] NULL,
	[a_395] [bigint] NULL,
	[a_396] [bigint] NULL,
	[a_397] [bigint] NULL,
	[a_398] [bigint] NULL,
	[a_399] [bigint] NULL,
	[created_on_key] [bigint] NULL,
	[created_by_key] [bigint] NULL,
	[updated_on_key] [bigint] NULL,
	[updated_by_key] [bigint] NULL,
	[type_or_file_key] [bigint] NULL,
	[is_line_1] [bit] NULL,
 CONSTRAINT [PK_baleen_400] PRIMARY KEY CLUSTERED 
(
	[table_key] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[baleen_200]    Script Date: 02/01/2012 05:45:07 ******/
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
/****** Object:  Table [dbo].[baleen_100]    Script Date: 02/01/2012 05:45:07 ******/
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
/****** Object:  Table [dbo].[baleen_090]    Script Date: 02/01/2012 05:45:07 ******/
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
/****** Object:  Table [dbo].[baleen_080]    Script Date: 02/01/2012 05:45:07 ******/
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
/****** Object:  Table [dbo].[baleen_070]    Script Date: 02/01/2012 05:45:07 ******/
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
/****** Object:  Table [dbo].[baleen_060]    Script Date: 02/01/2012 05:45:07 ******/
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
/****** Object:  Table [dbo].[baleen_050]    Script Date: 02/01/2012 05:45:07 ******/
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
/****** Object:  Table [dbo].[baleen_040]    Script Date: 02/01/2012 05:45:07 ******/
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
/****** Object:  Table [dbo].[baleen_030]    Script Date: 02/01/2012 05:45:07 ******/
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
/****** Object:  Table [dbo].[baleen_020]    Script Date: 02/01/2012 05:45:07 ******/
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
/****** Object:  Table [dbo].[baleen_010]    Script Date: 02/01/2012 05:45:07 ******/
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
/****** Object:  Default [DF_baleen_400_is_line_1]    Script Date: 02/01/2012 05:45:07 ******/
ALTER TABLE [dbo].[baleen_400] ADD  CONSTRAINT [DF_baleen_400_is_line_1]  DEFAULT ((0)) FOR [is_line_1]
GO
/****** Object:  Default [DF_baleen_200_is_line_1]    Script Date: 02/01/2012 05:45:07 ******/
ALTER TABLE [dbo].[baleen_200] ADD  CONSTRAINT [DF_baleen_200_is_line_1]  DEFAULT ((0)) FOR [is_line_1]
GO
/****** Object:  Default [DF_baleen_100_is_line_1]    Script Date: 02/01/2012 05:45:07 ******/
ALTER TABLE [dbo].[baleen_100] ADD  CONSTRAINT [DF_baleen_100_is_line_1]  DEFAULT ((0)) FOR [is_line_1]
GO
/****** Object:  Default [DF_baleen_090_is_line_1]    Script Date: 02/01/2012 05:45:07 ******/
ALTER TABLE [dbo].[baleen_090] ADD  CONSTRAINT [DF_baleen_090_is_line_1]  DEFAULT ((0)) FOR [is_line_1]
GO
/****** Object:  Default [DF_baleen_070_is_line_1]    Script Date: 02/01/2012 05:45:07 ******/
ALTER TABLE [dbo].[baleen_070] ADD  CONSTRAINT [DF_baleen_070_is_line_1]  DEFAULT ((0)) FOR [is_line_1]
GO
/****** Object:  Default [DF_baleen_060_is_line_1]    Script Date: 02/01/2012 05:45:07 ******/
ALTER TABLE [dbo].[baleen_060] ADD  CONSTRAINT [DF_baleen_060_is_line_1]  DEFAULT ((0)) FOR [is_line_1]
GO
/****** Object:  Default [DF_baleen_050_is_line_1]    Script Date: 02/01/2012 05:45:07 ******/
ALTER TABLE [dbo].[baleen_050] ADD  CONSTRAINT [DF_baleen_050_is_line_1]  DEFAULT ((0)) FOR [is_line_1]
GO
/****** Object:  Default [DF_baleen_040_is_line_1]    Script Date: 02/01/2012 05:45:07 ******/
ALTER TABLE [dbo].[baleen_040] ADD  CONSTRAINT [DF_baleen_040_is_line_1]  DEFAULT ((0)) FOR [is_line_1]
GO
/****** Object:  Default [DF_baleen_030_is_line_1]    Script Date: 02/01/2012 05:45:07 ******/
ALTER TABLE [dbo].[baleen_030] ADD  CONSTRAINT [DF_baleen_030_is_line_1]  DEFAULT ((0)) FOR [is_line_1]
GO
/****** Object:  Default [DF_baleen_020_is_line_1]    Script Date: 02/01/2012 05:45:07 ******/
ALTER TABLE [dbo].[baleen_020] ADD  CONSTRAINT [DF_baleen_020_is_line_1]  DEFAULT ((0)) FOR [is_line_1]
GO
/****** Object:  Default [DF_baleen_010_is_line_1]    Script Date: 02/01/2012 05:45:07 ******/
ALTER TABLE [dbo].[baleen_010] ADD  CONSTRAINT [DF_baleen_010_is_line_1]  DEFAULT ((0)) FOR [is_line_1]
GO
