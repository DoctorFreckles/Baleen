--USE [BAL_VIEWS]
--GO

--/****** Object:  View [dbo].[BVW_BAL_PROVIDER-BSET_NPI]    Script Date: 04/20/2012 19:58:40 ******/
--SET ANSI_NULLS ON
--GO

--SET QUOTED_IDENTIFIER ON
--GO

-----------------

--CREATE VIEW [dbo].[BVW_BAL_PROVIDER-BSET_NPI]
--AS
SELECT top 1000
t1.[key] as OBJECT_KEY 
,t2.[val] as NPI_INT
,t28.[val] as EMPLOYER_IDENTIFICATION_NUMBER_EIN_TXTS
,t30.[val] as PROVIDER_ORGANIZATION_NAME_LEGAL_BUSINESS_NAME_TXTS
,t17.[val] as PROVIDER_GENDER_CODE_TXTS
,t23.[val] as PROVIDER_NAME_PREFIX_TEXT_TXTS
,t16.[val] as PROVIDER_FIRST_NAME_TXTS
,t20.[val] as PROVIDER_MIDDLE_NAME_TXTS
,t18.[val] as PROVIDER_LAST_NAME_LEGAL_NAME_TXTS
,t68.[val] as PROVIDER_NAME_SUFFIX_TEXT_TXTS
,t19.[val] as PROVIDER_CREDENTIAL_TEXT_TXTS
,t5.[val] as PROVIDER_ENUMERATION_DATE_DTM
,t1.[val] as LAST_UPDATE_DATE_DTM

,t13.[val] as PROVIDER_FIRST_LINE_BUSINESS_PRACTICE_LOCATION_ADDRESS_TXTS
,t24.[val] as PROVIDER_SECOND_LINE_BUSINESS_PRACTICE_LOCATION_ADDRESS_TXTS
,t8.[val] as PROVIDER_BUSINESS_PRACTICE_LOCATION_ADDRESS_CITY_NAME_TXTS
,t10.[val] as PROVIDER_BUSINESS_PRACTICE_LOCATION_ADDRESS_STATE_NAME_TXTS
,zbpl.[val] as PROVIDER_BUSINESS_PRACTICE_LOCATION_ADDRESS_POSTAL_CODE_TXTS
,t4.[val] as PROVIDER_BUSINESS_PRACTICE_LOCATION_ADDRESS_COUNTRY_CODE_IF_OUTSIDE_U_S_TXTS
,pbpl.[val] as PROVIDER_BUSINESS_PRACTICE_LOCATION_ADDRESS_TELEPHONE_NUMBER_TXTS


,t12.[val] as PROVIDER_FIRST_LINE_BUSINESS_MAILING_ADDRESS_TXTS
,t25.[val] as PROVIDER_SECOND_LINE_BUSINESS_MAILING_ADDRESS_TXTS
,t3.[val] as PROVIDER_BUSINESS_MAILING_ADDRESS_COUNTRY_CODE_IF_OUTSIDE_U_S_TXTS
,t9.[val] as PROVIDER_BUSINESS_MAILING_ADDRESS_STATE_NAME_TXTS
,t11.[val] as PROVIDER_BUSINESS_MAILING_ADDRESS_CITY_NAME_TXTS




,t6.[val] as HEALTHCARE_PROVIDER_TAXONOMY_CODE_1_TXTS
,t39.[val] as HEALTHCARE_PROVIDER_TAXONOMY_CODE_2_TXTS
,t56.[val] as HEALTHCARE_PROVIDER_TAXONOMY_CODE_3_TXTS
,t7.[val] as HEALTHCARE_PROVIDER_PRIMARY_TAXONOMY_SWITCH_1_TXTS
,t15.[val] as IS_SOLE_PROPRIETOR_TXTS

