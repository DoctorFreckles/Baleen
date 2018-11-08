USE [dndx_views]
GO

/****** Object:  View [dbo].[vdndx_npi]    Script Date: 03/28/2012 21:56:21 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO



CREATE view [dbo].[vdndx_npi]
as
SELECT [NPI]
      ,[OrgName] as [Org Name]
      ,[LastName] as [Last Name]
      ,[FirstName] as [First Name]
      ,[MiddleName] as [Middle Name]
      ,[Prefix]
      ,[Suffix]
      ,[ProfCredentials] as [Prof. Credentials]
      ,[AddressLine1] as [Address Line 1]
      ,[AddressLine2] as [Address Line 2]
      ,[City]
      ,[StateOrProvince] as [State Or Province]
      ,[PostalCode] as [Postal Code]
      ,[Gender]
      ,[Taxonomy1] as [Taxonomy Code 1]
      ,[TaxType1] as [Tax. Type - 1]
      ,[TaxClass1] as [Tax. Class - 1]
      ,[TaxSpecialization1] as [Tax. Specialization - 1]
      ,[TaxDefinition1] as [Tax. Definition - 1]
      ,[TaxNotes1] as [Tax. Notes - 1]
            ,[Taxonomy2] as [Taxonomy Code 2]
      ,[TaxType2] as [Tax. Type - 2]
      ,[TaxClass2] as [Tax. Class - 2]
      ,[TaxSpecialization2] as [Tax. Specialization - 2]
      ,[TaxDefinition2] as [Tax. Definition - 2]
      ,[TaxNotes2] as [Tax. Notes - 2]
from
(
select * from dndx_providers_1.dbo.vw_provider_list
union
select * from dndx_providers_2.dbo.vw_provider_list
) v




GO


