insert into dndx_provider_2.dbo.fact
SELECT      
	fact_npi_6.object_id, 
	dndx_dictionary.dbo.dmaster.dmaster_key, 
	fact_npi_6.created_on
FROM fact_npi_6 
INNER JOIN dict_npi_6 
ON fact_npi_6.dictionary_id = dict_npi_6.dictionary_id 
INNER JOIN dndx_dictionary.dbo.dmaster 
ON dict_npi_6.type_name = dndx_dictionary.dbo.dmaster.type_name 
AND 
dict_npi_6.type_value = dndx_dictionary.dbo.dmaster.type_value