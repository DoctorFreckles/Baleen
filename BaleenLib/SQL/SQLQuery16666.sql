/****** Script for SelectTopNRows command from SSMS  ******/
SELECT TOP 1000 [DATABASE_NAME]
      ,[TABLE_NAME]
      ,[OBJECT_NAME]
      ,[PREDICATE_NAME]
      ,[TYPE_SUFFIX]
      ,[TOTAL_CARDINALITY]
      ,[VIEW_GEN_TYPE]
  FROM [BAL_VIEWS].[dbo].[BVW_BSET_GEN]
  order by OBJECT_NAME asc, total_cardinality desc