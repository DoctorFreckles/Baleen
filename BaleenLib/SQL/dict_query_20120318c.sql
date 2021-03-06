create view vw_search_gender
as
SELECT '1' as db, '1' as tbl, [dictionary_id]
      ,[type_value]
      ,[cardinality]
FROM [dndx_npi_1].[dbo].[dict_npi_1]
where [TYPE_NAME] = 'provider gender code'
union
SELECT '1' as db, '2' as tbl, [dictionary_id]
      ,[type_value]
      ,[cardinality]
FROM [dndx_npi_1].[dbo].[dict_npi_2]
where [TYPE_NAME] = 'provider gender code'
union
SELECT '1' as db, '3' as tbl, [dictionary_id]
      ,[type_value]
      ,[cardinality]
FROM [dndx_npi_1].[dbo].[dict_npi_3]
where [TYPE_NAME] = 'provider gender code'
union
SELECT '2' as db, '4' as tbl, [dictionary_id]
      ,[type_value]
      ,[cardinality]
FROM [dndx_npi_2].[dbo].[dict_npi_4]
where [TYPE_NAME] = 'provider gender code'
union
SELECT '2' as db, '5' as tbl, [dictionary_id]
      ,[type_value]
      ,[cardinality]
FROM [dndx_npi_2].[dbo].[dict_npi_5]
where [TYPE_NAME] = 'provider gender code'
union
SELECT '2' as db, '6' as tbl, [dictionary_id]
      ,[type_value]
      ,[cardinality]
FROM [dndx_npi_2].[dbo].[dict_npi_6]
where [TYPE_NAME] = 'provider gender code'

union
SELECT '3' as db, '7' as tbl, [dictionary_id]
      ,[type_value]
      ,[cardinality]
FROM [dndx_npi_3].[dbo].[dict_npi_7]
where [TYPE_NAME] = 'provider gender code'
union
SELECT '3' as db, '8' as tbl, [dictionary_id]
      ,[type_value]
      ,[cardinality]
FROM [dndx_npi_3].[dbo].[dict_npi_8]
where [TYPE_NAME] = 'provider gender code'
union
SELECT '3' as db, '9' as tbl, [dictionary_id]
      ,[type_value]
      ,[cardinality]
FROM [dndx_npi_3].[dbo].[dict_npi_9]
where [TYPE_NAME] = 'provider gender code'