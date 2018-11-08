--SELECT distinct f.[object_id]
--      ,f.[dictionary_id]
--FROM [dndx_npi_1].[dbo].[fact_npi_1] f
--inner join dndx_ontology.dbo.common_dictionary cd
--on f.dictionary_id = cd.dictionary_id
--where
--cd.database_name = 'dndx_npi_1'
--and
--cd.table_name = 'dict_npi_1'


--create view vw_master_dictionary_counts
--as
--SELECT     [type_name], type_value, sum(cardinality) as Cardinality
--FROM         common_dictionary
--group by [type_name], type_value

