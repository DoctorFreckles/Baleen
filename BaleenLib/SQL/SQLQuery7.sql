SELECT [dim_key]
      ,[dim_value]
into [dndx_providers_2].[dbo].[dim_double]
FROM [dndx_providers_1].[dbo].[dim_double]

SELECT [dim_key]
      ,[dim_value]
into [dndx_providers_2].[dbo].[dim_integer]
FROM [dndx_providers_1].[dbo].[dim_integer]

SELECT [dim_key]
      ,[dim_value]
into [dndx_providers_2].[dbo].[dim_text]
FROM [dndx_providers_1].[dbo].[dim_text]

SELECT [dim_key]
      ,[dim_value]
into [dndx_providers_2].[dbo].[dim_time]
FROM [dndx_providers_1].[dbo].[dim_time]

SELECT [Code]
      ,[Type]
      ,[Classification]
      ,[Specialization]
      ,[Definition]
      ,[Notes]
into [dndx_providers_2].[dbo].[taxonomy_code]
FROM [dndx_providers_1].[dbo].[taxonomy_code]















