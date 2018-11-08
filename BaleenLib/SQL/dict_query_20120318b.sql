--create view vw_set_state_name
--as
select type_value, SUM(cardinality) as cardinality
from
(
SELECT type_value, SUM(cardinality) as cardinality
FROM         dict_npi_1
where type_name like '%state name%'
group by type_value
union
SELECT type_value, SUM(cardinality) as cardinality
FROM         dict_npi_2
where type_name like '%state name%'
group by type_value
union
SELECT type_value, SUM(cardinality) as cardinality
FROM         dict_npi_3
where type_name like '%state name%'
group by type_value
) g
group by type_value
order by cardinality desc


