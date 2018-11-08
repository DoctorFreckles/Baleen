select * from dndx_npi_1.dbo.fact_npi_1 s2
inner join dndx_npi_1.dbo.dict_npi_1 s3
on s2.dictionary_id = s3.dictionary_id
inner join 
(select [OBJECT_ID], COUNT(*) as cnt
from dndx_npi_1.dbo.fact_npi_1
where dictionary_id in
(
select dictionary_id from dndx_npi_1.dbo.dict_npi_1
where 
(type_value like '%orthopedic%' and LEN(type_value) < 12)

 OR 
(type_value like '%orthopedic%' and LEN(type_value) < 12)

 OR 
(type_value like '%johnson%' and LEN(type_value) < 9)

 OR 
(type_value like '%seattle%' and LEN(type_value) < 9)

 OR 
(type_value like '%wa%' and LEN(type_value) < 4)
)
group by [object_id]) s1
on s1.object_id = s2.object_id

where s1.cnt > (5-1)
order by s1.cnt desc, s1.object_id, s3.type_name asc
