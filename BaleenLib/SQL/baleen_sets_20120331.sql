--USE [baleen_sets_1]

--bulk insert [bset_object]
--from 'C:\TEST\OP_NPI\ORDERED_NPI\BALEEN_DATA\BSET_OBJECT.TAB'
--with
--(
--firstrow = 1
--)

USE [baleen_sets_1]
GO

/****** Object:  Table [dbo].[BSET_OBJECT]    Script Date: 04/01/2012 00:26:55 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

SET ANSI_PADDING ON
GO

CREATE TABLE [dbo].[BSET_OBJECT](
	[object_id] [bigint] NULL,
	[text_value] [varchar](550) NULL,
	[numeric_value] [float] NULL
) ON [PRIMARY]

GO

SET ANSI_PADDING OFF
GO

USE [baleen_sets_1]
GO

/****** Object:  Index [idx_bset_object]    Script Date: 04/01/2012 00:27:07 ******/
CREATE NONCLUSTERED INDEX [idx_bset_object] ON [dbo].[BSET_OBJECT] 
(
	[object_id] ASC,
	[text_value] ASC,
	[numeric_value] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO



