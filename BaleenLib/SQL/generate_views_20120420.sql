
DECLARE @db_name nvarchar(200);
declare @ob_name nvarchar(200);

declare @from_part nvarchar(4000);

set @from_part = 'FROM [' + DBName + "." + OwnerName + ".[" + KeystoneTable + "] " + '\r' + '\n');

DECLARE db_cursor CURSOR FOR 
SELECT distinct 
	[DATABASE_NAME]
FROM [BAL_VIEWS].[dbo].[BSET_LIST];

OPEN db_cursor;

FETCH NEXT FROM db_cursor 
INTO @db_name;

WHILE @@FETCH_STATUS = 0
BEGIN
	print @db_name;

	declare @tb_name nvarchar(200);
	declare @pr_name nvarchar(200);
	
	DECLARE ob_cursor CURSOR FOR 
	SELECT distinct 
		[OBJECT_NAME]
	FROM [BAL_VIEWS].[dbo].[BSET_LIST]
	where [DATABASE_NAME] = @db_name;
	
	OPEN ob_cursor;

	FETCH NEXT FROM ob_cursor 
	INTO @ob_name;

	WHILE @@FETCH_STATUS = 0
	BEGIN
		print '---' + @ob_name
	
		DECLARE pr_cursor CURSOR FOR 
	    SELECT top 80
		[TABLE_NAME]
		,[PREDICATE_NAME]
		FROM [BAL_VIEWS].[dbo].[BSET_LIST]
		where [DATABASE_NAME] = @db_name
		and [OBJECT_NAME] = @ob_name
		order by [TOTAL_UNIQUENESS_SCORE] desc
	
		OPEN pr_cursor;

		FETCH NEXT FROM pr_cursor 
		INTO @tb_name, @pr_name;
	
		WHILE @@FETCH_STATUS = 0
		BEGIN
			print '----' + @pr_name
	
		    FETCH NEXT FROM pr_cursor 
			INTO @tb_name, @pr_name;
		end
		
		CLOSE pr_cursor;
		DEALLOCATE pr_cursor;
		
	    FETCH NEXT FROM ob_cursor 
		INTO @ob_name;
	end
	CLOSE ob_cursor;
	DEALLOCATE ob_cursor;
	
	--declare @select_tables_loc nvarchar(4000);
	--set @select_tables_loc = REPLACE(@select_tables,'<<DB>>',@db_name);
	--EXECUTE sp_executesql @select_tables_loc;
    FETCH NEXT FROM db_cursor 
    INTO @db_name;
END 
CLOSE db_cursor;
DEALLOCATE db_cursor;

--DECLARE meta_cursor CURSOR FOR 
--SELECT [DATABASE_NAME]
--      ,[TABLE_NAME]
--FROM [BAL_VIEWS].[dbo].[BSET_LIST]
--where not [table_name] like '%-TXTL';

--OPEN meta_cursor;

--declare @meta_db_name nvarchar(200);
--declare @meta_table_name nvarchar(200);
--declare @cardinality_update nvarchar(4000);
--declare @cardinality_update_temp nvarchar(4000);

--set @cardinality_update = '
--update BAL_VIEWS.dbo.bset_list
--set TOTAL_CARDINALITY =
--(
--SELECT COUNT(*) as Cardinality
--FROM [<<DB>>].[dbo].[<<TABLE>>]
--),
--UNIQUE_CARDINALITY = 
--(
--SELECT COUNT(*) as Cardinality
--FROM 
--(select distinct val from
-- [<<DB>>].[dbo].[<<TABLE>>]
--) as t)
--where
--DATABASE_NAME = ''<<DB>>'' and
--TABLE_NAME = ''<<TABLE>>''
--';

--FETCH NEXT FROM meta_cursor 
--INTO @meta_db_name, @meta_table_name;

--WHILE @@FETCH_STATUS = 0
--BEGIN
--	set @cardinality_update_temp =
--	REPLACE(REPLACE(@cardinality_update, '<<DB>>', @meta_db_name),'<<TABLE>>', @meta_table_name);
--	EXECUTE sp_executesql @cardinality_update_temp;	
--	FETCH NEXT FROM meta_cursor 
--	INTO @meta_db_name, @meta_table_name;
--END 
--CLOSE meta_cursor;
--DEALLOCATE meta_cursor;

--update [BAL_VIEWS].[dbo].[BSET_LIST]
--set UNIQUENESS_SCORE = cast(((UNIQUE_CARDINALITY/TOTAL_CARDINALITY) * 100) as float)
--where TOTAL_CARDINALITY > 0;

--update  otr
--set otr.TOTAL_UNIQUENESS_SCORE = 
--cast(((otr.UNIQUE_CARDINALITY/
--(SELECT max(sub.[TOTAL_CARDINALITY])
--FROM [BAL_VIEWS].[dbo].[BSET_LIST] sub
--where sub.DATABASE_NAME = otr.DATABASE_NAME
--and sub.OBJECT_NAME = otr.OBJECT_NAME
--group by sub.[DATABASE_NAME] ,sub.[OBJECT_NAME]  
--)) * 100) as float)
--from [BAL_VIEWS].[dbo].[BSET_LIST] otr
--where otr.UNIQUE_CARDINALITY > 0;

--DBCC SHRINKFILE (BAL_VIEWS_Log, 1);
--DBCC SHRINKFILE (BAL_VIEWS, 1);


--GO


