--truncate table predicate_npi_1
--truncate table fact_npi_1

--bulk insert predicate_npi_1
--from 'C:\test\op_npi\ordered_npi\b1096dee-c4ac-4b81-b607-0db38f5243f3_1.dict'
--with
--(
--firstrow = 1
--)

--bulk insert fact_npi_1
--from 'C:\test\op_npi\ordered_npi\b1096dee-c4ac-4b81-b607-0db38f5243f3_1.fact'
--with
--(
--firstrow = 1
--)