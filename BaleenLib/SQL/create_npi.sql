create table NPI
(
NPI_PK bigint,
ENTITY_TYPE_CODE bigint,
REPLACEMENT_NPI bigint,
EMPLOYER_IDENTIFICATION_NUMBER_EIN bigint,
PROVIDER_ORGANIZATION_NAME_LEGAL_BUSINESS_NAME bigint,
PROVIDER_LAST_NAME_LEGAL_NAME bigint,
PROVIDER_FIRST_NAME bigint,
PROVIDER_MIDDLE_NAME bigint,
PROVIDER_NAME_PREFIX_TEXT bigint,
PROVIDER_NAME_SUFFIX_TEXT bigint,
PROVIDER_CREDENTIAL_TEXT bigint,
PROVIDER_OTHER_ORGANIZATION_NAME bigint,
PROVIDER_OTHER_ORGANIZATION_NAME_TYPE_CODE bigint,
PROVIDER_OTHER_LAST_NAME bigint,
PROVIDER_OTHER_FIRST_NAME bigint,
PROVIDER_OTHER_MIDDLE_NAME bigint,
PROVIDER_OTHER_NAME_PREFIX_TEXT bigint,
PROVIDER_OTHER_NAME_SUFFIX_TEXT bigint,
PROVIDER_OTHER_CREDENTIAL_TEXT bigint,
PROVIDER_OTHER_LAST_NAME_TYPE_CODE bigint,
PROVIDER_FIRST_LINE_BUSINESS_MAILING_ADDRESS bigint,
PROVIDER_SECOND_LINE_BUSINESS_MAILING_ADDRESS bigint,
PROVIDER_BUSINESS_MAILING_ADDRESS_CITY_NAME bigint,
PROVIDER_BUSINESS_MAILING_ADDRESS_STATE_NAME bigint,
PROVIDER_BUSINESS_MAILING_ADDRESS_POSTAL_CODE bigint,
PROVIDER_BUSINESS_MAILING_ADDRESS_COUNTRY_CODE_IF_OUTSIDE_U_S bigint,
PROVIDER_BUSINESS_MAILING_ADDRESS_TELEPHONE_NUMBER bigint,
PROVIDER_BUSINESS_MAILING_ADDRESS_FAX_NUMBER bigint,
PROVIDER_FIRST_LINE_BUSINESS_PRACTICE_LOCATION_ADDRESS bigint,
PROVIDER_SECOND_LINE_BUSINESS_PRACTICE_LOCATION_ADDRESS bigint,
PROVIDER_BUSINESS_PRACTICE_LOCATION_ADDRESS_CITY_NAME bigint,
PROVIDER_BUSINESS_PRACTICE_LOCATION_ADDRESS_STATE_NAME bigint,
PROVIDER_BUSINESS_PRACTICE_LOCATION_ADDRESS_POSTAL_CODE bigint,
PROVIDER_BUSINESS_PRACTICE_LOCATION_ADDRESS_COUNTRY_CODE_IF_OUTSIDE_U_S bigint,
PROVIDER_BUSINESS_PRACTICE_LOCATION_ADDRESS_TELEPHONE_NUMBER bigint,
PROVIDER_BUSINESS_PRACTICE_LOCATION_ADDRESS_FAX_NUMBER bigint,
PROVIDER_ENUMERATION_DATE bigint,
LAST_UPDATE_DATE bigint,
NPI_DEACTIVATION_REASON_CODE bigint,
NPI_DEACTIVATION_DATE bigint,
NPI_REACTIVATION_DATE bigint,
PROVIDER_GENDER_CODE bigint,
AUTHORIZED_OFFICIAL_LAST_NAME bigint,
AUTHORIZED_OFFICIAL_FIRST_NAME bigint,
AUTHORIZED_OFFICIAL_MIDDLE_NAME bigint,
AUTHORIZED_OFFICIAL_TITLE_OR_POSITION bigint,
AUTHORIZED_OFFICIAL_TELEPHONE_NUMBER bigint,
HEALTHCARE_PROVIDER_TAXONOMY_CODE_1 bigint,
PROVIDER_LICENSE_NUMBER_1 bigint,
PROVIDER_LICENSE_NUMBER_STATE_CODE_1 bigint,
HEALTHCARE_PROVIDER_PRIMARY_TAXONOMY_SWITCH_1 bigint,
HEALTHCARE_PROVIDER_TAXONOMY_CODE_2 bigint,
PROVIDER_LICENSE_NUMBER_2 bigint,
PROVIDER_LICENSE_NUMBER_STATE_CODE_2 bigint,
HEALTHCARE_PROVIDER_PRIMARY_TAXONOMY_SWITCH_2 bigint,
HEALTHCARE_PROVIDER_TAXONOMY_CODE_3 bigint,
PROVIDER_LICENSE_NUMBER_3 bigint,
PROVIDER_LICENSE_NUMBER_STATE_CODE_3 bigint,
HEALTHCARE_PROVIDER_PRIMARY_TAXONOMY_SWITCH_3 bigint,
HEALTHCARE_PROVIDER_TAXONOMY_CODE_4 bigint,
PROVIDER_LICENSE_NUMBER_4 bigint,
PROVIDER_LICENSE_NUMBER_STATE_CODE_4 bigint,
HEALTHCARE_PROVIDER_PRIMARY_TAXONOMY_SWITCH_4 bigint,
HEALTHCARE_PROVIDER_TAXONOMY_CODE_5 bigint,
PROVIDER_LICENSE_NUMBER_5 bigint,
PROVIDER_LICENSE_NUMBER_STATE_CODE_5 bigint,
HEALTHCARE_PROVIDER_PRIMARY_TAXONOMY_SWITCH_5 bigint,
HEALTHCARE_PROVIDER_TAXONOMY_CODE_6 bigint,
PROVIDER_LICENSE_NUMBER_6 bigint,
PROVIDER_LICENSE_NUMBER_STATE_CODE_6 bigint,
HEALTHCARE_PROVIDER_PRIMARY_TAXONOMY_SWITCH_6 bigint,
HEALTHCARE_PROVIDER_TAXONOMY_CODE_7 bigint,
PROVIDER_LICENSE_NUMBER_7 bigint,
PROVIDER_LICENSE_NUMBER_STATE_CODE_7 bigint,
HEALTHCARE_PROVIDER_PRIMARY_TAXONOMY_SWITCH_7 bigint,
HEALTHCARE_PROVIDER_TAXONOMY_CODE_8 bigint,
PROVIDER_LICENSE_NUMBER_8 bigint,
PROVIDER_LICENSE_NUMBER_STATE_CODE_8 bigint,
HEALTHCARE_PROVIDER_PRIMARY_TAXONOMY_SWITCH_8 bigint,
HEALTHCARE_PROVIDER_TAXONOMY_CODE_9 bigint,
PROVIDER_LICENSE_NUMBER_9 bigint,
PROVIDER_LICENSE_NUMBER_STATE_CODE_9 bigint,
HEALTHCARE_PROVIDER_PRIMARY_TAXONOMY_SWITCH_9 bigint,
HEALTHCARE_PROVIDER_TAXONOMY_CODE_10 bigint,
PROVIDER_LICENSE_NUMBER_10 bigint,
PROVIDER_LICENSE_NUMBER_STATE_CODE_10 bigint,
HEALTHCARE_PROVIDER_PRIMARY_TAXONOMY_SWITCH_10 bigint,
HEALTHCARE_PROVIDER_TAXONOMY_CODE_11 bigint,
PROVIDER_LICENSE_NUMBER_11 bigint,
PROVIDER_LICENSE_NUMBER_STATE_CODE_11 bigint,
HEALTHCARE_PROVIDER_PRIMARY_TAXONOMY_SWITCH_11 bigint,
HEALTHCARE_PROVIDER_TAXONOMY_CODE_12 bigint,
PROVIDER_LICENSE_NUMBER_12 bigint,
PROVIDER_LICENSE_NUMBER_STATE_CODE_12 bigint,
HEALTHCARE_PROVIDER_PRIMARY_TAXONOMY_SWITCH_12 bigint,
HEALTHCARE_PROVIDER_TAXONOMY_CODE_13 bigint,
PROVIDER_LICENSE_NUMBER_13 bigint,
PROVIDER_LICENSE_NUMBER_STATE_CODE_13 bigint,
HEALTHCARE_PROVIDER_PRIMARY_TAXONOMY_SWITCH_13 bigint,
HEALTHCARE_PROVIDER_TAXONOMY_CODE_14 bigint,
PROVIDER_LICENSE_NUMBER_14 bigint,
PROVIDER_LICENSE_NUMBER_STATE_CODE_14 bigint,
HEALTHCARE_PROVIDER_PRIMARY_TAXONOMY_SWITCH_14 bigint,
HEALTHCARE_PROVIDER_TAXONOMY_CODE_15 bigint,
PROVIDER_LICENSE_NUMBER_15 bigint,
PROVIDER_LICENSE_NUMBER_STATE_CODE_15 bigint,
HEALTHCARE_PROVIDER_PRIMARY_TAXONOMY_SWITCH_15 bigint,
OTHER_PROVIDER_IDENTIFIER_1 bigint,
OTHER_PROVIDER_IDENTIFIER_TYPE_CODE_1 bigint,
OTHER_PROVIDER_IDENTIFIER_STATE_1 bigint,
OTHER_PROVIDER_IDENTIFIER_ISSUER_1 bigint,
OTHER_PROVIDER_IDENTIFIER_2 bigint,
OTHER_PROVIDER_IDENTIFIER_TYPE_CODE_2 bigint,
OTHER_PROVIDER_IDENTIFIER_STATE_2 bigint,
OTHER_PROVIDER_IDENTIFIER_ISSUER_2 bigint,
OTHER_PROVIDER_IDENTIFIER_3 bigint,
OTHER_PROVIDER_IDENTIFIER_TYPE_CODE_3 bigint,
OTHER_PROVIDER_IDENTIFIER_STATE_3 bigint,
OTHER_PROVIDER_IDENTIFIER_ISSUER_3 bigint,
OTHER_PROVIDER_IDENTIFIER_4 bigint,
OTHER_PROVIDER_IDENTIFIER_TYPE_CODE_4 bigint,
OTHER_PROVIDER_IDENTIFIER_STATE_4 bigint,
OTHER_PROVIDER_IDENTIFIER_ISSUER_4 bigint,
OTHER_PROVIDER_IDENTIFIER_5 bigint,
OTHER_PROVIDER_IDENTIFIER_TYPE_CODE_5 bigint,
OTHER_PROVIDER_IDENTIFIER_STATE_5 bigint,
OTHER_PROVIDER_IDENTIFIER_ISSUER_5 bigint,
OTHER_PROVIDER_IDENTIFIER_6 bigint,
OTHER_PROVIDER_IDENTIFIER_TYPE_CODE_6 bigint,
OTHER_PROVIDER_IDENTIFIER_STATE_6 bigint,
OTHER_PROVIDER_IDENTIFIER_ISSUER_6 bigint,
OTHER_PROVIDER_IDENTIFIER_7 bigint,
OTHER_PROVIDER_IDENTIFIER_TYPE_CODE_7 bigint,
OTHER_PROVIDER_IDENTIFIER_STATE_7 bigint,
OTHER_PROVIDER_IDENTIFIER_ISSUER_7 bigint,
OTHER_PROVIDER_IDENTIFIER_8 bigint,
OTHER_PROVIDER_IDENTIFIER_TYPE_CODE_8 bigint,
OTHER_PROVIDER_IDENTIFIER_STATE_8 bigint,
OTHER_PROVIDER_IDENTIFIER_ISSUER_8 bigint,
OTHER_PROVIDER_IDENTIFIER_9 bigint,
OTHER_PROVIDER_IDENTIFIER_TYPE_CODE_9 bigint,
OTHER_PROVIDER_IDENTIFIER_STATE_9 bigint,
OTHER_PROVIDER_IDENTIFIER_ISSUER_9 bigint,
OTHER_PROVIDER_IDENTIFIER_10 bigint,
OTHER_PROVIDER_IDENTIFIER_TYPE_CODE_10 bigint,
OTHER_PROVIDER_IDENTIFIER_STATE_10 bigint,
OTHER_PROVIDER_IDENTIFIER_ISSUER_10 bigint,
OTHER_PROVIDER_IDENTIFIER_11 bigint,
OTHER_PROVIDER_IDENTIFIER_TYPE_CODE_11 bigint,
OTHER_PROVIDER_IDENTIFIER_STATE_11 bigint,
OTHER_PROVIDER_IDENTIFIER_ISSUER_11 bigint,
OTHER_PROVIDER_IDENTIFIER_12 bigint,
OTHER_PROVIDER_IDENTIFIER_TYPE_CODE_12 bigint,
OTHER_PROVIDER_IDENTIFIER_STATE_12 bigint,
OTHER_PROVIDER_IDENTIFIER_ISSUER_12 bigint,
OTHER_PROVIDER_IDENTIFIER_13 bigint,
OTHER_PROVIDER_IDENTIFIER_TYPE_CODE_13 bigint,
OTHER_PROVIDER_IDENTIFIER_STATE_13 bigint,
OTHER_PROVIDER_IDENTIFIER_ISSUER_13 bigint,
OTHER_PROVIDER_IDENTIFIER_14 bigint,
OTHER_PROVIDER_IDENTIFIER_TYPE_CODE_14 bigint,
OTHER_PROVIDER_IDENTIFIER_STATE_14 bigint,
OTHER_PROVIDER_IDENTIFIER_ISSUER_14 bigint,
OTHER_PROVIDER_IDENTIFIER_15 bigint,
OTHER_PROVIDER_IDENTIFIER_TYPE_CODE_15 bigint,
OTHER_PROVIDER_IDENTIFIER_STATE_15 bigint,
OTHER_PROVIDER_IDENTIFIER_ISSUER_15 bigint,
OTHER_PROVIDER_IDENTIFIER_16 bigint,
OTHER_PROVIDER_IDENTIFIER_TYPE_CODE_16 bigint,
OTHER_PROVIDER_IDENTIFIER_STATE_16 bigint,
OTHER_PROVIDER_IDENTIFIER_ISSUER_16 bigint,
OTHER_PROVIDER_IDENTIFIER_17 bigint,
OTHER_PROVIDER_IDENTIFIER_TYPE_CODE_17 bigint,
OTHER_PROVIDER_IDENTIFIER_STATE_17 bigint,
OTHER_PROVIDER_IDENTIFIER_ISSUER_17 bigint,
OTHER_PROVIDER_IDENTIFIER_18 bigint,
OTHER_PROVIDER_IDENTIFIER_TYPE_CODE_18 bigint,
OTHER_PROVIDER_IDENTIFIER_STATE_18 bigint,
OTHER_PROVIDER_IDENTIFIER_ISSUER_18 bigint,
OTHER_PROVIDER_IDENTIFIER_19 bigint,
OTHER_PROVIDER_IDENTIFIER_TYPE_CODE_19 bigint,
OTHER_PROVIDER_IDENTIFIER_STATE_19 bigint,
OTHER_PROVIDER_IDENTIFIER_ISSUER_19 bigint,
OTHER_PROVIDER_IDENTIFIER_20 bigint,
OTHER_PROVIDER_IDENTIFIER_TYPE_CODE_20 bigint,
OTHER_PROVIDER_IDENTIFIER_STATE_20 bigint,
OTHER_PROVIDER_IDENTIFIER_ISSUER_20 bigint,
OTHER_PROVIDER_IDENTIFIER_21 bigint,
OTHER_PROVIDER_IDENTIFIER_TYPE_CODE_21 bigint,
OTHER_PROVIDER_IDENTIFIER_STATE_21 bigint,
OTHER_PROVIDER_IDENTIFIER_ISSUER_21 bigint,
OTHER_PROVIDER_IDENTIFIER_22 bigint,
OTHER_PROVIDER_IDENTIFIER_TYPE_CODE_22 bigint,
OTHER_PROVIDER_IDENTIFIER_STATE_22 bigint,
OTHER_PROVIDER_IDENTIFIER_ISSUER_22 bigint,
OTHER_PROVIDER_IDENTIFIER_23 bigint,
OTHER_PROVIDER_IDENTIFIER_TYPE_CODE_23 bigint,
OTHER_PROVIDER_IDENTIFIER_STATE_23 bigint,
OTHER_PROVIDER_IDENTIFIER_ISSUER_23 bigint,
OTHER_PROVIDER_IDENTIFIER_24 bigint,
OTHER_PROVIDER_IDENTIFIER_TYPE_CODE_24 bigint,
OTHER_PROVIDER_IDENTIFIER_STATE_24 bigint,
OTHER_PROVIDER_IDENTIFIER_ISSUER_24 bigint,
OTHER_PROVIDER_IDENTIFIER_25 bigint,
OTHER_PROVIDER_IDENTIFIER_TYPE_CODE_25 bigint,
OTHER_PROVIDER_IDENTIFIER_STATE_25 bigint,
OTHER_PROVIDER_IDENTIFIER_ISSUER_25 bigint,
OTHER_PROVIDER_IDENTIFIER_26 bigint,
OTHER_PROVIDER_IDENTIFIER_TYPE_CODE_26 bigint,
OTHER_PROVIDER_IDENTIFIER_STATE_26 bigint,
OTHER_PROVIDER_IDENTIFIER_ISSUER_26 bigint,
OTHER_PROVIDER_IDENTIFIER_27 bigint,
OTHER_PROVIDER_IDENTIFIER_TYPE_CODE_27 bigint,
OTHER_PROVIDER_IDENTIFIER_STATE_27 bigint,
OTHER_PROVIDER_IDENTIFIER_ISSUER_27 bigint,
OTHER_PROVIDER_IDENTIFIER_28 bigint,
OTHER_PROVIDER_IDENTIFIER_TYPE_CODE_28 bigint,
OTHER_PROVIDER_IDENTIFIER_STATE_28 bigint,
OTHER_PROVIDER_IDENTIFIER_ISSUER_28 bigint,
OTHER_PROVIDER_IDENTIFIER_29 bigint,
OTHER_PROVIDER_IDENTIFIER_TYPE_CODE_29 bigint,
OTHER_PROVIDER_IDENTIFIER_STATE_29 bigint,
OTHER_PROVIDER_IDENTIFIER_ISSUER_29 bigint,
OTHER_PROVIDER_IDENTIFIER_30 bigint,
OTHER_PROVIDER_IDENTIFIER_TYPE_CODE_30 bigint,
OTHER_PROVIDER_IDENTIFIER_STATE_30 bigint,
OTHER_PROVIDER_IDENTIFIER_ISSUER_30 bigint,
OTHER_PROVIDER_IDENTIFIER_31 bigint,
OTHER_PROVIDER_IDENTIFIER_TYPE_CODE_31 bigint,
OTHER_PROVIDER_IDENTIFIER_STATE_31 bigint,
OTHER_PROVIDER_IDENTIFIER_ISSUER_31 bigint,
OTHER_PROVIDER_IDENTIFIER_32 bigint,
OTHER_PROVIDER_IDENTIFIER_TYPE_CODE_32 bigint,
OTHER_PROVIDER_IDENTIFIER_STATE_32 bigint,
OTHER_PROVIDER_IDENTIFIER_ISSUER_32 bigint,
OTHER_PROVIDER_IDENTIFIER_33 bigint,
OTHER_PROVIDER_IDENTIFIER_TYPE_CODE_33 bigint,
OTHER_PROVIDER_IDENTIFIER_STATE_33 bigint,
OTHER_PROVIDER_IDENTIFIER_ISSUER_33 bigint,
OTHER_PROVIDER_IDENTIFIER_34 bigint,
OTHER_PROVIDER_IDENTIFIER_TYPE_CODE_34 bigint,
OTHER_PROVIDER_IDENTIFIER_STATE_34 bigint,
OTHER_PROVIDER_IDENTIFIER_ISSUER_34 bigint,
OTHER_PROVIDER_IDENTIFIER_35 bigint,
OTHER_PROVIDER_IDENTIFIER_TYPE_CODE_35 bigint,
OTHER_PROVIDER_IDENTIFIER_STATE_35 bigint,
OTHER_PROVIDER_IDENTIFIER_ISSUER_35 bigint,
OTHER_PROVIDER_IDENTIFIER_36 bigint,
OTHER_PROVIDER_IDENTIFIER_TYPE_CODE_36 bigint,
OTHER_PROVIDER_IDENTIFIER_STATE_36 bigint,
OTHER_PROVIDER_IDENTIFIER_ISSUER_36 bigint,
OTHER_PROVIDER_IDENTIFIER_37 bigint,
OTHER_PROVIDER_IDENTIFIER_TYPE_CODE_37 bigint,
OTHER_PROVIDER_IDENTIFIER_STATE_37 bigint,
OTHER_PROVIDER_IDENTIFIER_ISSUER_37 bigint,
OTHER_PROVIDER_IDENTIFIER_38 bigint,
OTHER_PROVIDER_IDENTIFIER_TYPE_CODE_38 bigint,
OTHER_PROVIDER_IDENTIFIER_STATE_38 bigint,
OTHER_PROVIDER_IDENTIFIER_ISSUER_38 bigint,
OTHER_PROVIDER_IDENTIFIER_39 bigint,
OTHER_PROVIDER_IDENTIFIER_TYPE_CODE_39 bigint,
OTHER_PROVIDER_IDENTIFIER_STATE_39 bigint,
OTHER_PROVIDER_IDENTIFIER_ISSUER_39 bigint,
OTHER_PROVIDER_IDENTIFIER_40 bigint,
OTHER_PROVIDER_IDENTIFIER_TYPE_CODE_40 bigint,
OTHER_PROVIDER_IDENTIFIER_STATE_40 bigint,
OTHER_PROVIDER_IDENTIFIER_ISSUER_40 bigint,
OTHER_PROVIDER_IDENTIFIER_41 bigint,
OTHER_PROVIDER_IDENTIFIER_TYPE_CODE_41 bigint,
OTHER_PROVIDER_IDENTIFIER_STATE_41 bigint,
OTHER_PROVIDER_IDENTIFIER_ISSUER_41 bigint,
OTHER_PROVIDER_IDENTIFIER_42 bigint,
OTHER_PROVIDER_IDENTIFIER_TYPE_CODE_42 bigint,
OTHER_PROVIDER_IDENTIFIER_STATE_42 bigint,
OTHER_PROVIDER_IDENTIFIER_ISSUER_42 bigint,
OTHER_PROVIDER_IDENTIFIER_43 bigint,
OTHER_PROVIDER_IDENTIFIER_TYPE_CODE_43 bigint,
OTHER_PROVIDER_IDENTIFIER_STATE_43 bigint,
OTHER_PROVIDER_IDENTIFIER_ISSUER_43 bigint,
OTHER_PROVIDER_IDENTIFIER_44 bigint,
OTHER_PROVIDER_IDENTIFIER_TYPE_CODE_44 bigint,
OTHER_PROVIDER_IDENTIFIER_STATE_44 bigint,
OTHER_PROVIDER_IDENTIFIER_ISSUER_44 bigint,
OTHER_PROVIDER_IDENTIFIER_45 bigint,
OTHER_PROVIDER_IDENTIFIER_TYPE_CODE_45 bigint,
OTHER_PROVIDER_IDENTIFIER_STATE_45 bigint,
OTHER_PROVIDER_IDENTIFIER_ISSUER_45 bigint,
OTHER_PROVIDER_IDENTIFIER_46 bigint,
OTHER_PROVIDER_IDENTIFIER_TYPE_CODE_46 bigint,
OTHER_PROVIDER_IDENTIFIER_STATE_46 bigint,
OTHER_PROVIDER_IDENTIFIER_ISSUER_46 bigint,
OTHER_PROVIDER_IDENTIFIER_47 bigint,
OTHER_PROVIDER_IDENTIFIER_TYPE_CODE_47 bigint,
OTHER_PROVIDER_IDENTIFIER_STATE_47 bigint,
OTHER_PROVIDER_IDENTIFIER_ISSUER_47 bigint,
OTHER_PROVIDER_IDENTIFIER_48 bigint,
OTHER_PROVIDER_IDENTIFIER_TYPE_CODE_48 bigint,
OTHER_PROVIDER_IDENTIFIER_STATE_48 bigint,
OTHER_PROVIDER_IDENTIFIER_ISSUER_48 bigint,
OTHER_PROVIDER_IDENTIFIER_49 bigint,
OTHER_PROVIDER_IDENTIFIER_TYPE_CODE_49 bigint,
OTHER_PROVIDER_IDENTIFIER_STATE_49 bigint,
OTHER_PROVIDER_IDENTIFIER_ISSUER_49 bigint,
OTHER_PROVIDER_IDENTIFIER_50 bigint,
OTHER_PROVIDER_IDENTIFIER_TYPE_CODE_50 bigint,
OTHER_PROVIDER_IDENTIFIER_STATE_50 bigint,
OTHER_PROVIDER_IDENTIFIER_ISSUER_50 bigint,
IS_SOLE_PROPRIETOR bigint,
IS_ORGANIZATION_SUBPART bigint,
PARENT_ORGANIZATION_LBN bigint,
PARENT_ORGANIZATION_TIN bigint,
AUTHORIZED_OFFICIAL_NAME_PREFIX_TEXT bigint,
AUTHORIZED_OFFICIAL_NAME_SUFFIX_TEXT bigint,
AUTHORIZED_OFFICIAL_CREDENTIAL_TEXT bigint,
HEALTHCARE_PROVIDER_TAXONOMY_GROUP_1 bigint,
HEALTHCARE_PROVIDER_TAXONOMY_GROUP_2 bigint,
HEALTHCARE_PROVIDER_TAXONOMY_GROUP_3 bigint,
HEALTHCARE_PROVIDER_TAXONOMY_GROUP_4 bigint,
HEALTHCARE_PROVIDER_TAXONOMY_GROUP_5 bigint,
HEALTHCARE_PROVIDER_TAXONOMY_GROUP_6 bigint,
HEALTHCARE_PROVIDER_TAXONOMY_GROUP_7 bigint,
HEALTHCARE_PROVIDER_TAXONOMY_GROUP_8 bigint,
HEALTHCARE_PROVIDER_TAXONOMY_GROUP_9 bigint,
HEALTHCARE_PROVIDER_TAXONOMY_GROUP_10 bigint,
HEALTHCARE_PROVIDER_TAXONOMY_GROUP_11 bigint,
HEALTHCARE_PROVIDER_TAXONOMY_GROUP_12 bigint,
HEALTHCARE_PROVIDER_TAXONOMY_GROUP_13 bigint,
HEALTHCARE_PROVIDER_TAXONOMY_GROUP_14 bigint,
HEALTHCARE_PROVIDER_TAXONOMY_GROUP_15 bigint)