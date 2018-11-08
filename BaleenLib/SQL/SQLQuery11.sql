SELECT  top 100   
	baltb_npi_1.NPI_PK as NPI, 
	dim_text.dim_value as OrgName, 
	dim_text_1.dim_value AS LastName, 
	dim_text_2.dim_value AS FirstName, 
	dim_text_3.dim_value AS MiddleName, 
    dim_text_4.dim_value AS Prefix, 
    dim_text_5.dim_value AS Suffix, 
    dim_text_6.dim_value AS ProfCredentials, 
    dim_text_7.dim_value AS AddressLine1, 
    dim_text_8.dim_value AS AddressLine2, 
    dim_text_9.dim_value AS City, 
    dim_text_10.dim_value AS StateOrProvince, 
    dim_text_11.dim_value AS PostalCode, 
    dim_text_12.dim_value AS Gender, 
    dim_text_13.dim_value AS Taxonomy1, 
    dim_text_14.dim_value AS Taxonomy2
FROM         
baltb_npi_1 
LEFT OUTER JOIN dim_text AS dim_text_14 
ON baltb_npi_1.HEALTHCARE_PROVIDER_TAXONOMY_CODE_2 = dim_text_14.dim_key 
LEFT OUTER JOIN dim_text AS dim_text_10 
ON baltb_npi_1.PROVIDER_BUSINESS_PRACTICE_LOCATION_ADDRESS_STATE_NAME = dim_text_10.dim_key 
LEFT OUTER JOIN dim_text AS dim_text_13 
ON baltb_npi_1.HEALTHCARE_PROVIDER_TAXONOMY_CODE_1 = dim_text_13.dim_key 
LEFT OUTER JOIN dim_text AS dim_text_12 
ON baltb_npi_1.PROVIDER_GENDER_CODE = dim_text_12.dim_key 
LEFT OUTER JOIN dim_text AS dim_text_11 
ON baltb_npi_1.PROVIDER_BUSINESS_PRACTICE_LOCATION_ADDRESS_POSTAL_CODE = dim_text_11.dim_key 
LEFT OUTER JOIN dim_text AS dim_text_9 
ON baltb_npi_1.PROVIDER_BUSINESS_PRACTICE_LOCATION_ADDRESS_CITY_NAME = dim_text_9.dim_key 
LEFT OUTER JOIN dim_text AS dim_text_8 
ON baltb_npi_1.PROVIDER_SECOND_LINE_BUSINESS_PRACTICE_LOCATION_ADDRESS = dim_text_8.dim_key 
LEFT OUTER JOIN dim_text AS dim_text_7 
ON baltb_npi_1.PROVIDER_FIRST_LINE_BUSINESS_PRACTICE_LOCATION_ADDRESS = dim_text_7.dim_key 
LEFT OUTER JOIN dim_text AS dim_text_6 
ON baltb_npi_1.PROVIDER_CREDENTIAL_TEXT = dim_text_6.dim_key 
LEFT OUTER JOIN dim_text AS dim_text_5 
ON baltb_npi_1.PROVIDER_NAME_SUFFIX_TEXT = dim_text_5.dim_key 
LEFT OUTER JOIN dim_text AS dim_text_3 
ON baltb_npi_1.PROVIDER_MIDDLE_NAME = dim_text_3.dim_key 
LEFT OUTER JOIN dim_text AS dim_text_4 
ON baltb_npi_1.PROVIDER_NAME_PREFIX_TEXT = dim_text_4.dim_key 
LEFT OUTER JOIN dim_text AS dim_text_2 
ON baltb_npi_1.PROVIDER_FIRST_NAME = dim_text_2.dim_key 
LEFT OUTER JOIN dim_text AS dim_text_1 
ON baltb_npi_1.PROVIDER_LAST_NAME_LEGAL_NAME = dim_text_1.dim_key 
LEFT OUTER JOIN dim_text 
ON baltb_npi_1.PROVIDER_ORGANIZATION_NAME_LEGAL_BUSINESS_NAME = dim_text.dim_key