--USE [BLNS_PROVIDER_RESEARCH]
--GO

--/****** Object:  View [dbo].[BVWX_ENUMERATION_DATE_TAXONOMY]    Script Date: 04/01/2012 20:23:18 ******/
--SET ANSI_NULLS ON
--GO

--SET QUOTED_IDENTIFIER ON
--GO

create view [dbo].[BVWCU_ENUMERATION_DATE_TAXONOMY_GENDER]
as
SELECT     FLOOR([BSET_NPI-PROVIDER_ENUMERATION_DATE].as_number / 100000000) AS Enumeration_YYYYMM, 
[BSET_NPI-HEALTHCARE_PROVIDER_TAXONOMY_CODE_1].as_small_text AS Taxonomy, 
[BSET_NPI-PROVIDER_GENDER_CODE].as_small_text as Gender,
COUNT(*) AS Cardinality

FROM         [BSET_NPI-PROVIDER_ENUMERATION_DATE] LEFT OUTER JOIN
                      [BSET_NPI-PROVIDER_GENDER_CODE] ON 
                      [BSET_NPI-PROVIDER_ENUMERATION_DATE].object_key = [BSET_NPI-PROVIDER_GENDER_CODE].object_key LEFT OUTER JOIN
                      [BSET_NPI-HEALTHCARE_PROVIDER_TAXONOMY_CODE_1] ON 
                      [BSET_NPI-PROVIDER_ENUMERATION_DATE].object_key = [BSET_NPI-HEALTHCARE_PROVIDER_TAXONOMY_CODE_1].object_key
GROUP BY FLOOR([BSET_NPI-PROVIDER_ENUMERATION_DATE].as_number / 100000000), [BSET_NPI-HEALTHCARE_PROVIDER_TAXONOMY_CODE_1].as_small_text, 
                      [BSET_NPI-PROVIDER_GENDER_CODE].as_small_text
--GO

