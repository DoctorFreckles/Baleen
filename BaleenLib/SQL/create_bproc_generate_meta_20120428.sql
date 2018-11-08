USE [BAL_VIEWS]
GO

/****** Object:  StoredProcedure [dbo].[bproc_generate_meta]    Script Date: 04/28/2012 10:57:37 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

create procedure [dbo].[bproc_generate_meta]

as

IF EXISTS (
SELECT 1 FROM INFORMATION_SCHEMA.TABLES
WHERE TABLE_NAME = 'BSET_LIST' AND TABLE_SCHEMA = 'DBO'
)
BEGIN
	DROP TABLE [BAL_VIEWS].[dbo].[BSET_LIST];
END

CREATE TABLE [dbo].[BSET_LIST](
	[CREATED_ON] [datetime] NOT NULL,
	[DATABASE_NAME] [nvarchar](200) NOT NULL,
	[TABLE_NAME] [nvarchar](200) NOT NULL,
	[DATA_TYPE] [nvarchar](200) NULL,
	[OBJECT_NAME] [nvarchar](200) null,
	[PREDICATE_NAME] [nvarchar](200) null,
	[TYPE_SUFFIX] [nvarchar](100) null,
	[CHARACTER_MAXIMUM_LENGTH] [bigint] NULL,
	[CHARACTER_OCTET_LENGTH] [bigint] NULL,
	[NUMERIC_PRECISION] [int] NULL,
	[CHARACTER_SET_NAME] [nvarchar](200) NULL,
	[COLLATION_NAME] [nvarchar](200) NULL,
	[TOTAL_CARDINALITY] [float] NULL,
	[UNIQUE_CARDINALITY] [float] NULL,
	[UNIQUENESS_SCORE] [float] NULL,
	[TOTAL_UNIQUENESS_SCORE] [float] null

) ON [PRIMARY];

DECLARE @db_name nvarchar(100);
DECLARE @select_tables nvarchar(4000);

set @select_tables = '
insert into BAL_VIEWS.dbo.bset_list
SELECT
getdate() as CREATED_ON,
''<<DB>>'' as DATABASE_NAME,
TABLE_NAME,
DATA_TYPE, 
PARSENAME(REPLACE(table_name, ''-'', ''.''), 3), 
PARSENAME(REPLACE(table_name, ''-'', ''.''), 2),             
PARSENAME(REPLACE(table_name, ''-'', ''.''), 1), 
CHARACTER_MAXIMUM_LENGTH,  
CHARACTER_OCTET_LENGTH,  
NUMERIC_PRECISION,  
CHARACTER_SET_NAME,  
COLLATION_NAME,
cast(0 as float) as TOTAL_CARDINALITY,
cast(0 as float) as UNIQUE_CARDINALITY,
cast(0 as int) as UNIQUENESS_SCORE,
cast(0 as int) as TOTAL_UNIQUENESS_SCORE
FROM [<<DB>>].information_schema.COLUMNS 
where COLUMN_NAME = ''val'' and 
TABLE_NAME like ''BSET_%'' 
order by TABLE_NAME asc';

DECLARE db_cursor CURSOR FOR 
SELECT name
FROM sys.databases
where name like 'BAL_%';

OPEN db_cursor;

FETCH NEXT FROM db_cursor 
INTO @db_name;

WHILE @@FETCH_STATUS = 0
BEGIN
	declare @select_tables_loc nvarchar(4000);
	set @select_tables_loc = REPLACE(@select_tables,'<<DB>>',@db_name);
	EXECUTE sp_executesql @select_tables_loc;
    FETCH NEXT FROM db_cursor 
    INTO @db_name;
END 
CLOSE db_cursor;
DEALLOCATE db_cursor;

DECLARE meta_cursor CURSOR FOR 
SELECT [DATABASE_NAME]
      ,[TABLE_NAME]
FROM [BAL_VIEWS].[dbo].[BSET_LIST]
where not [table_name] like '%-TXTL';

OPEN meta_cursor;

declare @meta_db_name nvarchar(200);
declare @meta_table_name nvarchar(200);
declare @cardinality_update nvarchar(4000);
declare @cardinality_update_temp nvarchar(4000);

set @cardinality_update = '
update BAL_VIEWS.dbo.bset_list
set TOTAL_CARDINALITY =
(
SELECT COUNT(*) as Cardinality
FROM [<<DB>>].[dbo].[<<TABLE>>]
),
UNIQUE_CARDINALITY = 
(
SELECT COUNT(*) as Cardinality
FROM 
(select distinct val from
 [<<DB>>].[dbo].[<<TABLE>>]
) as t)
where
DATABASE_NAME = ''<<DB>>'' and
TABLE_NAME = ''<<TABLE>>''
';

FETCH NEXT FROM meta_cursor 
INTO @meta_db_name, @meta_table_name;

WHILE @@FETCH_STATUS = 0
BEGIN
	set @cardinality_update_temp =
	REPLACE(REPLACE(@cardinality_update, '<<DB>>', @meta_db_name),'<<TABLE>>', @meta_table_name);
	EXECUTE sp_executesql @cardinality_update_temp;	
	FETCH NEXT FROM meta_cursor 
	INTO @meta_db_name, @meta_table_name;
END 
CLOSE meta_cursor;
DEALLOCATE meta_cursor;

update [BAL_VIEWS].[dbo].[BSET_LIST]
set UNIQUENESS_SCORE = cast(((UNIQUE_CARDINALITY/TOTAL_CARDINALITY) * 100) as float)
where TOTAL_CARDINALITY > 0;

update  otr
set otr.TOTAL_UNIQUENESS_SCORE = 
cast(((otr.UNIQUE_CARDINALITY/
(SELECT max(sub.[TOTAL_CARDINALITY])
FROM [BAL_VIEWS].[dbo].[BSET_LIST] sub
where sub.DATABASE_NAME = otr.DATABASE_NAME
and sub.OBJECT_NAME = otr.OBJECT_NAME
group by sub.[DATABASE_NAME] ,sub.[OBJECT_NAME]  
)) * 100) as float)
from [BAL_VIEWS].[dbo].[BSET_LIST] otr
where otr.UNIQUE_CARDINALITY > 0;

DBCC SHRINKFILE (BAL_VIEWS_Log, 1);
DBCC SHRINKFILE (BAL_VIEWS, 1);





GO