FROM 
[BAL_PROVIDER].dbo.[BSET_NPI-LAST_UPDATE_DATE-DTM] t1
LEFT OUTER JOIN [BAL_PROVIDER].dbo.[BSET_NPI-NPI-INT]  t2 ON  t2.[key] = t1.[key]
LEFT OUTER JOIN [BAL_PROVIDER].dbo.[BSET_NPI-PROVIDER_BUSINESS_MAILING_ADDRESS_COUNTRY_CODE_IF_OUTSIDE_U_S-TXTS]  t3 ON  t3.[key] = t1.[key]
LEFT OUTER JOIN [BAL_PROVIDER].dbo.[BSET_NPI-PROVIDER_BUSINESS_PRACTICE_LOCATION_ADDRESS_COUNTRY_CODE_IF_OUTSIDE_U_S-TXTS]  t4 ON  t4.[key] = t1.[key]
LEFT OUTER JOIN [BAL_PROVIDER].dbo.[BSET_NPI-PROVIDER_ENUMERATION_DATE-DTM]  t5 ON  t5.[key] = t1.[key]
LEFT OUTER JOIN [BAL_PROVIDER].dbo.[BSET_NPI-HEALTHCARE_PROVIDER_TAXONOMY_CODE_1-TXTS]  t6 ON  t6.[key] = t1.[key]
LEFT OUTER JOIN [BAL_PROVIDER].dbo.[BSET_NPI-HEALTHCARE_PROVIDER_PRIMARY_TAXONOMY_SWITCH_1-TXTS]  t7 ON  t7.[key] = t1.[key]
LEFT OUTER JOIN [BAL_PROVIDER].dbo.[BSET_NPI-PROVIDER_BUSINESS_PRACTICE_LOCATION_ADDRESS_CITY_NAME-TXTS]  t8 ON  t8.[key] = t1.[key]
LEFT OUTER JOIN [BAL_PROVIDER].dbo.[BSET_NPI-PROVIDER_BUSINESS_MAILING_ADDRESS_STATE_NAME-TXTS]  t9 ON  t9.[key] = t1.[key]
LEFT OUTER JOIN [BAL_PROVIDER].dbo.[BSET_NPI-PROVIDER_BUSINESS_PRACTICE_LOCATION_ADDRESS_STATE_NAME-TXTS]  t10 ON  t10.[key] = t1.[key]
LEFT OUTER JOIN [BAL_PROVIDER].dbo.[BSET_NPI-PROVIDER_BUSINESS_MAILING_ADDRESS_CITY_NAME-TXTS]  t11 ON  t11.[key] = t1.[key]
LEFT OUTER JOIN [BAL_PROVIDER].dbo.[BSET_NPI-PROVIDER_FIRST_LINE_BUSINESS_MAILING_ADDRESS-TXTS]  t12 ON  t12.[key] = t1.[key]
LEFT OUTER JOIN [BAL_PROVIDER].dbo.[BSET_NPI-PROVIDER_FIRST_LINE_BUSINESS_PRACTICE_LOCATION_ADDRESS-TXTS]  t13 ON  t13.[key] = t1.[key]
LEFT OUTER JOIN [BAL_PROVIDER].dbo.[BSET_NPI-IS_SOLE_PROPRIETOR-TXTS]  t15 ON  t15.[key] = t1.[key]
LEFT OUTER JOIN [BAL_PROVIDER].dbo.[BSET_NPI-PROVIDER_FIRST_NAME-TXTS]  t16 ON  t16.[key] = t1.[key]
LEFT OUTER JOIN [BAL_PROVIDER].dbo.[BSET_NPI-PROVIDER_GENDER_CODE-TXTS]  t17 ON  t17.[key] = t1.[key]
LEFT OUTER JOIN [BAL_PROVIDER].dbo.[BSET_NPI-PROVIDER_LAST_NAME_LEGAL_NAME-TXTS]  t18 ON  t18.[key] = t1.[key]
LEFT OUTER JOIN [BAL_PROVIDER].dbo.[BSET_NPI-PROVIDER_CREDENTIAL_TEXT-TXTS]  t19 ON  t19.[key] = t1.[key]
LEFT OUTER JOIN [BAL_PROVIDER].dbo.[BSET_NPI-PROVIDER_MIDDLE_NAME-TXTS]  t20 ON  t20.[key] = t1.[key]
LEFT OUTER JOIN [BAL_PROVIDER].dbo.[BSET_NPI-PROVIDER_NAME_PREFIX_TEXT-TXTS]  t23 ON  t23.[key] = t1.[key]
LEFT OUTER JOIN [BAL_PROVIDER].dbo.[BSET_NPI-PROVIDER_SECOND_LINE_BUSINESS_PRACTICE_LOCATION_ADDRESS-TXTS]  t24 ON  t24.[key] = t1.[key]
LEFT OUTER JOIN [BAL_PROVIDER].dbo.[BSET_NPI-PROVIDER_SECOND_LINE_BUSINESS_MAILING_ADDRESS-TXTS]  t25 ON  t25.[key] = t1.[key]
LEFT OUTER JOIN [BAL_PROVIDER].dbo.[BSET_NPI-EMPLOYER_IDENTIFICATION_NUMBER_EIN-TXTS]  t28 ON  t28.[key] = t1.[key]
LEFT OUTER JOIN [BAL_PROVIDER].dbo.[BSET_NPI-PROVIDER_ORGANIZATION_NAME_LEGAL_BUSINESS_NAME-TXTS]  t30 ON  t30.[key] = t1.[key]
LEFT OUTER JOIN [BAL_PROVIDER].dbo.[BSET_NPI-HEALTHCARE_PROVIDER_TAXONOMY_CODE_2-TXTS]  t39 ON  t39.[key] = t1.[key]
LEFT OUTER JOIN [BAL_PROVIDER].dbo.[BSET_NPI-HEALTHCARE_PROVIDER_TAXONOMY_CODE_3-TXTS]  t56 ON  t56.[key] = t1.[key]
LEFT OUTER JOIN [BAL_PROVIDER].dbo.[BSET_NPI-PROVIDER_NAME_SUFFIX_TEXT-TXTS]  t68 ON  t68.[key] = t1.[key]
LEFT OUTER JOIN [BAL_PROVIDER].dbo.[BSET_NPI-PROVIDER_BUSINESS_PRACTICE_LOCATION_ADDRESS_POSTAL_CODE-TXTS] zbpl on zbpl.[key] = t1.[key]
LEFT OUTER JOIN [BAL_PROVIDER].dbo.[BSET_NPI-PROVIDER_BUSINESS_PRACTICE_LOCATION_ADDRESS_TELEPHONE_NUMBER-TXTS] pbpl on zbpl.[key] = t1.[key]

--GO


