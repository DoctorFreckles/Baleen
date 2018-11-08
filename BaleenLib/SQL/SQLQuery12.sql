create view vw_provider_list
as
SELECT      baltb_npi_1.NPI_PK AS NPI, dim_text.dim_value AS OrgName, dim_text_1.dim_value AS LastName, dim_text_2.dim_value AS FirstName, 
                      dim_text_3.dim_value AS MiddleName, dim_text_4.dim_value AS Prefix, dim_text_5.dim_value AS Suffix, dim_text_6.dim_value AS ProfCredentials, 
                      dim_text_7.dim_value AS AddressLine1, dim_text_8.dim_value AS AddressLine2, dim_text_9.dim_value AS City, dim_text_10.dim_value AS StateOrProvince, 
                      dim_text_11.dim_value AS PostalCode, dim_text_12.dim_value AS Gender, dim_text_13.dim_value AS Taxonomy1, dim_text_14.dim_value AS Taxonomy2, 
                      
                      taxonomy_code.Type as TaxType1, 
                      taxonomy_code.Classification as TaxClass1, 
                      taxonomy_code.Specialization as TaxSpecialization1, 
                      taxonomy_code.Definition as TaxDefinition1, 
                      taxonomy_code.Notes as TaxNotes1, 
                      taxonomy_code_1.Type AS TaxType2, 
                      taxonomy_code_1.Classification AS TaxClass2, 
                      taxonomy_code_1.Specialization AS TaxSpecialization2, 
                      taxonomy_code_1.Definition AS TaxDefinition2, 
                      taxonomy_code_1.Notes AS TaxNotes2
FROM         dim_text AS dim_text_10 RIGHT OUTER JOIN
                      taxonomy_code AS taxonomy_code_1 RIGHT OUTER JOIN
                      dim_text AS dim_text_14 ON taxonomy_code_1.Code = dim_text_14.dim_value RIGHT OUTER JOIN
                      baltb_npi_1 ON dim_text_14.dim_key = baltb_npi_1.HEALTHCARE_PROVIDER_TAXONOMY_CODE_2 ON 
                      dim_text_10.dim_key = baltb_npi_1.PROVIDER_BUSINESS_PRACTICE_LOCATION_ADDRESS_STATE_NAME LEFT OUTER JOIN
                      taxonomy_code LEFT OUTER JOIN
                      dim_text AS dim_text_13 ON taxonomy_code.Code = dim_text_13.dim_value ON 
                      baltb_npi_1.HEALTHCARE_PROVIDER_TAXONOMY_CODE_1 = dim_text_13.dim_key LEFT OUTER JOIN
                      dim_text AS dim_text_12 ON baltb_npi_1.PROVIDER_GENDER_CODE = dim_text_12.dim_key LEFT OUTER JOIN
                      dim_text AS dim_text_11 ON baltb_npi_1.PROVIDER_BUSINESS_PRACTICE_LOCATION_ADDRESS_POSTAL_CODE = dim_text_11.dim_key LEFT OUTER JOIN
                      dim_text AS dim_text_9 ON baltb_npi_1.PROVIDER_BUSINESS_PRACTICE_LOCATION_ADDRESS_CITY_NAME = dim_text_9.dim_key LEFT OUTER JOIN
                      dim_text AS dim_text_8 ON baltb_npi_1.PROVIDER_SECOND_LINE_BUSINESS_PRACTICE_LOCATION_ADDRESS = dim_text_8.dim_key LEFT OUTER JOIN
                      dim_text AS dim_text_7 ON baltb_npi_1.PROVIDER_FIRST_LINE_BUSINESS_PRACTICE_LOCATION_ADDRESS = dim_text_7.dim_key LEFT OUTER JOIN
                      dim_text AS dim_text_6 ON baltb_npi_1.PROVIDER_CREDENTIAL_TEXT = dim_text_6.dim_key LEFT OUTER JOIN
                      dim_text AS dim_text_5 ON baltb_npi_1.PROVIDER_NAME_SUFFIX_TEXT = dim_text_5.dim_key LEFT OUTER JOIN
                      dim_text AS dim_text_3 ON baltb_npi_1.PROVIDER_MIDDLE_NAME = dim_text_3.dim_key LEFT OUTER JOIN
                      dim_text AS dim_text_4 ON baltb_npi_1.PROVIDER_NAME_PREFIX_TEXT = dim_text_4.dim_key LEFT OUTER JOIN
                      dim_text AS dim_text_2 ON baltb_npi_1.PROVIDER_FIRST_NAME = dim_text_2.dim_key LEFT OUTER JOIN
                      dim_text AS dim_text_1 ON baltb_npi_1.PROVIDER_LAST_NAME_LEGAL_NAME = dim_text_1.dim_key LEFT OUTER JOIN
                      dim_text ON baltb_npi_1.PROVIDER_ORGANIZATION_NAME_LEGAL_BUSINESS_NAME = dim_text.dim_key