select 
       g.[database_name]
      ,g.[table_name]
      ,g.[dictionary_id]
      ,g.[type_value]
      ,g.[cardinality]
	  ,g.set_name
	  ,null as super_set
into common_sets
	  from
(
SELECT [database_name]
      ,[table_name]
      ,[dictionary_id]
      ,[type_value]
      ,[cardinality]
	  ,'city' as set_name
FROM [dndx_ontology].[dbo].[vw_set_city]
union

SELECT [database_name]
      ,[table_name]
      ,[dictionary_id]
      ,[type_value]
      ,[cardinality]
      ,'country_code' as set_name
  FROM [dndx_ontology].[dbo].[vw_set_country_code]
union

SELECT [database_name]
      ,[table_name]
      ,[dictionary_id]
      ,[type_value]
      ,[cardinality]
      ,'entity_type_code' as set_name
  FROM [dndx_ontology].[dbo].[vw_set_entity_type_code]
union

SELECT [database_name]
      ,[table_name]
      ,[dictionary_id]
      ,[type_value]
      ,[cardinality]
      ,'first_name' as set_name
  FROM [dndx_ontology].[dbo].[vw_set_first_name]
union

SELECT [database_name]
      ,[table_name]
      ,[dictionary_id]
      ,[type_value]
      ,[cardinality]
      ,'is_sole_proprieter' as set_name
  FROM [dndx_ontology].[dbo].[vw_set_is_sole_proprietor]
union

SELECT [database_name]
      ,[table_name]
      ,[dictionary_id]
      ,[type_value]
      ,[cardinality]
      ,'last_name' as set_name
  FROM [dndx_ontology].[dbo].[vw_set_last_name]
union

SELECT [database_name]
      ,[table_name]
      ,[dictionary_id]
      ,[type_value]
      ,[cardinality]
      ,'last_update_ym' as set_name
  FROM [dndx_ontology].[dbo].[vw_set_last_update_year_month]
union

SELECT [database_name]
      ,[table_name]
      ,[dictionary_id]
      ,[type_value]
      ,[cardinality]
      ,'npi_deactivation_ym' as set_name
  FROM [dndx_ontology].[dbo].[vw_set_npi_deactivation_year_month]
union

SELECT [database_name]
      ,[table_name]
      ,[dictionary_id]
      ,[type_value]
      ,[cardinality]
      ,'npi_reactivation_ym' as set_name
  FROM [dndx_ontology].[dbo].[vw_set_npi_reactivation_year_month]
union

SELECT [database_name]
      ,[table_name]
      ,[dictionary_id]
      ,[type_value]
      ,[cardinality]
      ,'official_title' as set_name
  FROM [dndx_ontology].[dbo].[vw_set_official_title]
union

SELECT [database_name]
      ,[table_name]
      ,[dictionary_id]
      ,[type_value]
      ,[cardinality]
      ,'postal_code' as set_name
  FROM [dndx_ontology].[dbo].[vw_set_postal_code]
union

SELECT [database_name]
      ,[table_name]
      ,[dictionary_id]
      ,[type_value]
      ,[cardinality]
      ,'primary_taxonomy_switch' as set_name
  FROM [dndx_ontology].[dbo].[vw_set_primary_taxonomy_switch]
union


SELECT [database_name]
      ,[table_name]
      ,[dictionary_id]
      ,[type_value]
      ,[cardinality]
      ,'provider_credential_text' as set_name
  FROM [dndx_ontology].[dbo].[vw_set_provider_credential_text]
union

SELECT [database_name]
      ,[table_name]
      ,[dictionary_id]
      ,[type_value]
      ,[cardinality]
      ,'provider_enumeration_ym' as set_name
  FROM [dndx_ontology].[dbo].[vw_set_provider_enumeration_year_month]
union

SELECT [database_name]
      ,[table_name]
      ,[dictionary_id]
      ,[type_value]
      ,[cardinality]
      ,'provider_gender_code' as set_name
  FROM [dndx_ontology].[dbo].[vw_set_provider_gender_code]
union

SELECT [database_name]
      ,[table_name]
      ,[dictionary_id]
      ,[type_value]
      ,[cardinality]
      ,'provider_license_state' as set_name
  FROM [dndx_ontology].[dbo].[vw_set_provider_license_state_code]
union


SELECT [database_name]
      ,[table_name]
      ,[dictionary_id]
      ,[type_value]
      ,[cardinality]
      ,'provider_name_prefix' as set_name
  FROM [dndx_ontology].[dbo].[vw_set_provider_name_prefix]
union



SELECT [database_name]
      ,[table_name]
      ,[dictionary_id]
      ,[type_value]
      ,[cardinality]
      ,'provider_taxonomy_group' as set_name
  FROM [dndx_ontology].[dbo].[vw_set_provider_taxonomy_group]
union

SELECT [database_name]
      ,[table_name]
      ,[dictionary_id]
      ,[type_value]
      ,[cardinality]
      ,'state_name' as set_name
  FROM [dndx_ontology].[dbo].[vw_set_state_name]
union

SELECT [database_name]
      ,[table_name]
      ,[dictionary_id]
      ,[type_value]
      ,[cardinality]
      ,'taxonomy' as set_name
  FROM [dndx_ontology].[dbo].[vw_set_taxonomy]
union

SELECT [database_name]
      ,[table_name]
      ,[dictionary_id]
      ,[type_value]
      ,[cardinality]
      ,'telephone_area_code' as set_name
  FROM [dndx_ontology].[dbo].[vw_set_telephone_area_code]
) g