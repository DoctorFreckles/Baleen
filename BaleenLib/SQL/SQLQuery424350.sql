USE [BAL_VIEWS]
GO

/****** Object:  View [dbo].[BVW_BSET_GEN]    Script Date: 04/24/2012 20:10:13 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


ALTER view [dbo].[BVW_BSET_GEN]

as

SELECT     
	DATABASE_NAME, 
	TABLE_NAME, 
	OBJECT_NAME, 
	PREDICATE_NAME, 
	TYPE_SUFFIX, 
	TOTAL_CARDINALITY,
	0 as VIEW_FIELD_ORDER,
	UNIQUE_CARDINALITY,
	TOTAL_UNIQUENESS_SCORE,
	DATA_TYPE
FROM BSET_LIST 



GO


