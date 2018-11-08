
SELECT     
Prefix, Suffix, ProfCredentials, City, StateOrProvince, Gender, Taxonomy1, Taxonomy2, TaxType1, TaxClass1, TaxSpecialization1, TaxDefinition1, TaxNotes1, 
                      TaxType2, TaxClass2, TaxSpecialization2, TaxDefinition2, TaxNotes2, COUNT(*) as Cardinality

FROM         vw_provider_list
group by Prefix, Suffix, ProfCredentials, City, StateOrProvince, Gender, Taxonomy1, Taxonomy2, TaxType1, TaxClass1, TaxSpecialization1, TaxDefinition1, TaxNotes1, 
                      TaxType2, TaxClass2, TaxSpecialization2, TaxDefinition2, TaxNotes2