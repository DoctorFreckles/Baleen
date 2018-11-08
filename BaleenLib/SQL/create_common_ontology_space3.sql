create view vw_type_uniqueness
as
SELECT     [type_name], COUNT(*) as type_cardinality
FROM         vw_master_dictionary_counts
group by [TYPE_NAME]
having COUNT(*) > 1 and COUNT(*) < 100
