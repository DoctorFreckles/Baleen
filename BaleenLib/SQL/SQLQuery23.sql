USE [BLNS_PROVIDER_RESEARCH]
GO

/****** Object:  View [dbo].[BVW_NAMES]    Script Date: 04/02/2012 19:12:54 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

create view [dbo].[BVW_NAMES]
as
SELECT 
[BSET_NPI-NPI].object_key, 
RTRIM(ltrim(
coalesce([BSET_NPI-PROVIDER_NAME_PREFIX_TEXT].as_small_text,'') + ' ' +
coalesce([BSET_NPI-PROVIDER_FIRST_NAME].as_small_text,'') + ' ' +
coalesce([BSET_NPI-PROVIDER_MIDDLE_NAME].as_small_text,'') + ' ' +
coalesce([BSET_NPI-PROVIDER_LAST_NAME_LEGAL_NAME].as_small_text,'') + ' ' +
coalesce([BSET_NPI-PROVIDER_NAME_SUFFIX_TEXT].as_small_text,'') + ' ' +
coalesce([BSET_NPI-PROVIDER_CREDENTIAL_TEXT].as_small_text,'') + ' ' + 
coalesce([BSET_NPI-PROVIDER_ORGANIZATION_NAME_LEGAL_BUSINESS_NAME].as_small_text,'') 
)) as Names
FROM         [BSET_NPI-NPI] LEFT OUTER JOIN
[BSET_NPI-PROVIDER_ORGANIZATION_NAME_LEGAL_BUSINESS_NAME] ON 
[BSET_NPI-NPI].object_key = [BSET_NPI-PROVIDER_ORGANIZATION_NAME_LEGAL_BUSINESS_NAME].object_key LEFT OUTER JOIN
[BSET_NPI-PROVIDER_CREDENTIAL_TEXT] ON [BSET_NPI-NPI].object_key = [BSET_NPI-PROVIDER_CREDENTIAL_TEXT].object_key LEFT OUTER JOIN
[BSET_NPI-PROVIDER_NAME_SUFFIX_TEXT] ON [BSET_NPI-NPI].object_key = [BSET_NPI-PROVIDER_NAME_SUFFIX_TEXT].object_key LEFT OUTER JOIN
[BSET_NPI-PROVIDER_LAST_NAME_LEGAL_NAME] ON [BSET_NPI-NPI].object_key = [BSET_NPI-PROVIDER_LAST_NAME_LEGAL_NAME].object_key LEFT OUTER JOIN
[BSET_NPI-PROVIDER_MIDDLE_NAME] ON [BSET_NPI-NPI].object_key = [BSET_NPI-PROVIDER_MIDDLE_NAME].object_key LEFT OUTER JOIN
[BSET_NPI-PROVIDER_FIRST_NAME] ON [BSET_NPI-NPI].object_key = [BSET_NPI-PROVIDER_FIRST_NAME].object_key LEFT OUTER JOIN
[BSET_NPI-PROVIDER_NAME_PREFIX_TEXT] ON [BSET_NPI-NPI].object_key = [BSET_NPI-PROVIDER_NAME_PREFIX_TEXT].object_key

GO


