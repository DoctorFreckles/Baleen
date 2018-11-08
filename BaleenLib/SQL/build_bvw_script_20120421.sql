USE [BAL_VIEWS]
GO

/****** Object:  StoredProcedure [dbo].[bproc_generate_view_columns]    Script Date: 04/21/2012 08:02:32 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


ALTER procedure [dbo].[bproc_generate_view_columns]

as

IF EXISTS (
SELECT 1 FROM INFORMATION_SCHEMA.TABLES
WHERE TABLE_NAME = 'BSET_VIEWS' AND TABLE_SCHEMA = 'DBO'
)
BEGIN
	DROP TABLE [BAL_VIEWS].[dbo].[BSET_VIEWS];
END

CREATE TABLE [dbo].[BSET_VIEWS](
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
	[COLLATION_NAME] [nvarchar](200) NULL
) ON [PRIMARY];

DECLARE @db_name nvarchar(100);
DECLARE @select_tables nvarchar(4000);

set @select_tables = '
insert into BAL_VIEWS.dbo.bset_views
SELECT
getdate() as CREATED_ON,
''BAL_VIEWS'' as DATABASE_NAME,
TABLE_NAME,
DATA_TYPE, 
PARSENAME(REPLACE(table_name, ''-'', ''.''), 3), 
PARSENAME(REPLACE(table_name, ''-'', ''.''), 2),             
PARSENAME(REPLACE(table_name, ''-'', ''.''), 1), 
CHARACTER_MAXIMUM_LENGTH,  
CHARACTER_OCTET_LENGTH,  
NUMERIC_PRECISION,  
CHARACTER_SET_NAME,  
COLLATION_NAME
FROM [<<DB>>].information_schema.COLUMNS 
where COLUMN_NAME = ''val'' and 
TABLE_NAME like ''BVW_%'' 
order by TABLE_NAME asc';

DECLARE db_cursor CURSOR FOR 
SELECT name
FROM sys.databases
where name = 'BAL_VIEWS';

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

DBCC SHRINKFILE (BAL_VIEWS_Log, 1);
DBCC SHRINKFILE (BAL_VIEWS, 1);






GO


