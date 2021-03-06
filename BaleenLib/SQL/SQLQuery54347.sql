create view BVW_BSET_SHOW_WEB_META_1

as

SELECT distinct
replace(PARSENAME(REPLACE(table_name, '-', '.'), 2),'BVW_','') as DATABASE_NAME, 
PARSENAME(REPLACE(table_name, '-', '.'), 1) as OBJECT_NAME, 
            [TABLE_NAME]

  FROM [BAL_VIEWS].[dbo].[BVW_BSET_VIEW_META]
  
where not PARSENAME(REPLACE(table_name, '-', '.'), 2) is null