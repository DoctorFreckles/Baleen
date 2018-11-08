SET NOCOUNT ON;

DECLARE @db_name nvarchar(100);
DECLARE @select_tables nvarchar(1000);

set @select_tables = 'SELECT
TABLE_NAME,  
DATA_TYPE, 
CHARACTER_MAXIMUM_LENGTH,  
CHARACTER_OCTET_LENGTH,  
NUMERIC_PRECISION,  
CHARACTER_SET_NAME,  
COLLATION_NAME  
FROM [<<DB>>].information_schema.COLUMNS 
where COLUMN_NAME = ''val'' and 
TABLE_NAME like ''BSET_%'' 
order by TABLE_NAME asc';

DECLARE db_cursor CURSOR FOR 
SELECT name
FROM sys.databases
where name like 'BAL_%';

OPEN db_cursor

FETCH NEXT FROM db_cursor 
INTO @db_name

WHILE @@FETCH_STATUS = 0
BEGIN
    PRINT @db_name

	declare @select_tables_loc nvarchar(1000);
	
	set @select_tables_loc = @select_tables;
	
	print @select_tables_loc;
	print '';
	print '';
    -- Declare an inner cursor based   
    -- on vendor_id from the outer cursor.

    --DECLARE product_cursor CURSOR FOR 
    --SELECT v.Name
    --FROM Purchasing.ProductVendor pv, Production.Product v
    --WHERE pv.ProductID = v.ProductID AND
    --pv.VendorID = @vendor_id  -- Variable value from the outer cursor

    --OPEN product_cursor
    --FETCH NEXT FROM product_cursor INTO @product

    --IF @@FETCH_STATUS <> 0 
    --    PRINT '         <<None>>'     

    --WHILE @@FETCH_STATUS = 0
    --BEGIN

    --    SELECT @message = '         ' + @product
    --    PRINT @message
    --    FETCH NEXT FROM product_cursor INTO @product
    --    END

    --CLOSE product_cursor
    --DEALLOCATE product_cursor
    --    -- Get the next vendor.
    FETCH NEXT FROM db_cursor 
    INTO @db_name
END 
CLOSE db_cursor;
DEALLOCATE db_cursor;