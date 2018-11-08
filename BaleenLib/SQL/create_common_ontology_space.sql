--SELECT 
--	'dndx_npi_1' as database_name,  
--	'dict_npi_1' as table_name,   
--	dictionary_id, 
--	[type_name], 
--	type_value, 
--	cardinality, 
--	as_integer, 
--	as_double, 
--	as_year, 
--	as_month, 
--	as_day, 
--	as_hour, 
--	as_minute, 
--	as_second, 
--	as_millisecond
--into dndx_ontology.dbo.common_dictionary
--FROM    dndx_npi_1.dbo.dict_npi_1
--where cardinality >= 10

--insert into dndx_ontology.dbo.common_dictionary

--SELECT 
--	'dndx_npi_1' as database_name,  
--	'dict_npi_2' as table_name,   
--	dictionary_id, 
--	[type_name], 
--	type_value, 
--	cardinality, 
--	as_integer, 
--	as_double, 
--	as_year, 
--	as_month, 
--	as_day, 
--	as_hour, 
--	as_minute, 
--	as_second, 
--	as_millisecond,
--	null as parent_set

--FROM    dndx_npi_1.dbo.dict_npi_2
--where cardinality >= 10

--insert into dndx_ontology.dbo.common_dictionary

--SELECT 
--	'dndx_npi_1' as database_name,  
--	'dict_npi_3' as table_name,   
--	dictionary_id, 
--	[type_name], 
--	type_value, 
--	cardinality, 
--	as_integer, 
--	as_double, 
--	as_year, 
--	as_month, 
--	as_day, 
--	as_hour, 
--	as_minute, 
--	as_second, 
--	as_millisecond,
--	null as parent_set

--FROM    dndx_npi_1.dbo.dict_npi_3
--where cardinality >= 10

insert into dndx_ontology.dbo.common_dictionary

SELECT 
	'dndx_npi_3' as database_name,  
	'dict_npi_9' as table_name,   
	dictionary_id, 
	[type_name], 
	type_value, 
	cardinality, 
	as_integer, 
	as_double, 
	as_year, 
	as_month, 
	as_day, 
	as_hour, 
	as_minute, 
	as_second, 
	as_millisecond,
	null as parent_set

FROM    dndx_npi_3.dbo.dict_npi_9
where cardinality >= 10