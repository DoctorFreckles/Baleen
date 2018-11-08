alter view BVW_BSET_GEN

as

SELECT     
	DATABASE_NAME, 
	TABLE_NAME, 
	OBJECT_NAME, 
	PREDICATE_NAME, 
	TYPE_SUFFIX, 
	TOTAL_CARDINALITY,
	'INCLUDE' as VIEW_GEN_TYPE
FROM BSET_LIST 
