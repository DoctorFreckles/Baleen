create view vw_set_telephone_area_code
as
SELECT  SUBSTRING(common_dictionary.type_value,1,3) as [type_value], SUM(common_dictionary.cardinality) as cardinality
FROM         common_dictionary 
INNER JOIN
vw_type_uniqueness 
ON common_dictionary.type_name = vw_type_uniqueness.type_name
where common_dictionary.type_name like '%telephone number%'
group by SUBSTRING(common_dictionary.type_value,1,3)



