USE [dndx_ontology]
GO

/****** Object:  View [dbo].[vw_set_city]    Script Date: 03/18/2012 14:23:46 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

/*create view vw_set_state_name
as
SELECT     common_dictionary.type_value, SUM(common_dictionary.cardinality) as cardinality
FROM         common_dictionary 
INNER JOIN
vw_type_uniqueness 
ON common_dictionary.type_name = vw_type_uniqueness.type_name
where common_dictionary.type_name like '%state name%'
group by common_dictionary.type_value
create view vw_set_taxonomy
as
SELECT     common_dictionary.type_value, SUM(common_dictionary.cardinality) as cardinality
FROM         common_dictionary 
INNER JOIN
vw_type_uniqueness 
ON common_dictionary.type_name = vw_type_uniqueness.type_name
where common_dictionary.type_name like '%taxonomy code%'
group by common_dictionary.type_value*/
CREATE VIEW [dbo].[vw_set_city]
AS
SELECT     dbo.common_dictionary.database_name, dbo.common_dictionary.table_name, dbo.common_dictionary.dictionary_id, dbo.common_dictionary.type_value, 
                      SUM(dbo.common_dictionary.cardinality) AS cardinality
FROM         dbo.common_dictionary INNER JOIN
                      dbo.vw_type_uniqueness ON dbo.common_dictionary.type_name = dbo.vw_type_uniqueness.type_name
WHERE     (dbo.common_dictionary.type_name LIKE '%city%')
GROUP BY dbo.common_dictionary.type_value, dbo.common_dictionary.database_name, dbo.common_dictionary.table_name, dbo.common_dictionary.dictionary_id

GO

EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[40] 4[20] 2[20] 3) )"
      End
      Begin PaneConfiguration = 1
         NumPanes = 3
         Configuration = "(H (1 [50] 4 [25] 3))"
      End
      Begin PaneConfiguration = 2
         NumPanes = 3
         Configuration = "(H (1 [50] 2 [25] 3))"
      End
      Begin PaneConfiguration = 3
         NumPanes = 3
         Configuration = "(H (4 [30] 2 [40] 3))"
      End
      Begin PaneConfiguration = 4
         NumPanes = 2
         Configuration = "(H (1 [56] 3))"
      End
      Begin PaneConfiguration = 5
         NumPanes = 2
         Configuration = "(H (2 [66] 3))"
      End
      Begin PaneConfiguration = 6
         NumPanes = 2
         Configuration = "(H (4 [50] 3))"
      End
      Begin PaneConfiguration = 7
         NumPanes = 1
         Configuration = "(V (3))"
      End
      Begin PaneConfiguration = 8
         NumPanes = 3
         Configuration = "(H (1[56] 4[18] 2) )"
      End
      Begin PaneConfiguration = 9
         NumPanes = 2
         Configuration = "(H (1 [75] 4))"
      End
      Begin PaneConfiguration = 10
         NumPanes = 2
         Configuration = "(H (1[66] 2) )"
      End
      Begin PaneConfiguration = 11
         NumPanes = 2
         Configuration = "(H (4 [60] 2))"
      End
      Begin PaneConfiguration = 12
         NumPanes = 1
         Configuration = "(H (1) )"
      End
      Begin PaneConfiguration = 13
         NumPanes = 1
         Configuration = "(V (4))"
      End
      Begin PaneConfiguration = 14
         NumPanes = 1
         Configuration = "(V (2))"
      End
      ActivePaneConfig = 0
   End
   Begin DiagramPane = 
      Begin Origin = 
         Top = 0
         Left = 0
      End
      Begin Tables = 
         Begin Table = "common_dictionary"
            Begin Extent = 
               Top = 6
               Left = 38
               Bottom = 123
               Right = 220
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "vw_type_uniqueness"
            Begin Extent = 
               Top = 6
               Left = 258
               Bottom = 93
               Right = 440
            End
            DisplayFlags = 280
            TopColumn = 0
         End
      End
   End
   Begin SQLPane = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 12
         Column = 1440
         Alias = 900
         Table = 1170
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1350
         SortOrder = 1410
         GroupBy = 1350
         Filter = 1350
         Or = 1350
         Or = 1350
         Or = 1350
      End
   End
End
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'vw_set_city'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'vw_set_city'
GO

/****** Object:  View [dbo].[vw_set_country_code]    Script Date: 03/18/2012 14:23:46 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

/*create view vw_set_state_name
as
SELECT     common_dictionary.type_value, SUM(common_dictionary.cardinality) as cardinality
FROM         common_dictionary 
INNER JOIN
vw_type_uniqueness 
ON common_dictionary.type_name = vw_type_uniqueness.type_name
where common_dictionary.type_name like '%state name%'
group by common_dictionary.type_value
create view vw_set_taxonomy
as
SELECT     common_dictionary.type_value, SUM(common_dictionary.cardinality) as cardinality
FROM         common_dictionary 
INNER JOIN
vw_type_uniqueness 
ON common_dictionary.type_name = vw_type_uniqueness.type_name
where common_dictionary.type_name like '%taxonomy code%'
group by common_dictionary.type_value*/
CREATE VIEW [dbo].[vw_set_country_code]
AS
SELECT     dbo.common_dictionary.database_name, dbo.common_dictionary.table_name, dbo.common_dictionary.dictionary_id, dbo.common_dictionary.type_value, 
                      SUM(dbo.common_dictionary.cardinality) AS cardinality
FROM         dbo.common_dictionary INNER JOIN
                      dbo.vw_type_uniqueness ON dbo.common_dictionary.type_name = dbo.vw_type_uniqueness.type_name
WHERE     (dbo.common_dictionary.type_name LIKE '%country code%')
GROUP BY dbo.common_dictionary.type_value, dbo.common_dictionary.database_name, dbo.common_dictionary.table_name, dbo.common_dictionary.dictionary_id

GO

EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[40] 4[20] 2[20] 3) )"
      End
      Begin PaneConfiguration = 1
         NumPanes = 3
         Configuration = "(H (1 [50] 4 [25] 3))"
      End
      Begin PaneConfiguration = 2
         NumPanes = 3
         Configuration = "(H (1 [50] 2 [25] 3))"
      End
      Begin PaneConfiguration = 3
         NumPanes = 3
         Configuration = "(H (4 [30] 2 [40] 3))"
      End
      Begin PaneConfiguration = 4
         NumPanes = 2
         Configuration = "(H (1 [56] 3))"
      End
      Begin PaneConfiguration = 5
         NumPanes = 2
         Configuration = "(H (2 [66] 3))"
      End
      Begin PaneConfiguration = 6
         NumPanes = 2
         Configuration = "(H (4 [50] 3))"
      End
      Begin PaneConfiguration = 7
         NumPanes = 1
         Configuration = "(V (3))"
      End
      Begin PaneConfiguration = 8
         NumPanes = 3
         Configuration = "(H (1[56] 4[18] 2) )"
      End
      Begin PaneConfiguration = 9
         NumPanes = 2
         Configuration = "(H (1 [75] 4))"
      End
      Begin PaneConfiguration = 10
         NumPanes = 2
         Configuration = "(H (1[66] 2) )"
      End
      Begin PaneConfiguration = 11
         NumPanes = 2
         Configuration = "(H (4 [60] 2))"
      End
      Begin PaneConfiguration = 12
         NumPanes = 1
         Configuration = "(H (1) )"
      End
      Begin PaneConfiguration = 13
         NumPanes = 1
         Configuration = "(V (4))"
      End
      Begin PaneConfiguration = 14
         NumPanes = 1
         Configuration = "(V (2))"
      End
      ActivePaneConfig = 0
   End
   Begin DiagramPane = 
      Begin Origin = 
         Top = 0
         Left = 0
      End
      Begin Tables = 
         Begin Table = "common_dictionary"
            Begin Extent = 
               Top = 6
               Left = 38
               Bottom = 123
               Right = 220
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "vw_type_uniqueness"
            Begin Extent = 
               Top = 6
               Left = 258
               Bottom = 93
               Right = 440
            End
            DisplayFlags = 280
            TopColumn = 0
         End
      End
   End
   Begin SQLPane = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 12
         Column = 1440
         Alias = 900
         Table = 1170
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1350
         SortOrder = 1410
         GroupBy = 1350
         Filter = 1350
         Or = 1350
         Or = 1350
         Or = 1350
      End
   End
End
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'vw_set_country_code'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'vw_set_country_code'
GO

/****** Object:  View [dbo].[vw_set_entity_type_code]    Script Date: 03/18/2012 14:23:46 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

/*create view vw_set_state_name
as
SELECT     common_dictionary.type_value, SUM(common_dictionary.cardinality) as cardinality
FROM         common_dictionary 
INNER JOIN
vw_type_uniqueness 
ON common_dictionary.type_name = vw_type_uniqueness.type_name
where common_dictionary.type_name like '%state name%'
group by common_dictionary.type_value
create view vw_set_taxonomy
as
SELECT     common_dictionary.type_value, SUM(common_dictionary.cardinality) as cardinality
FROM         common_dictionary 
INNER JOIN
vw_type_uniqueness 
ON common_dictionary.type_name = vw_type_uniqueness.type_name
where common_dictionary.type_name like '%taxonomy code%'
group by common_dictionary.type_value
create view vw_set_country_code
as
SELECT     common_dictionary.type_value, SUM(common_dictionary.cardinality) as cardinality
FROM         common_dictionary 
INNER JOIN
vw_type_uniqueness 
ON common_dictionary.type_name = vw_type_uniqueness.type_name
where common_dictionary.type_name like '%country code%'
group by common_dictionary.type_value*/
CREATE VIEW [dbo].[vw_set_entity_type_code]
AS
SELECT     dbo.common_dictionary.database_name, dbo.common_dictionary.table_name, dbo.common_dictionary.dictionary_id, dbo.common_dictionary.type_value, 
                      SUM(dbo.common_dictionary.cardinality) AS cardinality
FROM         dbo.common_dictionary INNER JOIN
                      dbo.vw_type_uniqueness ON dbo.common_dictionary.type_name = dbo.vw_type_uniqueness.type_name
WHERE     (dbo.common_dictionary.type_name LIKE '%entity type code%')
GROUP BY dbo.common_dictionary.type_value, dbo.common_dictionary.database_name, dbo.common_dictionary.table_name, dbo.common_dictionary.dictionary_id

GO

EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[40] 4[20] 2[20] 3) )"
      End
      Begin PaneConfiguration = 1
         NumPanes = 3
         Configuration = "(H (1 [50] 4 [25] 3))"
      End
      Begin PaneConfiguration = 2
         NumPanes = 3
         Configuration = "(H (1 [50] 2 [25] 3))"
      End
      Begin PaneConfiguration = 3
         NumPanes = 3
         Configuration = "(H (4 [30] 2 [40] 3))"
      End
      Begin PaneConfiguration = 4
         NumPanes = 2
         Configuration = "(H (1 [56] 3))"
      End
      Begin PaneConfiguration = 5
         NumPanes = 2
         Configuration = "(H (2 [66] 3))"
      End
      Begin PaneConfiguration = 6
         NumPanes = 2
         Configuration = "(H (4 [50] 3))"
      End
      Begin PaneConfiguration = 7
         NumPanes = 1
         Configuration = "(V (3))"
      End
      Begin PaneConfiguration = 8
         NumPanes = 3
         Configuration = "(H (1[56] 4[18] 2) )"
      End
      Begin PaneConfiguration = 9
         NumPanes = 2
         Configuration = "(H (1 [75] 4))"
      End
      Begin PaneConfiguration = 10
         NumPanes = 2
         Configuration = "(H (1[66] 2) )"
      End
      Begin PaneConfiguration = 11
         NumPanes = 2
         Configuration = "(H (4 [60] 2))"
      End
      Begin PaneConfiguration = 12
         NumPanes = 1
         Configuration = "(H (1) )"
      End
      Begin PaneConfiguration = 13
         NumPanes = 1
         Configuration = "(V (4))"
      End
      Begin PaneConfiguration = 14
         NumPanes = 1
         Configuration = "(V (2))"
      End
      ActivePaneConfig = 0
   End
   Begin DiagramPane = 
      Begin Origin = 
         Top = 0
         Left = 0
      End
      Begin Tables = 
         Begin Table = "common_dictionary"
            Begin Extent = 
               Top = 6
               Left = 38
               Bottom = 123
               Right = 220
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "vw_type_uniqueness"
            Begin Extent = 
               Top = 6
               Left = 258
               Bottom = 93
               Right = 440
            End
            DisplayFlags = 280
            TopColumn = 0
         End
      End
   End
   Begin SQLPane = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 12
         Column = 1440
         Alias = 900
         Table = 1170
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1350
         SortOrder = 1410
         GroupBy = 1350
         Filter = 1350
         Or = 1350
         Or = 1350
         Or = 1350
      End
   End
End
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'vw_set_entity_type_code'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'vw_set_entity_type_code'
GO

/****** Object:  View [dbo].[vw_set_first_name]    Script Date: 03/18/2012 14:23:46 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE VIEW [dbo].[vw_set_first_name]
AS
SELECT     dbo.common_dictionary.database_name, dbo.common_dictionary.table_name, dbo.common_dictionary.dictionary_id, dbo.common_dictionary.type_value, 
                      SUM(dbo.common_dictionary.cardinality) AS cardinality
FROM         dbo.common_dictionary INNER JOIN
                      dbo.vw_type_uniqueness ON dbo.common_dictionary.type_name = dbo.vw_type_uniqueness.type_name
WHERE     (dbo.common_dictionary.type_name IN ('AUTHORIZED OFFICIAL FIRST NAME', 'PROVIDER FIRST NAME', 'PROVIDER OTHER FIRST NAME'))
GROUP BY dbo.common_dictionary.type_value, dbo.common_dictionary.database_name, dbo.common_dictionary.table_name, dbo.common_dictionary.dictionary_id

GO

EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[40] 4[20] 2[20] 3) )"
      End
      Begin PaneConfiguration = 1
         NumPanes = 3
         Configuration = "(H (1 [50] 4 [25] 3))"
      End
      Begin PaneConfiguration = 2
         NumPanes = 3
         Configuration = "(H (1 [50] 2 [25] 3))"
      End
      Begin PaneConfiguration = 3
         NumPanes = 3
         Configuration = "(H (4 [30] 2 [40] 3))"
      End
      Begin PaneConfiguration = 4
         NumPanes = 2
         Configuration = "(H (1 [56] 3))"
      End
      Begin PaneConfiguration = 5
         NumPanes = 2
         Configuration = "(H (2 [66] 3))"
      End
      Begin PaneConfiguration = 6
         NumPanes = 2
         Configuration = "(H (4 [50] 3))"
      End
      Begin PaneConfiguration = 7
         NumPanes = 1
         Configuration = "(V (3))"
      End
      Begin PaneConfiguration = 8
         NumPanes = 3
         Configuration = "(H (1[56] 4[18] 2) )"
      End
      Begin PaneConfiguration = 9
         NumPanes = 2
         Configuration = "(H (1 [75] 4))"
      End
      Begin PaneConfiguration = 10
         NumPanes = 2
         Configuration = "(H (1[66] 2) )"
      End
      Begin PaneConfiguration = 11
         NumPanes = 2
         Configuration = "(H (4 [60] 2))"
      End
      Begin PaneConfiguration = 12
         NumPanes = 1
         Configuration = "(H (1) )"
      End
      Begin PaneConfiguration = 13
         NumPanes = 1
         Configuration = "(V (4))"
      End
      Begin PaneConfiguration = 14
         NumPanes = 1
         Configuration = "(V (2))"
      End
      ActivePaneConfig = 0
   End
   Begin DiagramPane = 
      Begin Origin = 
         Top = 0
         Left = 0
      End
      Begin Tables = 
         Begin Table = "common_dictionary"
            Begin Extent = 
               Top = 6
               Left = 38
               Bottom = 123
               Right = 220
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "vw_type_uniqueness"
            Begin Extent = 
               Top = 6
               Left = 258
               Bottom = 93
               Right = 440
            End
            DisplayFlags = 280
            TopColumn = 0
         End
      End
   End
   Begin SQLPane = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 12
         Column = 1440
         Alias = 900
         Table = 1170
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1350
         SortOrder = 1410
         GroupBy = 1350
         Filter = 1350
         Or = 1350
         Or = 1350
         Or = 1350
      End
   End
End
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'vw_set_first_name'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'vw_set_first_name'
GO

/****** Object:  View [dbo].[vw_set_is_sole_proprietor]    Script Date: 03/18/2012 14:23:46 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

/*create view vw_set_state_name
as
SELECT     common_dictionary.type_value, SUM(common_dictionary.cardinality) as cardinality
FROM         common_dictionary 
INNER JOIN
vw_type_uniqueness 
ON common_dictionary.type_name = vw_type_uniqueness.type_name
where common_dictionary.type_name like '%state name%'
group by common_dictionary.type_value
create view vw_set_taxonomy
as
SELECT     common_dictionary.type_value, SUM(common_dictionary.cardinality) as cardinality
FROM         common_dictionary 
INNER JOIN
vw_type_uniqueness 
ON common_dictionary.type_name = vw_type_uniqueness.type_name
where common_dictionary.type_name like '%taxonomy code%'
group by common_dictionary.type_value
create view vw_set_country_code
as
SELECT     common_dictionary.type_value, SUM(common_dictionary.cardinality) as cardinality
FROM         common_dictionary 
INNER JOIN
vw_type_uniqueness 
ON common_dictionary.type_name = vw_type_uniqueness.type_name
where common_dictionary.type_name like '%country code%'
group by common_dictionary.type_value
create view vw_set_entity_type_code
as
SELECT     common_dictionary.type_value, SUM(common_dictionary.cardinality) as cardinality
FROM         common_dictionary 
INNER JOIN
vw_type_uniqueness 
ON common_dictionary.type_name = vw_type_uniqueness.type_name
where common_dictionary.type_name like '%entity type code%'
group by common_dictionary.type_value
create view vw_set_provider_gender_code
as
SELECT     common_dictionary.type_value, SUM(common_dictionary.cardinality) as cardinality
FROM         common_dictionary 
INNER JOIN
vw_type_uniqueness 
ON common_dictionary.type_name = vw_type_uniqueness.type_name
where common_dictionary.type_name = 'provider gender code'
group by common_dictionary.type_value
create view vw_set_last_update_year_month
as
SELECT     (cast(common_dictionary.as_year as varchar(5)) + '-'
 + cast(common_dictionary.as_month as varchar(3)) ) as [type_value], 
 SUM(common_dictionary.cardinality) as cardinality
FROM         common_dictionary 
INNER JOIN
vw_type_uniqueness 
ON common_dictionary.type_name = vw_type_uniqueness.type_name
where common_dictionary.type_name = 'LAST UPDATE DATE'
group by common_dictionary.as_year, common_dictionary.as_month*/
CREATE VIEW [dbo].[vw_set_is_sole_proprietor]
AS
SELECT     dbo.common_dictionary.database_name, dbo.common_dictionary.table_name, dbo.common_dictionary.dictionary_id, dbo.common_dictionary.type_value, 
                      SUM(dbo.common_dictionary.cardinality) AS cardinality
FROM         dbo.common_dictionary INNER JOIN
                      dbo.vw_type_uniqueness ON dbo.common_dictionary.type_name = dbo.vw_type_uniqueness.type_name
WHERE     (dbo.common_dictionary.type_name = 'is sole proprietor')
GROUP BY dbo.common_dictionary.type_value, dbo.common_dictionary.database_name, dbo.common_dictionary.table_name, dbo.common_dictionary.dictionary_id

GO

EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[40] 4[20] 2[20] 3) )"
      End
      Begin PaneConfiguration = 1
         NumPanes = 3
         Configuration = "(H (1 [50] 4 [25] 3))"
      End
      Begin PaneConfiguration = 2
         NumPanes = 3
         Configuration = "(H (1 [50] 2 [25] 3))"
      End
      Begin PaneConfiguration = 3
         NumPanes = 3
         Configuration = "(H (4 [30] 2 [40] 3))"
      End
      Begin PaneConfiguration = 4
         NumPanes = 2
         Configuration = "(H (1 [56] 3))"
      End
      Begin PaneConfiguration = 5
         NumPanes = 2
         Configuration = "(H (2 [66] 3))"
      End
      Begin PaneConfiguration = 6
         NumPanes = 2
         Configuration = "(H (4 [50] 3))"
      End
      Begin PaneConfiguration = 7
         NumPanes = 1
         Configuration = "(V (3))"
      End
      Begin PaneConfiguration = 8
         NumPanes = 3
         Configuration = "(H (1[56] 4[18] 2) )"
      End
      Begin PaneConfiguration = 9
         NumPanes = 2
         Configuration = "(H (1 [75] 4))"
      End
      Begin PaneConfiguration = 10
         NumPanes = 2
         Configuration = "(H (1[66] 2) )"
      End
      Begin PaneConfiguration = 11
         NumPanes = 2
         Configuration = "(H (4 [60] 2))"
      End
      Begin PaneConfiguration = 12
         NumPanes = 1
         Configuration = "(H (1) )"
      End
      Begin PaneConfiguration = 13
         NumPanes = 1
         Configuration = "(V (4))"
      End
      Begin PaneConfiguration = 14
         NumPanes = 1
         Configuration = "(V (2))"
      End
      ActivePaneConfig = 0
   End
   Begin DiagramPane = 
      Begin Origin = 
         Top = 0
         Left = 0
      End
      Begin Tables = 
         Begin Table = "common_dictionary"
            Begin Extent = 
               Top = 6
               Left = 38
               Bottom = 123
               Right = 220
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "vw_type_uniqueness"
            Begin Extent = 
               Top = 6
               Left = 258
               Bottom = 93
               Right = 440
            End
            DisplayFlags = 280
            TopColumn = 0
         End
      End
   End
   Begin SQLPane = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 12
         Column = 1440
         Alias = 900
         Table = 1170
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1350
         SortOrder = 1410
         GroupBy = 1350
         Filter = 1350
         Or = 1350
         Or = 1350
         Or = 1350
      End
   End
End
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'vw_set_is_sole_proprietor'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'vw_set_is_sole_proprietor'
GO

/****** Object:  View [dbo].[vw_set_last_name]    Script Date: 03/18/2012 14:23:46 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

/*create view vw_set_state_name
as
SELECT     common_dictionary.type_value, SUM(common_dictionary.cardinality) as cardinality
FROM         common_dictionary 
INNER JOIN
vw_type_uniqueness 
ON common_dictionary.type_name = vw_type_uniqueness.type_name
where common_dictionary.type_name like '%state name%'
group by common_dictionary.type_value
create view vw_set_taxonomy
as
SELECT     common_dictionary.type_value, SUM(common_dictionary.cardinality) as cardinality
FROM         common_dictionary 
INNER JOIN
vw_type_uniqueness 
ON common_dictionary.type_name = vw_type_uniqueness.type_name
where common_dictionary.type_name like '%taxonomy code%'
group by common_dictionary.type_value
create view vw_set_country_code
as
SELECT     common_dictionary.type_value, SUM(common_dictionary.cardinality) as cardinality
FROM         common_dictionary 
INNER JOIN
vw_type_uniqueness 
ON common_dictionary.type_name = vw_type_uniqueness.type_name
where common_dictionary.type_name like '%country code%'
group by common_dictionary.type_value
create view vw_set_entity_type_code
as
SELECT     common_dictionary.type_value, SUM(common_dictionary.cardinality) as cardinality
FROM         common_dictionary 
INNER JOIN
vw_type_uniqueness 
ON common_dictionary.type_name = vw_type_uniqueness.type_name
where common_dictionary.type_name like '%entity type code%'
group by common_dictionary.type_value
create view vw_set_provider_gender_code
as
SELECT     common_dictionary.type_value, SUM(common_dictionary.cardinality) as cardinality
FROM         common_dictionary 
INNER JOIN
vw_type_uniqueness 
ON common_dictionary.type_name = vw_type_uniqueness.type_name
where common_dictionary.type_name = 'provider gender code'
group by common_dictionary.type_value
create view vw_set_last_update_year_month
as
SELECT     (cast(common_dictionary.as_year as varchar(5)) + '-'
 + cast(common_dictionary.as_month as varchar(3)) ) as [type_value], 
 SUM(common_dictionary.cardinality) as cardinality
FROM         common_dictionary 
INNER JOIN
vw_type_uniqueness 
ON common_dictionary.type_name = vw_type_uniqueness.type_name
where common_dictionary.type_name = 'LAST UPDATE DATE'
group by common_dictionary.as_year, common_dictionary.as_month
create view vw_set_is_sole_proprietor
as
SELECT     common_dictionary.type_value, SUM(common_dictionary.cardinality) as cardinality
FROM         common_dictionary 
INNER JOIN
vw_type_uniqueness 
ON common_dictionary.type_name = vw_type_uniqueness.type_name
where common_dictionary.type_name = 'is sole proprietor'
group by common_dictionary.type_value
create view vw_set_provider_credential_text
as
SELECT     common_dictionary.type_value, SUM(common_dictionary.cardinality) as cardinality
FROM         common_dictionary 
INNER JOIN
vw_type_uniqueness 
ON common_dictionary.type_name = vw_type_uniqueness.type_name
where common_dictionary.type_name = 'PROVIDER CREDENTIAL TEXT'
group by common_dictionary.type_value
create view vw_set_provider_taxonomy_group
as
SELECT     common_dictionary.type_value, SUM(common_dictionary.cardinality) as cardinality
FROM         common_dictionary 
INNER JOIN
vw_type_uniqueness 
ON common_dictionary.type_name = vw_type_uniqueness.type_name
where common_dictionary.type_name like '%PROVIDER TAXONOMY GROUP%'
group by common_dictionary.type_value
create view vw_set_primary_taxonomy_switch
as
SELECT     common_dictionary.type_value, SUM(common_dictionary.cardinality) as cardinality
FROM         common_dictionary 
INNER JOIN
vw_type_uniqueness 
ON common_dictionary.type_name = vw_type_uniqueness.type_name
where common_dictionary.type_name like '%primary taxonomy switch%'
group by common_dictionary.type_value
create view vw_set_provider_name_prefix
as
SELECT     common_dictionary.type_value, SUM(common_dictionary.cardinality) as cardinality
FROM         common_dictionary 
INNER JOIN
vw_type_uniqueness 
ON common_dictionary.type_name = vw_type_uniqueness.type_name
where common_dictionary.type_name like '%provider name prefix%'
group by common_dictionary.type_value
create view vw_set_official_title
as
SELECT     common_dictionary.type_value, SUM(common_dictionary.cardinality) as cardinality
FROM         common_dictionary 
INNER JOIN
vw_type_uniqueness 
ON common_dictionary.type_name = vw_type_uniqueness.type_name
where common_dictionary.type_name = 'AUTHORIZED OFFICIAL TITLE OR POSITION'
group by common_dictionary.type_value
create view vw_set_provider_license_state_code
as
SELECT     common_dictionary.type_value, SUM(common_dictionary.cardinality) as cardinality
FROM         common_dictionary 
INNER JOIN
vw_type_uniqueness 
ON common_dictionary.type_name = vw_type_uniqueness.type_name
where common_dictionary.type_name like '%PROVIDER LICENSE NUMBER STATE CODE%'
group by common_dictionary.type_value
create view vw_set_provider_license_state_code
as
SELECT     common_dictionary.type_value, SUM(common_dictionary.cardinality) as cardinality
FROM         common_dictionary 
INNER JOIN
vw_type_uniqueness 
ON common_dictionary.type_name = vw_type_uniqueness.type_name
where common_dictionary.type_name like '%PROVIDER LICENSE NUMBER STATE CODE%'
group by common_dictionary.type_value
create view vw_set_provider_enumeration_year_month
as
SELECT     (cast(common_dictionary.as_year as varchar(5)) + '-'
 + cast(common_dictionary.as_month as varchar(3)) ) as [type_value], 
 SUM(common_dictionary.cardinality) as cardinality
FROM         common_dictionary 
INNER JOIN
vw_type_uniqueness 
ON common_dictionary.type_name = vw_type_uniqueness.type_name
where common_dictionary.type_name = 'PROVIDER ENUMERATION DATE'
group by common_dictionary.as_year, common_dictionary.as_month
'(AUTHORIZED OFFICIAL LAST NAME',
'PROVIDER LAST NAME (LEGAL NAME)',
'PROVIDER OTHER LAST NAME')*/
CREATE VIEW [dbo].[vw_set_last_name]
AS
SELECT     dbo.common_dictionary.database_name, dbo.common_dictionary.table_name, dbo.common_dictionary.dictionary_id, dbo.common_dictionary.type_value, 
                      SUM(dbo.common_dictionary.cardinality) AS cardinality
FROM         dbo.common_dictionary INNER JOIN
                      dbo.vw_type_uniqueness ON dbo.common_dictionary.type_name = dbo.vw_type_uniqueness.type_name
WHERE     (dbo.common_dictionary.type_name IN ('AUTHORIZED OFFICIAL LAST NAME', 'PROVIDER LAST NAME (LEGAL NAME)', 'PROVIDER OTHER LAST NAME'))
GROUP BY dbo.common_dictionary.type_value, dbo.common_dictionary.database_name, dbo.common_dictionary.table_name, dbo.common_dictionary.dictionary_id

GO

EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[40] 4[20] 2[20] 3) )"
      End
      Begin PaneConfiguration = 1
         NumPanes = 3
         Configuration = "(H (1 [50] 4 [25] 3))"
      End
      Begin PaneConfiguration = 2
         NumPanes = 3
         Configuration = "(H (1 [50] 2 [25] 3))"
      End
      Begin PaneConfiguration = 3
         NumPanes = 3
         Configuration = "(H (4 [30] 2 [40] 3))"
      End
      Begin PaneConfiguration = 4
         NumPanes = 2
         Configuration = "(H (1 [56] 3))"
      End
      Begin PaneConfiguration = 5
         NumPanes = 2
         Configuration = "(H (2 [66] 3))"
      End
      Begin PaneConfiguration = 6
         NumPanes = 2
         Configuration = "(H (4 [50] 3))"
      End
      Begin PaneConfiguration = 7
         NumPanes = 1
         Configuration = "(V (3))"
      End
      Begin PaneConfiguration = 8
         NumPanes = 3
         Configuration = "(H (1[56] 4[18] 2) )"
      End
      Begin PaneConfiguration = 9
         NumPanes = 2
         Configuration = "(H (1 [75] 4))"
      End
      Begin PaneConfiguration = 10
         NumPanes = 2
         Configuration = "(H (1[66] 2) )"
      End
      Begin PaneConfiguration = 11
         NumPanes = 2
         Configuration = "(H (4 [60] 2))"
      End
      Begin PaneConfiguration = 12
         NumPanes = 1
         Configuration = "(H (1) )"
      End
      Begin PaneConfiguration = 13
         NumPanes = 1
         Configuration = "(V (4))"
      End
      Begin PaneConfiguration = 14
         NumPanes = 1
         Configuration = "(V (2))"
      End
      ActivePaneConfig = 0
   End
   Begin DiagramPane = 
      Begin Origin = 
         Top = 0
         Left = 0
      End
      Begin Tables = 
         Begin Table = "common_dictionary"
            Begin Extent = 
               Top = 6
               Left = 38
               Bottom = 123
               Right = 220
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "vw_type_uniqueness"
            Begin Extent = 
               Top = 6
               Left = 258
               Bottom = 93
               Right = 440
            End
            DisplayFlags = 280
            TopColumn = 0
         End
      End
   End
   Begin SQLPane = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 12
         Column = 1440
         Alias = 900
         Table = 1170
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1350
         SortOrder = 1410
         GroupBy = 1350
         Filter = 1350
         Or = 1350
         Or = 1350
         Or = 1350
      End
   End
End
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'vw_set_last_name'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'vw_set_last_name'
GO

/****** Object:  View [dbo].[vw_set_last_update_year_month]    Script Date: 03/18/2012 14:23:46 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

/*create view vw_set_state_name
as
SELECT     common_dictionary.type_value, SUM(common_dictionary.cardinality) as cardinality
FROM         common_dictionary 
INNER JOIN
vw_type_uniqueness 
ON common_dictionary.type_name = vw_type_uniqueness.type_name
where common_dictionary.type_name like '%state name%'
group by common_dictionary.type_value
create view vw_set_taxonomy
as
SELECT     common_dictionary.type_value, SUM(common_dictionary.cardinality) as cardinality
FROM         common_dictionary 
INNER JOIN
vw_type_uniqueness 
ON common_dictionary.type_name = vw_type_uniqueness.type_name
where common_dictionary.type_name like '%taxonomy code%'
group by common_dictionary.type_value
create view vw_set_country_code
as
SELECT     common_dictionary.type_value, SUM(common_dictionary.cardinality) as cardinality
FROM         common_dictionary 
INNER JOIN
vw_type_uniqueness 
ON common_dictionary.type_name = vw_type_uniqueness.type_name
where common_dictionary.type_name like '%country code%'
group by common_dictionary.type_value
create view vw_set_entity_type_code
as
SELECT     common_dictionary.type_value, SUM(common_dictionary.cardinality) as cardinality
FROM         common_dictionary 
INNER JOIN
vw_type_uniqueness 
ON common_dictionary.type_name = vw_type_uniqueness.type_name
where common_dictionary.type_name like '%entity type code%'
group by common_dictionary.type_value
create view vw_set_provider_gender_code
as
SELECT     common_dictionary.type_value, SUM(common_dictionary.cardinality) as cardinality
FROM         common_dictionary 
INNER JOIN
vw_type_uniqueness 
ON common_dictionary.type_name = vw_type_uniqueness.type_name
where common_dictionary.type_name = 'provider gender code'
group by common_dictionary.type_value*/
CREATE VIEW [dbo].[vw_set_last_update_year_month]
AS
SELECT     dbo.common_dictionary.database_name, dbo.common_dictionary.table_name, dbo.common_dictionary.dictionary_id, 
                      CAST(dbo.common_dictionary.as_year AS varchar(5)) + '-' + CAST(dbo.common_dictionary.as_month AS varchar(3)) AS type_value, 
                      SUM(dbo.common_dictionary.cardinality) AS cardinality
FROM         dbo.common_dictionary INNER JOIN
                      dbo.vw_type_uniqueness ON dbo.common_dictionary.type_name = dbo.vw_type_uniqueness.type_name
WHERE     (dbo.common_dictionary.type_name = 'LAST UPDATE DATE')
GROUP BY dbo.common_dictionary.as_year, dbo.common_dictionary.as_month, dbo.common_dictionary.database_name, dbo.common_dictionary.table_name, 
                      dbo.common_dictionary.dictionary_id

GO

EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[40] 4[20] 2[20] 3) )"
      End
      Begin PaneConfiguration = 1
         NumPanes = 3
         Configuration = "(H (1 [50] 4 [25] 3))"
      End
      Begin PaneConfiguration = 2
         NumPanes = 3
         Configuration = "(H (1 [50] 2 [25] 3))"
      End
      Begin PaneConfiguration = 3
         NumPanes = 3
         Configuration = "(H (4 [30] 2 [40] 3))"
      End
      Begin PaneConfiguration = 4
         NumPanes = 2
         Configuration = "(H (1 [56] 3))"
      End
      Begin PaneConfiguration = 5
         NumPanes = 2
         Configuration = "(H (2 [66] 3))"
      End
      Begin PaneConfiguration = 6
         NumPanes = 2
         Configuration = "(H (4 [50] 3))"
      End
      Begin PaneConfiguration = 7
         NumPanes = 1
         Configuration = "(V (3))"
      End
      Begin PaneConfiguration = 8
         NumPanes = 3
         Configuration = "(H (1[56] 4[18] 2) )"
      End
      Begin PaneConfiguration = 9
         NumPanes = 2
         Configuration = "(H (1 [75] 4))"
      End
      Begin PaneConfiguration = 10
         NumPanes = 2
         Configuration = "(H (1[66] 2) )"
      End
      Begin PaneConfiguration = 11
         NumPanes = 2
         Configuration = "(H (4 [60] 2))"
      End
      Begin PaneConfiguration = 12
         NumPanes = 1
         Configuration = "(H (1) )"
      End
      Begin PaneConfiguration = 13
         NumPanes = 1
         Configuration = "(V (4))"
      End
      Begin PaneConfiguration = 14
         NumPanes = 1
         Configuration = "(V (2))"
      End
      ActivePaneConfig = 0
   End
   Begin DiagramPane = 
      Begin Origin = 
         Top = 0
         Left = 0
      End
      Begin Tables = 
         Begin Table = "common_dictionary"
            Begin Extent = 
               Top = 6
               Left = 38
               Bottom = 123
               Right = 220
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "vw_type_uniqueness"
            Begin Extent = 
               Top = 6
               Left = 258
               Bottom = 93
               Right = 440
            End
            DisplayFlags = 280
            TopColumn = 0
         End
      End
   End
   Begin SQLPane = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 12
         Column = 1440
         Alias = 900
         Table = 1170
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1350
         SortOrder = 1410
         GroupBy = 1350
         Filter = 1350
         Or = 1350
         Or = 1350
         Or = 1350
      End
   End
End
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'vw_set_last_update_year_month'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'vw_set_last_update_year_month'
GO

/****** Object:  View [dbo].[vw_set_npi_deactivation_year_month]    Script Date: 03/18/2012 14:23:46 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE VIEW [dbo].[vw_set_npi_deactivation_year_month]
AS
SELECT     dbo.common_dictionary.database_name, dbo.common_dictionary.table_name, dbo.common_dictionary.dictionary_id, 
                      CAST(dbo.common_dictionary.as_year AS varchar(5)) + '-' + CAST(dbo.common_dictionary.as_month AS varchar(3)) AS type_value, 
                      SUM(dbo.common_dictionary.cardinality) AS cardinality
FROM         dbo.common_dictionary INNER JOIN
                      dbo.vw_type_uniqueness ON dbo.common_dictionary.type_name = dbo.vw_type_uniqueness.type_name
WHERE     (dbo.common_dictionary.type_name = 'NPI DEACTIVATION DATE')
GROUP BY dbo.common_dictionary.as_year, dbo.common_dictionary.as_month, dbo.common_dictionary.database_name, dbo.common_dictionary.table_name, 
                      dbo.common_dictionary.dictionary_id

GO

EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[40] 4[20] 2[20] 3) )"
      End
      Begin PaneConfiguration = 1
         NumPanes = 3
         Configuration = "(H (1 [50] 4 [25] 3))"
      End
      Begin PaneConfiguration = 2
         NumPanes = 3
         Configuration = "(H (1 [50] 2 [25] 3))"
      End
      Begin PaneConfiguration = 3
         NumPanes = 3
         Configuration = "(H (4 [30] 2 [40] 3))"
      End
      Begin PaneConfiguration = 4
         NumPanes = 2
         Configuration = "(H (1 [56] 3))"
      End
      Begin PaneConfiguration = 5
         NumPanes = 2
         Configuration = "(H (2 [66] 3))"
      End
      Begin PaneConfiguration = 6
         NumPanes = 2
         Configuration = "(H (4 [50] 3))"
      End
      Begin PaneConfiguration = 7
         NumPanes = 1
         Configuration = "(V (3))"
      End
      Begin PaneConfiguration = 8
         NumPanes = 3
         Configuration = "(H (1[56] 4[18] 2) )"
      End
      Begin PaneConfiguration = 9
         NumPanes = 2
         Configuration = "(H (1 [75] 4))"
      End
      Begin PaneConfiguration = 10
         NumPanes = 2
         Configuration = "(H (1[66] 2) )"
      End
      Begin PaneConfiguration = 11
         NumPanes = 2
         Configuration = "(H (4 [60] 2))"
      End
      Begin PaneConfiguration = 12
         NumPanes = 1
         Configuration = "(H (1) )"
      End
      Begin PaneConfiguration = 13
         NumPanes = 1
         Configuration = "(V (4))"
      End
      Begin PaneConfiguration = 14
         NumPanes = 1
         Configuration = "(V (2))"
      End
      ActivePaneConfig = 0
   End
   Begin DiagramPane = 
      Begin Origin = 
         Top = 0
         Left = 0
      End
      Begin Tables = 
         Begin Table = "common_dictionary"
            Begin Extent = 
               Top = 6
               Left = 38
               Bottom = 123
               Right = 220
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "vw_type_uniqueness"
            Begin Extent = 
               Top = 6
               Left = 258
               Bottom = 93
               Right = 440
            End
            DisplayFlags = 280
            TopColumn = 0
         End
      End
   End
   Begin SQLPane = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 12
         Column = 1440
         Alias = 900
         Table = 1170
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1350
         SortOrder = 1410
         GroupBy = 1350
         Filter = 1350
         Or = 1350
         Or = 1350
         Or = 1350
      End
   End
End
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'vw_set_npi_deactivation_year_month'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'vw_set_npi_deactivation_year_month'
GO

/****** Object:  View [dbo].[vw_set_npi_reactivation_year_month]    Script Date: 03/18/2012 14:23:46 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

/*create view vw_set_state_name
as
SELECT     common_dictionary.type_value, SUM(common_dictionary.cardinality) as cardinality
FROM         common_dictionary 
INNER JOIN
vw_type_uniqueness 
ON common_dictionary.type_name = vw_type_uniqueness.type_name
where common_dictionary.type_name like '%state name%'
group by common_dictionary.type_value
create view vw_set_taxonomy
as
SELECT     common_dictionary.type_value, SUM(common_dictionary.cardinality) as cardinality
FROM         common_dictionary 
INNER JOIN
vw_type_uniqueness 
ON common_dictionary.type_name = vw_type_uniqueness.type_name
where common_dictionary.type_name like '%taxonomy code%'
group by common_dictionary.type_value
create view vw_set_country_code
as
SELECT     common_dictionary.type_value, SUM(common_dictionary.cardinality) as cardinality
FROM         common_dictionary 
INNER JOIN
vw_type_uniqueness 
ON common_dictionary.type_name = vw_type_uniqueness.type_name
where common_dictionary.type_name like '%country code%'
group by common_dictionary.type_value
create view vw_set_entity_type_code
as
SELECT     common_dictionary.type_value, SUM(common_dictionary.cardinality) as cardinality
FROM         common_dictionary 
INNER JOIN
vw_type_uniqueness 
ON common_dictionary.type_name = vw_type_uniqueness.type_name
where common_dictionary.type_name like '%entity type code%'
group by common_dictionary.type_value
create view vw_set_provider_gender_code
as
SELECT     common_dictionary.type_value, SUM(common_dictionary.cardinality) as cardinality
FROM         common_dictionary 
INNER JOIN
vw_type_uniqueness 
ON common_dictionary.type_name = vw_type_uniqueness.type_name
where common_dictionary.type_name = 'provider gender code'
group by common_dictionary.type_value
create view vw_set_last_update_year_month
as
SELECT     (cast(common_dictionary.as_year as varchar(5)) + '-'
 + cast(common_dictionary.as_month as varchar(3)) ) as [type_value], 
 SUM(common_dictionary.cardinality) as cardinality
FROM         common_dictionary 
INNER JOIN
vw_type_uniqueness 
ON common_dictionary.type_name = vw_type_uniqueness.type_name
where common_dictionary.type_name = 'LAST UPDATE DATE'
group by common_dictionary.as_year, common_dictionary.as_month
create view vw_set_is_sole_proprietor
as
SELECT     common_dictionary.type_value, SUM(common_dictionary.cardinality) as cardinality
FROM         common_dictionary 
INNER JOIN
vw_type_uniqueness 
ON common_dictionary.type_name = vw_type_uniqueness.type_name
where common_dictionary.type_name = 'is sole proprietor'
group by common_dictionary.type_value
create view vw_set_provider_credential_text
as
SELECT     common_dictionary.type_value, SUM(common_dictionary.cardinality) as cardinality
FROM         common_dictionary 
INNER JOIN
vw_type_uniqueness 
ON common_dictionary.type_name = vw_type_uniqueness.type_name
where common_dictionary.type_name = 'PROVIDER CREDENTIAL TEXT'
group by common_dictionary.type_value
create view vw_set_provider_taxonomy_group
as
SELECT     common_dictionary.type_value, SUM(common_dictionary.cardinality) as cardinality
FROM         common_dictionary 
INNER JOIN
vw_type_uniqueness 
ON common_dictionary.type_name = vw_type_uniqueness.type_name
where common_dictionary.type_name like '%PROVIDER TAXONOMY GROUP%'
group by common_dictionary.type_value
create view vw_set_primary_taxonomy_switch
as
SELECT     common_dictionary.type_value, SUM(common_dictionary.cardinality) as cardinality
FROM         common_dictionary 
INNER JOIN
vw_type_uniqueness 
ON common_dictionary.type_name = vw_type_uniqueness.type_name
where common_dictionary.type_name like '%primary taxonomy switch%'
group by common_dictionary.type_value
create view vw_set_provider_name_prefix
as
SELECT     common_dictionary.type_value, SUM(common_dictionary.cardinality) as cardinality
FROM         common_dictionary 
INNER JOIN
vw_type_uniqueness 
ON common_dictionary.type_name = vw_type_uniqueness.type_name
where common_dictionary.type_name like '%provider name prefix%'
group by common_dictionary.type_value
create view vw_set_official_title
as
SELECT     common_dictionary.type_value, SUM(common_dictionary.cardinality) as cardinality
FROM         common_dictionary 
INNER JOIN
vw_type_uniqueness 
ON common_dictionary.type_name = vw_type_uniqueness.type_name
where common_dictionary.type_name = 'AUTHORIZED OFFICIAL TITLE OR POSITION'
group by common_dictionary.type_value
create view vw_set_provider_license_state_code
as
SELECT     common_dictionary.type_value, SUM(common_dictionary.cardinality) as cardinality
FROM         common_dictionary 
INNER JOIN
vw_type_uniqueness 
ON common_dictionary.type_name = vw_type_uniqueness.type_name
where common_dictionary.type_name like '%PROVIDER LICENSE NUMBER STATE CODE%'
group by common_dictionary.type_value
create view vw_set_provider_license_state_code
as
SELECT     common_dictionary.type_value, SUM(common_dictionary.cardinality) as cardinality
FROM         common_dictionary 
INNER JOIN
vw_type_uniqueness 
ON common_dictionary.type_name = vw_type_uniqueness.type_name
where common_dictionary.type_name like '%PROVIDER LICENSE NUMBER STATE CODE%'
group by common_dictionary.type_value*/
CREATE VIEW [dbo].[vw_set_npi_reactivation_year_month]
AS
SELECT     dbo.common_dictionary.database_name, dbo.common_dictionary.table_name, dbo.common_dictionary.dictionary_id, 
                      CAST(dbo.common_dictionary.as_year AS varchar(5)) + '-' + CAST(dbo.common_dictionary.as_month AS varchar(3)) AS type_value, 
                      SUM(dbo.common_dictionary.cardinality) AS cardinality
FROM         dbo.common_dictionary INNER JOIN
                      dbo.vw_type_uniqueness ON dbo.common_dictionary.type_name = dbo.vw_type_uniqueness.type_name
WHERE     (dbo.common_dictionary.type_name = 'NPI REACTIVATION DATE')
GROUP BY dbo.common_dictionary.as_year, dbo.common_dictionary.as_month, dbo.common_dictionary.database_name, dbo.common_dictionary.table_name, 
                      dbo.common_dictionary.dictionary_id

GO

EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[40] 4[20] 2[20] 3) )"
      End
      Begin PaneConfiguration = 1
         NumPanes = 3
         Configuration = "(H (1 [50] 4 [25] 3))"
      End
      Begin PaneConfiguration = 2
         NumPanes = 3
         Configuration = "(H (1 [50] 2 [25] 3))"
      End
      Begin PaneConfiguration = 3
         NumPanes = 3
         Configuration = "(H (4 [30] 2 [40] 3))"
      End
      Begin PaneConfiguration = 4
         NumPanes = 2
         Configuration = "(H (1 [56] 3))"
      End
      Begin PaneConfiguration = 5
         NumPanes = 2
         Configuration = "(H (2 [66] 3))"
      End
      Begin PaneConfiguration = 6
         NumPanes = 2
         Configuration = "(H (4 [50] 3))"
      End
      Begin PaneConfiguration = 7
         NumPanes = 1
         Configuration = "(V (3))"
      End
      Begin PaneConfiguration = 8
         NumPanes = 3
         Configuration = "(H (1[56] 4[18] 2) )"
      End
      Begin PaneConfiguration = 9
         NumPanes = 2
         Configuration = "(H (1 [75] 4))"
      End
      Begin PaneConfiguration = 10
         NumPanes = 2
         Configuration = "(H (1[66] 2) )"
      End
      Begin PaneConfiguration = 11
         NumPanes = 2
         Configuration = "(H (4 [60] 2))"
      End
      Begin PaneConfiguration = 12
         NumPanes = 1
         Configuration = "(H (1) )"
      End
      Begin PaneConfiguration = 13
         NumPanes = 1
         Configuration = "(V (4))"
      End
      Begin PaneConfiguration = 14
         NumPanes = 1
         Configuration = "(V (2))"
      End
      ActivePaneConfig = 0
   End
   Begin DiagramPane = 
      Begin Origin = 
         Top = 0
         Left = 0
      End
      Begin Tables = 
         Begin Table = "common_dictionary"
            Begin Extent = 
               Top = 6
               Left = 38
               Bottom = 123
               Right = 220
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "vw_type_uniqueness"
            Begin Extent = 
               Top = 6
               Left = 258
               Bottom = 93
               Right = 440
            End
            DisplayFlags = 280
            TopColumn = 0
         End
      End
   End
   Begin SQLPane = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 12
         Column = 1440
         Alias = 900
         Table = 1170
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1350
         SortOrder = 1410
         GroupBy = 1350
         Filter = 1350
         Or = 1350
         Or = 1350
         Or = 1350
      End
   End
End
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'vw_set_npi_reactivation_year_month'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'vw_set_npi_reactivation_year_month'
GO

/****** Object:  View [dbo].[vw_set_official_title]    Script Date: 03/18/2012 14:23:46 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

/*create view vw_set_state_name
as
SELECT     common_dictionary.type_value, SUM(common_dictionary.cardinality) as cardinality
FROM         common_dictionary 
INNER JOIN
vw_type_uniqueness 
ON common_dictionary.type_name = vw_type_uniqueness.type_name
where common_dictionary.type_name like '%state name%'
group by common_dictionary.type_value
create view vw_set_taxonomy
as
SELECT     common_dictionary.type_value, SUM(common_dictionary.cardinality) as cardinality
FROM         common_dictionary 
INNER JOIN
vw_type_uniqueness 
ON common_dictionary.type_name = vw_type_uniqueness.type_name
where common_dictionary.type_name like '%taxonomy code%'
group by common_dictionary.type_value
create view vw_set_country_code
as
SELECT     common_dictionary.type_value, SUM(common_dictionary.cardinality) as cardinality
FROM         common_dictionary 
INNER JOIN
vw_type_uniqueness 
ON common_dictionary.type_name = vw_type_uniqueness.type_name
where common_dictionary.type_name like '%country code%'
group by common_dictionary.type_value
create view vw_set_entity_type_code
as
SELECT     common_dictionary.type_value, SUM(common_dictionary.cardinality) as cardinality
FROM         common_dictionary 
INNER JOIN
vw_type_uniqueness 
ON common_dictionary.type_name = vw_type_uniqueness.type_name
where common_dictionary.type_name like '%entity type code%'
group by common_dictionary.type_value
create view vw_set_provider_gender_code
as
SELECT     common_dictionary.type_value, SUM(common_dictionary.cardinality) as cardinality
FROM         common_dictionary 
INNER JOIN
vw_type_uniqueness 
ON common_dictionary.type_name = vw_type_uniqueness.type_name
where common_dictionary.type_name = 'provider gender code'
group by common_dictionary.type_value
create view vw_set_last_update_year_month
as
SELECT     (cast(common_dictionary.as_year as varchar(5)) + '-'
 + cast(common_dictionary.as_month as varchar(3)) ) as [type_value], 
 SUM(common_dictionary.cardinality) as cardinality
FROM         common_dictionary 
INNER JOIN
vw_type_uniqueness 
ON common_dictionary.type_name = vw_type_uniqueness.type_name
where common_dictionary.type_name = 'LAST UPDATE DATE'
group by common_dictionary.as_year, common_dictionary.as_month
create view vw_set_is_sole_proprietor
as
SELECT     common_dictionary.type_value, SUM(common_dictionary.cardinality) as cardinality
FROM         common_dictionary 
INNER JOIN
vw_type_uniqueness 
ON common_dictionary.type_name = vw_type_uniqueness.type_name
where common_dictionary.type_name = 'is sole proprietor'
group by common_dictionary.type_value
create view vw_set_provider_credential_text
as
SELECT     common_dictionary.type_value, SUM(common_dictionary.cardinality) as cardinality
FROM         common_dictionary 
INNER JOIN
vw_type_uniqueness 
ON common_dictionary.type_name = vw_type_uniqueness.type_name
where common_dictionary.type_name = 'PROVIDER CREDENTIAL TEXT'
group by common_dictionary.type_value
create view vw_set_provider_taxonomy_group
as
SELECT     common_dictionary.type_value, SUM(common_dictionary.cardinality) as cardinality
FROM         common_dictionary 
INNER JOIN
vw_type_uniqueness 
ON common_dictionary.type_name = vw_type_uniqueness.type_name
where common_dictionary.type_name like '%PROVIDER TAXONOMY GROUP%'
group by common_dictionary.type_value
create view vw_set_primary_taxonomy_switch
as
SELECT     common_dictionary.type_value, SUM(common_dictionary.cardinality) as cardinality
FROM         common_dictionary 
INNER JOIN
vw_type_uniqueness 
ON common_dictionary.type_name = vw_type_uniqueness.type_name
where common_dictionary.type_name like '%primary taxonomy switch%'
group by common_dictionary.type_value
create view vw_set_provider_name_prefix
as
SELECT     common_dictionary.type_value, SUM(common_dictionary.cardinality) as cardinality
FROM         common_dictionary 
INNER JOIN
vw_type_uniqueness 
ON common_dictionary.type_name = vw_type_uniqueness.type_name
where common_dictionary.type_name like '%provider name prefix%'
group by common_dictionary.type_value*/
CREATE VIEW [dbo].[vw_set_official_title]
AS
SELECT     dbo.common_dictionary.database_name, dbo.common_dictionary.table_name, dbo.common_dictionary.dictionary_id, dbo.common_dictionary.type_value, 
                      SUM(dbo.common_dictionary.cardinality) AS cardinality
FROM         dbo.common_dictionary INNER JOIN
                      dbo.vw_type_uniqueness ON dbo.common_dictionary.type_name = dbo.vw_type_uniqueness.type_name
WHERE     (dbo.common_dictionary.type_name = 'AUTHORIZED OFFICIAL TITLE OR POSITION')
GROUP BY dbo.common_dictionary.type_value, dbo.common_dictionary.database_name, dbo.common_dictionary.table_name, dbo.common_dictionary.dictionary_id

GO

EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[40] 4[20] 2[20] 3) )"
      End
      Begin PaneConfiguration = 1
         NumPanes = 3
         Configuration = "(H (1 [50] 4 [25] 3))"
      End
      Begin PaneConfiguration = 2
         NumPanes = 3
         Configuration = "(H (1 [50] 2 [25] 3))"
      End
      Begin PaneConfiguration = 3
         NumPanes = 3
         Configuration = "(H (4 [30] 2 [40] 3))"
      End
      Begin PaneConfiguration = 4
         NumPanes = 2
         Configuration = "(H (1 [56] 3))"
      End
      Begin PaneConfiguration = 5
         NumPanes = 2
         Configuration = "(H (2 [66] 3))"
      End
      Begin PaneConfiguration = 6
         NumPanes = 2
         Configuration = "(H (4 [50] 3))"
      End
      Begin PaneConfiguration = 7
         NumPanes = 1
         Configuration = "(V (3))"
      End
      Begin PaneConfiguration = 8
         NumPanes = 3
         Configuration = "(H (1[56] 4[18] 2) )"
      End
      Begin PaneConfiguration = 9
         NumPanes = 2
         Configuration = "(H (1 [75] 4))"
      End
      Begin PaneConfiguration = 10
         NumPanes = 2
         Configuration = "(H (1[66] 2) )"
      End
      Begin PaneConfiguration = 11
         NumPanes = 2
         Configuration = "(H (4 [60] 2))"
      End
      Begin PaneConfiguration = 12
         NumPanes = 1
         Configuration = "(H (1) )"
      End
      Begin PaneConfiguration = 13
         NumPanes = 1
         Configuration = "(V (4))"
      End
      Begin PaneConfiguration = 14
         NumPanes = 1
         Configuration = "(V (2))"
      End
      ActivePaneConfig = 0
   End
   Begin DiagramPane = 
      Begin Origin = 
         Top = 0
         Left = 0
      End
      Begin Tables = 
         Begin Table = "common_dictionary"
            Begin Extent = 
               Top = 6
               Left = 38
               Bottom = 123
               Right = 220
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "vw_type_uniqueness"
            Begin Extent = 
               Top = 6
               Left = 258
               Bottom = 93
               Right = 440
            End
            DisplayFlags = 280
            TopColumn = 0
         End
      End
   End
   Begin SQLPane = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 12
         Column = 1440
         Alias = 900
         Table = 1170
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1350
         SortOrder = 1410
         GroupBy = 1350
         Filter = 1350
         Or = 1350
         Or = 1350
         Or = 1350
      End
   End
End
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'vw_set_official_title'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'vw_set_official_title'
GO

/****** Object:  View [dbo].[vw_set_postal_code]    Script Date: 03/18/2012 14:23:46 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE VIEW [dbo].[vw_set_postal_code]
AS
SELECT     dbo.common_dictionary.database_name, dbo.common_dictionary.table_name, dbo.common_dictionary.dictionary_id, 
                      SUBSTRING(dbo.common_dictionary.type_value, 1, 3) + '##' AS type_value, SUM(dbo.common_dictionary.cardinality) AS cardinality
FROM         dbo.common_dictionary INNER JOIN
                      dbo.vw_type_uniqueness ON dbo.common_dictionary.type_name = dbo.vw_type_uniqueness.type_name
WHERE     (dbo.common_dictionary.type_name LIKE '%postal code%')
GROUP BY SUBSTRING(dbo.common_dictionary.type_value, 1, 3) + '##', dbo.common_dictionary.database_name, dbo.common_dictionary.table_name, 
                      dbo.common_dictionary.dictionary_id

GO

EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[40] 4[20] 2[20] 3) )"
      End
      Begin PaneConfiguration = 1
         NumPanes = 3
         Configuration = "(H (1 [50] 4 [25] 3))"
      End
      Begin PaneConfiguration = 2
         NumPanes = 3
         Configuration = "(H (1 [50] 2 [25] 3))"
      End
      Begin PaneConfiguration = 3
         NumPanes = 3
         Configuration = "(H (4 [30] 2 [40] 3))"
      End
      Begin PaneConfiguration = 4
         NumPanes = 2
         Configuration = "(H (1 [56] 3))"
      End
      Begin PaneConfiguration = 5
         NumPanes = 2
         Configuration = "(H (2 [66] 3))"
      End
      Begin PaneConfiguration = 6
         NumPanes = 2
         Configuration = "(H (4 [50] 3))"
      End
      Begin PaneConfiguration = 7
         NumPanes = 1
         Configuration = "(V (3))"
      End
      Begin PaneConfiguration = 8
         NumPanes = 3
         Configuration = "(H (1[56] 4[18] 2) )"
      End
      Begin PaneConfiguration = 9
         NumPanes = 2
         Configuration = "(H (1 [75] 4))"
      End
      Begin PaneConfiguration = 10
         NumPanes = 2
         Configuration = "(H (1[66] 2) )"
      End
      Begin PaneConfiguration = 11
         NumPanes = 2
         Configuration = "(H (4 [60] 2))"
      End
      Begin PaneConfiguration = 12
         NumPanes = 1
         Configuration = "(H (1) )"
      End
      Begin PaneConfiguration = 13
         NumPanes = 1
         Configuration = "(V (4))"
      End
      Begin PaneConfiguration = 14
         NumPanes = 1
         Configuration = "(V (2))"
      End
      ActivePaneConfig = 0
   End
   Begin DiagramPane = 
      Begin Origin = 
         Top = 0
         Left = 0
      End
      Begin Tables = 
         Begin Table = "common_dictionary"
            Begin Extent = 
               Top = 6
               Left = 38
               Bottom = 123
               Right = 220
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "vw_type_uniqueness"
            Begin Extent = 
               Top = 6
               Left = 258
               Bottom = 93
               Right = 440
            End
            DisplayFlags = 280
            TopColumn = 0
         End
      End
   End
   Begin SQLPane = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 12
         Column = 1440
         Alias = 900
         Table = 1170
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1350
         SortOrder = 1410
         GroupBy = 1350
         Filter = 1350
         Or = 1350
         Or = 1350
         Or = 1350
      End
   End
End
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'vw_set_postal_code'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'vw_set_postal_code'
GO

/****** Object:  View [dbo].[vw_set_primary_taxonomy_switch]    Script Date: 03/18/2012 14:23:46 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

/*create view vw_set_state_name
as
SELECT     common_dictionary.type_value, SUM(common_dictionary.cardinality) as cardinality
FROM         common_dictionary 
INNER JOIN
vw_type_uniqueness 
ON common_dictionary.type_name = vw_type_uniqueness.type_name
where common_dictionary.type_name like '%state name%'
group by common_dictionary.type_value
create view vw_set_taxonomy
as
SELECT     common_dictionary.type_value, SUM(common_dictionary.cardinality) as cardinality
FROM         common_dictionary 
INNER JOIN
vw_type_uniqueness 
ON common_dictionary.type_name = vw_type_uniqueness.type_name
where common_dictionary.type_name like '%taxonomy code%'
group by common_dictionary.type_value
create view vw_set_country_code
as
SELECT     common_dictionary.type_value, SUM(common_dictionary.cardinality) as cardinality
FROM         common_dictionary 
INNER JOIN
vw_type_uniqueness 
ON common_dictionary.type_name = vw_type_uniqueness.type_name
where common_dictionary.type_name like '%country code%'
group by common_dictionary.type_value
create view vw_set_entity_type_code
as
SELECT     common_dictionary.type_value, SUM(common_dictionary.cardinality) as cardinality
FROM         common_dictionary 
INNER JOIN
vw_type_uniqueness 
ON common_dictionary.type_name = vw_type_uniqueness.type_name
where common_dictionary.type_name like '%entity type code%'
group by common_dictionary.type_value
create view vw_set_provider_gender_code
as
SELECT     common_dictionary.type_value, SUM(common_dictionary.cardinality) as cardinality
FROM         common_dictionary 
INNER JOIN
vw_type_uniqueness 
ON common_dictionary.type_name = vw_type_uniqueness.type_name
where common_dictionary.type_name = 'provider gender code'
group by common_dictionary.type_value
create view vw_set_last_update_year_month
as
SELECT     (cast(common_dictionary.as_year as varchar(5)) + '-'
 + cast(common_dictionary.as_month as varchar(3)) ) as [type_value], 
 SUM(common_dictionary.cardinality) as cardinality
FROM         common_dictionary 
INNER JOIN
vw_type_uniqueness 
ON common_dictionary.type_name = vw_type_uniqueness.type_name
where common_dictionary.type_name = 'LAST UPDATE DATE'
group by common_dictionary.as_year, common_dictionary.as_month
create view vw_set_is_sole_proprietor
as
SELECT     common_dictionary.type_value, SUM(common_dictionary.cardinality) as cardinality
FROM         common_dictionary 
INNER JOIN
vw_type_uniqueness 
ON common_dictionary.type_name = vw_type_uniqueness.type_name
where common_dictionary.type_name = 'is sole proprietor'
group by common_dictionary.type_value
create view vw_set_provider_credential_text
as
SELECT     common_dictionary.type_value, SUM(common_dictionary.cardinality) as cardinality
FROM         common_dictionary 
INNER JOIN
vw_type_uniqueness 
ON common_dictionary.type_name = vw_type_uniqueness.type_name
where common_dictionary.type_name = 'PROVIDER CREDENTIAL TEXT'
group by common_dictionary.type_value
create view vw_set_provider_taxonomy_group
as
SELECT     common_dictionary.type_value, SUM(common_dictionary.cardinality) as cardinality
FROM         common_dictionary 
INNER JOIN
vw_type_uniqueness 
ON common_dictionary.type_name = vw_type_uniqueness.type_name
where common_dictionary.type_name like '%PROVIDER TAXONOMY GROUP%'
group by common_dictionary.type_value*/
CREATE VIEW [dbo].[vw_set_primary_taxonomy_switch]
AS
SELECT     dbo.common_dictionary.database_name, dbo.common_dictionary.table_name, dbo.common_dictionary.dictionary_id, dbo.common_dictionary.type_value, 
                      SUM(dbo.common_dictionary.cardinality) AS cardinality
FROM         dbo.common_dictionary INNER JOIN
                      dbo.vw_type_uniqueness ON dbo.common_dictionary.type_name = dbo.vw_type_uniqueness.type_name
WHERE     (dbo.common_dictionary.type_name LIKE '%primary taxonomy switch%')
GROUP BY dbo.common_dictionary.type_value, dbo.common_dictionary.database_name, dbo.common_dictionary.table_name, dbo.common_dictionary.dictionary_id

GO

EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[40] 4[20] 2[20] 3) )"
      End
      Begin PaneConfiguration = 1
         NumPanes = 3
         Configuration = "(H (1 [50] 4 [25] 3))"
      End
      Begin PaneConfiguration = 2
         NumPanes = 3
         Configuration = "(H (1 [50] 2 [25] 3))"
      End
      Begin PaneConfiguration = 3
         NumPanes = 3
         Configuration = "(H (4 [30] 2 [40] 3))"
      End
      Begin PaneConfiguration = 4
         NumPanes = 2
         Configuration = "(H (1 [56] 3))"
      End
      Begin PaneConfiguration = 5
         NumPanes = 2
         Configuration = "(H (2 [66] 3))"
      End
      Begin PaneConfiguration = 6
         NumPanes = 2
         Configuration = "(H (4 [50] 3))"
      End
      Begin PaneConfiguration = 7
         NumPanes = 1
         Configuration = "(V (3))"
      End
      Begin PaneConfiguration = 8
         NumPanes = 3
         Configuration = "(H (1[56] 4[18] 2) )"
      End
      Begin PaneConfiguration = 9
         NumPanes = 2
         Configuration = "(H (1 [75] 4))"
      End
      Begin PaneConfiguration = 10
         NumPanes = 2
         Configuration = "(H (1[66] 2) )"
      End
      Begin PaneConfiguration = 11
         NumPanes = 2
         Configuration = "(H (4 [60] 2))"
      End
      Begin PaneConfiguration = 12
         NumPanes = 1
         Configuration = "(H (1) )"
      End
      Begin PaneConfiguration = 13
         NumPanes = 1
         Configuration = "(V (4))"
      End
      Begin PaneConfiguration = 14
         NumPanes = 1
         Configuration = "(V (2))"
      End
      ActivePaneConfig = 0
   End
   Begin DiagramPane = 
      Begin Origin = 
         Top = 0
         Left = 0
      End
      Begin Tables = 
         Begin Table = "common_dictionary"
            Begin Extent = 
               Top = 6
               Left = 38
               Bottom = 123
               Right = 220
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "vw_type_uniqueness"
            Begin Extent = 
               Top = 6
               Left = 258
               Bottom = 93
               Right = 440
            End
            DisplayFlags = 280
            TopColumn = 0
         End
      End
   End
   Begin SQLPane = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 12
         Column = 1440
         Alias = 900
         Table = 1170
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1350
         SortOrder = 1410
         GroupBy = 1350
         Filter = 1350
         Or = 1350
         Or = 1350
         Or = 1350
      End
   End
End
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'vw_set_primary_taxonomy_switch'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'vw_set_primary_taxonomy_switch'
GO

/****** Object:  View [dbo].[vw_set_provider_credential_text]    Script Date: 03/18/2012 14:23:46 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

/*create view vw_set_state_name
as
SELECT     common_dictionary.type_value, SUM(common_dictionary.cardinality) as cardinality
FROM         common_dictionary 
INNER JOIN
vw_type_uniqueness 
ON common_dictionary.type_name = vw_type_uniqueness.type_name
where common_dictionary.type_name like '%state name%'
group by common_dictionary.type_value
create view vw_set_taxonomy
as
SELECT     common_dictionary.type_value, SUM(common_dictionary.cardinality) as cardinality
FROM         common_dictionary 
INNER JOIN
vw_type_uniqueness 
ON common_dictionary.type_name = vw_type_uniqueness.type_name
where common_dictionary.type_name like '%taxonomy code%'
group by common_dictionary.type_value
create view vw_set_country_code
as
SELECT     common_dictionary.type_value, SUM(common_dictionary.cardinality) as cardinality
FROM         common_dictionary 
INNER JOIN
vw_type_uniqueness 
ON common_dictionary.type_name = vw_type_uniqueness.type_name
where common_dictionary.type_name like '%country code%'
group by common_dictionary.type_value
create view vw_set_entity_type_code
as
SELECT     common_dictionary.type_value, SUM(common_dictionary.cardinality) as cardinality
FROM         common_dictionary 
INNER JOIN
vw_type_uniqueness 
ON common_dictionary.type_name = vw_type_uniqueness.type_name
where common_dictionary.type_name like '%entity type code%'
group by common_dictionary.type_value
create view vw_set_provider_gender_code
as
SELECT     common_dictionary.type_value, SUM(common_dictionary.cardinality) as cardinality
FROM         common_dictionary 
INNER JOIN
vw_type_uniqueness 
ON common_dictionary.type_name = vw_type_uniqueness.type_name
where common_dictionary.type_name = 'provider gender code'
group by common_dictionary.type_value
create view vw_set_last_update_year_month
as
SELECT     (cast(common_dictionary.as_year as varchar(5)) + '-'
 + cast(common_dictionary.as_month as varchar(3)) ) as [type_value], 
 SUM(common_dictionary.cardinality) as cardinality
FROM         common_dictionary 
INNER JOIN
vw_type_uniqueness 
ON common_dictionary.type_name = vw_type_uniqueness.type_name
where common_dictionary.type_name = 'LAST UPDATE DATE'
group by common_dictionary.as_year, common_dictionary.as_month
create view vw_set_is_sole_proprietor
as
SELECT     common_dictionary.type_value, SUM(common_dictionary.cardinality) as cardinality
FROM         common_dictionary 
INNER JOIN
vw_type_uniqueness 
ON common_dictionary.type_name = vw_type_uniqueness.type_name
where common_dictionary.type_name = 'is sole proprietor'
group by common_dictionary.type_value*/
CREATE VIEW [dbo].[vw_set_provider_credential_text]
AS
SELECT     dbo.common_dictionary.database_name, dbo.common_dictionary.table_name, dbo.common_dictionary.dictionary_id, dbo.common_dictionary.type_value, 
                      SUM(dbo.common_dictionary.cardinality) AS cardinality
FROM         dbo.common_dictionary INNER JOIN
                      dbo.vw_type_uniqueness ON dbo.common_dictionary.type_name = dbo.vw_type_uniqueness.type_name
WHERE     (dbo.common_dictionary.type_name LIKE '%CREDENTIAL TEXT%')
GROUP BY dbo.common_dictionary.type_value, dbo.common_dictionary.database_name, dbo.common_dictionary.table_name, dbo.common_dictionary.dictionary_id

GO

EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[40] 4[20] 2[20] 3) )"
      End
      Begin PaneConfiguration = 1
         NumPanes = 3
         Configuration = "(H (1 [50] 4 [25] 3))"
      End
      Begin PaneConfiguration = 2
         NumPanes = 3
         Configuration = "(H (1 [50] 2 [25] 3))"
      End
      Begin PaneConfiguration = 3
         NumPanes = 3
         Configuration = "(H (4 [30] 2 [40] 3))"
      End
      Begin PaneConfiguration = 4
         NumPanes = 2
         Configuration = "(H (1 [56] 3))"
      End
      Begin PaneConfiguration = 5
         NumPanes = 2
         Configuration = "(H (2 [66] 3))"
      End
      Begin PaneConfiguration = 6
         NumPanes = 2
         Configuration = "(H (4 [50] 3))"
      End
      Begin PaneConfiguration = 7
         NumPanes = 1
         Configuration = "(V (3))"
      End
      Begin PaneConfiguration = 8
         NumPanes = 3
         Configuration = "(H (1[56] 4[18] 2) )"
      End
      Begin PaneConfiguration = 9
         NumPanes = 2
         Configuration = "(H (1 [75] 4))"
      End
      Begin PaneConfiguration = 10
         NumPanes = 2
         Configuration = "(H (1[66] 2) )"
      End
      Begin PaneConfiguration = 11
         NumPanes = 2
         Configuration = "(H (4 [60] 2))"
      End
      Begin PaneConfiguration = 12
         NumPanes = 1
         Configuration = "(H (1) )"
      End
      Begin PaneConfiguration = 13
         NumPanes = 1
         Configuration = "(V (4))"
      End
      Begin PaneConfiguration = 14
         NumPanes = 1
         Configuration = "(V (2))"
      End
      ActivePaneConfig = 0
   End
   Begin DiagramPane = 
      Begin Origin = 
         Top = 0
         Left = 0
      End
      Begin Tables = 
         Begin Table = "common_dictionary"
            Begin Extent = 
               Top = 6
               Left = 38
               Bottom = 123
               Right = 220
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "vw_type_uniqueness"
            Begin Extent = 
               Top = 6
               Left = 258
               Bottom = 93
               Right = 440
            End
            DisplayFlags = 280
            TopColumn = 0
         End
      End
   End
   Begin SQLPane = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 12
         Column = 1440
         Alias = 900
         Table = 1170
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1350
         SortOrder = 1410
         GroupBy = 1350
         Filter = 1350
         Or = 1350
         Or = 1350
         Or = 1350
      End
   End
End
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'vw_set_provider_credential_text'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'vw_set_provider_credential_text'
GO

/****** Object:  View [dbo].[vw_set_provider_enumeration_year_month]    Script Date: 03/18/2012 14:23:46 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE VIEW [dbo].[vw_set_provider_enumeration_year_month]
AS
SELECT     dbo.common_dictionary.database_name, dbo.common_dictionary.table_name, dbo.common_dictionary.dictionary_id, 
                      CAST(dbo.common_dictionary.as_year AS varchar(5)) + '-' + CAST(dbo.common_dictionary.as_month AS varchar(3)) AS type_value, 
                      SUM(dbo.common_dictionary.cardinality) AS cardinality
FROM         dbo.common_dictionary INNER JOIN
                      dbo.vw_type_uniqueness ON dbo.common_dictionary.type_name = dbo.vw_type_uniqueness.type_name
WHERE     (dbo.common_dictionary.type_name = 'PROVIDER ENUMERATION DATE')
GROUP BY dbo.common_dictionary.as_year, dbo.common_dictionary.as_month, dbo.common_dictionary.database_name, dbo.common_dictionary.table_name, 
                      dbo.common_dictionary.dictionary_id

GO

EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[40] 4[20] 2[20] 3) )"
      End
      Begin PaneConfiguration = 1
         NumPanes = 3
         Configuration = "(H (1 [50] 4 [25] 3))"
      End
      Begin PaneConfiguration = 2
         NumPanes = 3
         Configuration = "(H (1 [50] 2 [25] 3))"
      End
      Begin PaneConfiguration = 3
         NumPanes = 3
         Configuration = "(H (4 [30] 2 [40] 3))"
      End
      Begin PaneConfiguration = 4
         NumPanes = 2
         Configuration = "(H (1 [56] 3))"
      End
      Begin PaneConfiguration = 5
         NumPanes = 2
         Configuration = "(H (2 [66] 3))"
      End
      Begin PaneConfiguration = 6
         NumPanes = 2
         Configuration = "(H (4 [50] 3))"
      End
      Begin PaneConfiguration = 7
         NumPanes = 1
         Configuration = "(V (3))"
      End
      Begin PaneConfiguration = 8
         NumPanes = 3
         Configuration = "(H (1[56] 4[18] 2) )"
      End
      Begin PaneConfiguration = 9
         NumPanes = 2
         Configuration = "(H (1 [75] 4))"
      End
      Begin PaneConfiguration = 10
         NumPanes = 2
         Configuration = "(H (1[66] 2) )"
      End
      Begin PaneConfiguration = 11
         NumPanes = 2
         Configuration = "(H (4 [60] 2))"
      End
      Begin PaneConfiguration = 12
         NumPanes = 1
         Configuration = "(H (1) )"
      End
      Begin PaneConfiguration = 13
         NumPanes = 1
         Configuration = "(V (4))"
      End
      Begin PaneConfiguration = 14
         NumPanes = 1
         Configuration = "(V (2))"
      End
      ActivePaneConfig = 0
   End
   Begin DiagramPane = 
      Begin Origin = 
         Top = 0
         Left = 0
      End
      Begin Tables = 
         Begin Table = "common_dictionary"
            Begin Extent = 
               Top = 6
               Left = 38
               Bottom = 123
               Right = 220
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "vw_type_uniqueness"
            Begin Extent = 
               Top = 6
               Left = 258
               Bottom = 93
               Right = 440
            End
            DisplayFlags = 280
            TopColumn = 0
         End
      End
   End
   Begin SQLPane = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 12
         Column = 1440
         Alias = 900
         Table = 1170
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1350
         SortOrder = 1410
         GroupBy = 1350
         Filter = 1350
         Or = 1350
         Or = 1350
         Or = 1350
      End
   End
End
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'vw_set_provider_enumeration_year_month'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'vw_set_provider_enumeration_year_month'
GO

/****** Object:  View [dbo].[vw_set_provider_gender_code]    Script Date: 03/18/2012 14:23:46 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

/*create view vw_set_state_name
as
SELECT     common_dictionary.type_value, SUM(common_dictionary.cardinality) as cardinality
FROM         common_dictionary 
INNER JOIN
vw_type_uniqueness 
ON common_dictionary.type_name = vw_type_uniqueness.type_name
where common_dictionary.type_name like '%state name%'
group by common_dictionary.type_value
create view vw_set_taxonomy
as
SELECT     common_dictionary.type_value, SUM(common_dictionary.cardinality) as cardinality
FROM         common_dictionary 
INNER JOIN
vw_type_uniqueness 
ON common_dictionary.type_name = vw_type_uniqueness.type_name
where common_dictionary.type_name like '%taxonomy code%'
group by common_dictionary.type_value
create view vw_set_country_code
as
SELECT     common_dictionary.type_value, SUM(common_dictionary.cardinality) as cardinality
FROM         common_dictionary 
INNER JOIN
vw_type_uniqueness 
ON common_dictionary.type_name = vw_type_uniqueness.type_name
where common_dictionary.type_name like '%country code%'
group by common_dictionary.type_value
create view vw_set_entity_type_code
as
SELECT     common_dictionary.type_value, SUM(common_dictionary.cardinality) as cardinality
FROM         common_dictionary 
INNER JOIN
vw_type_uniqueness 
ON common_dictionary.type_name = vw_type_uniqueness.type_name
where common_dictionary.type_name like '%entity type code%'
group by common_dictionary.type_value*/
CREATE VIEW [dbo].[vw_set_provider_gender_code]
AS
SELECT     dbo.common_dictionary.database_name, dbo.common_dictionary.table_name, dbo.common_dictionary.dictionary_id, dbo.common_dictionary.type_value, 
                      SUM(dbo.common_dictionary.cardinality) AS cardinality
FROM         dbo.common_dictionary INNER JOIN
                      dbo.vw_type_uniqueness ON dbo.common_dictionary.type_name = dbo.vw_type_uniqueness.type_name
WHERE     (dbo.common_dictionary.type_name = 'provider gender code')
GROUP BY dbo.common_dictionary.type_value, dbo.common_dictionary.database_name, dbo.common_dictionary.table_name, dbo.common_dictionary.dictionary_id

GO

EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[40] 4[20] 2[20] 3) )"
      End
      Begin PaneConfiguration = 1
         NumPanes = 3
         Configuration = "(H (1 [50] 4 [25] 3))"
      End
      Begin PaneConfiguration = 2
         NumPanes = 3
         Configuration = "(H (1 [50] 2 [25] 3))"
      End
      Begin PaneConfiguration = 3
         NumPanes = 3
         Configuration = "(H (4 [30] 2 [40] 3))"
      End
      Begin PaneConfiguration = 4
         NumPanes = 2
         Configuration = "(H (1 [56] 3))"
      End
      Begin PaneConfiguration = 5
         NumPanes = 2
         Configuration = "(H (2 [66] 3))"
      End
      Begin PaneConfiguration = 6
         NumPanes = 2
         Configuration = "(H (4 [50] 3))"
      End
      Begin PaneConfiguration = 7
         NumPanes = 1
         Configuration = "(V (3))"
      End
      Begin PaneConfiguration = 8
         NumPanes = 3
         Configuration = "(H (1[56] 4[18] 2) )"
      End
      Begin PaneConfiguration = 9
         NumPanes = 2
         Configuration = "(H (1 [75] 4))"
      End
      Begin PaneConfiguration = 10
         NumPanes = 2
         Configuration = "(H (1[66] 2) )"
      End
      Begin PaneConfiguration = 11
         NumPanes = 2
         Configuration = "(H (4 [60] 2))"
      End
      Begin PaneConfiguration = 12
         NumPanes = 1
         Configuration = "(H (1) )"
      End
      Begin PaneConfiguration = 13
         NumPanes = 1
         Configuration = "(V (4))"
      End
      Begin PaneConfiguration = 14
         NumPanes = 1
         Configuration = "(V (2))"
      End
      ActivePaneConfig = 0
   End
   Begin DiagramPane = 
      Begin Origin = 
         Top = 0
         Left = 0
      End
      Begin Tables = 
         Begin Table = "common_dictionary"
            Begin Extent = 
               Top = 6
               Left = 38
               Bottom = 123
               Right = 220
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "vw_type_uniqueness"
            Begin Extent = 
               Top = 6
               Left = 258
               Bottom = 93
               Right = 440
            End
            DisplayFlags = 280
            TopColumn = 0
         End
      End
   End
   Begin SQLPane = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 12
         Column = 1440
         Alias = 900
         Table = 1170
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1350
         SortOrder = 1410
         GroupBy = 1350
         Filter = 1350
         Or = 1350
         Or = 1350
         Or = 1350
      End
   End
End
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'vw_set_provider_gender_code'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'vw_set_provider_gender_code'
GO

/****** Object:  View [dbo].[vw_set_provider_license_state_code]    Script Date: 03/18/2012 14:23:46 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

/*create view vw_set_state_name
as
SELECT     common_dictionary.type_value, SUM(common_dictionary.cardinality) as cardinality
FROM         common_dictionary 
INNER JOIN
vw_type_uniqueness 
ON common_dictionary.type_name = vw_type_uniqueness.type_name
where common_dictionary.type_name like '%state name%'
group by common_dictionary.type_value
create view vw_set_taxonomy
as
SELECT     common_dictionary.type_value, SUM(common_dictionary.cardinality) as cardinality
FROM         common_dictionary 
INNER JOIN
vw_type_uniqueness 
ON common_dictionary.type_name = vw_type_uniqueness.type_name
where common_dictionary.type_name like '%taxonomy code%'
group by common_dictionary.type_value
create view vw_set_country_code
as
SELECT     common_dictionary.type_value, SUM(common_dictionary.cardinality) as cardinality
FROM         common_dictionary 
INNER JOIN
vw_type_uniqueness 
ON common_dictionary.type_name = vw_type_uniqueness.type_name
where common_dictionary.type_name like '%country code%'
group by common_dictionary.type_value
create view vw_set_entity_type_code
as
SELECT     common_dictionary.type_value, SUM(common_dictionary.cardinality) as cardinality
FROM         common_dictionary 
INNER JOIN
vw_type_uniqueness 
ON common_dictionary.type_name = vw_type_uniqueness.type_name
where common_dictionary.type_name like '%entity type code%'
group by common_dictionary.type_value
create view vw_set_provider_gender_code
as
SELECT     common_dictionary.type_value, SUM(common_dictionary.cardinality) as cardinality
FROM         common_dictionary 
INNER JOIN
vw_type_uniqueness 
ON common_dictionary.type_name = vw_type_uniqueness.type_name
where common_dictionary.type_name = 'provider gender code'
group by common_dictionary.type_value
create view vw_set_last_update_year_month
as
SELECT     (cast(common_dictionary.as_year as varchar(5)) + '-'
 + cast(common_dictionary.as_month as varchar(3)) ) as [type_value], 
 SUM(common_dictionary.cardinality) as cardinality
FROM         common_dictionary 
INNER JOIN
vw_type_uniqueness 
ON common_dictionary.type_name = vw_type_uniqueness.type_name
where common_dictionary.type_name = 'LAST UPDATE DATE'
group by common_dictionary.as_year, common_dictionary.as_month
create view vw_set_is_sole_proprietor
as
SELECT     common_dictionary.type_value, SUM(common_dictionary.cardinality) as cardinality
FROM         common_dictionary 
INNER JOIN
vw_type_uniqueness 
ON common_dictionary.type_name = vw_type_uniqueness.type_name
where common_dictionary.type_name = 'is sole proprietor'
group by common_dictionary.type_value
create view vw_set_provider_credential_text
as
SELECT     common_dictionary.type_value, SUM(common_dictionary.cardinality) as cardinality
FROM         common_dictionary 
INNER JOIN
vw_type_uniqueness 
ON common_dictionary.type_name = vw_type_uniqueness.type_name
where common_dictionary.type_name = 'PROVIDER CREDENTIAL TEXT'
group by common_dictionary.type_value
create view vw_set_provider_taxonomy_group
as
SELECT     common_dictionary.type_value, SUM(common_dictionary.cardinality) as cardinality
FROM         common_dictionary 
INNER JOIN
vw_type_uniqueness 
ON common_dictionary.type_name = vw_type_uniqueness.type_name
where common_dictionary.type_name like '%PROVIDER TAXONOMY GROUP%'
group by common_dictionary.type_value
create view vw_set_primary_taxonomy_switch
as
SELECT     common_dictionary.type_value, SUM(common_dictionary.cardinality) as cardinality
FROM         common_dictionary 
INNER JOIN
vw_type_uniqueness 
ON common_dictionary.type_name = vw_type_uniqueness.type_name
where common_dictionary.type_name like '%primary taxonomy switch%'
group by common_dictionary.type_value
create view vw_set_provider_name_prefix
as
SELECT     common_dictionary.type_value, SUM(common_dictionary.cardinality) as cardinality
FROM         common_dictionary 
INNER JOIN
vw_type_uniqueness 
ON common_dictionary.type_name = vw_type_uniqueness.type_name
where common_dictionary.type_name like '%provider name prefix%'
group by common_dictionary.type_value
create view vw_set_official_title
as
SELECT     common_dictionary.type_value, SUM(common_dictionary.cardinality) as cardinality
FROM         common_dictionary 
INNER JOIN
vw_type_uniqueness 
ON common_dictionary.type_name = vw_type_uniqueness.type_name
where common_dictionary.type_name = 'AUTHORIZED OFFICIAL TITLE OR POSITION'
group by common_dictionary.type_value*/
CREATE VIEW [dbo].[vw_set_provider_license_state_code]
AS
SELECT     dbo.common_dictionary.database_name, dbo.common_dictionary.table_name, dbo.common_dictionary.dictionary_id, dbo.common_dictionary.type_value, 
                      SUM(dbo.common_dictionary.cardinality) AS cardinality
FROM         dbo.common_dictionary INNER JOIN
                      dbo.vw_type_uniqueness ON dbo.common_dictionary.type_name = dbo.vw_type_uniqueness.type_name
WHERE     (dbo.common_dictionary.type_name LIKE '%PROVIDER LICENSE NUMBER STATE CODE%')
GROUP BY dbo.common_dictionary.type_value, dbo.common_dictionary.database_name, dbo.common_dictionary.table_name, dbo.common_dictionary.dictionary_id

GO

EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[40] 4[20] 2[20] 3) )"
      End
      Begin PaneConfiguration = 1
         NumPanes = 3
         Configuration = "(H (1 [50] 4 [25] 3))"
      End
      Begin PaneConfiguration = 2
         NumPanes = 3
         Configuration = "(H (1 [50] 2 [25] 3))"
      End
      Begin PaneConfiguration = 3
         NumPanes = 3
         Configuration = "(H (4 [30] 2 [40] 3))"
      End
      Begin PaneConfiguration = 4
         NumPanes = 2
         Configuration = "(H (1 [56] 3))"
      End
      Begin PaneConfiguration = 5
         NumPanes = 2
         Configuration = "(H (2 [66] 3))"
      End
      Begin PaneConfiguration = 6
         NumPanes = 2
         Configuration = "(H (4 [50] 3))"
      End
      Begin PaneConfiguration = 7
         NumPanes = 1
         Configuration = "(V (3))"
      End
      Begin PaneConfiguration = 8
         NumPanes = 3
         Configuration = "(H (1[56] 4[18] 2) )"
      End
      Begin PaneConfiguration = 9
         NumPanes = 2
         Configuration = "(H (1 [75] 4))"
      End
      Begin PaneConfiguration = 10
         NumPanes = 2
         Configuration = "(H (1[66] 2) )"
      End
      Begin PaneConfiguration = 11
         NumPanes = 2
         Configuration = "(H (4 [60] 2))"
      End
      Begin PaneConfiguration = 12
         NumPanes = 1
         Configuration = "(H (1) )"
      End
      Begin PaneConfiguration = 13
         NumPanes = 1
         Configuration = "(V (4))"
      End
      Begin PaneConfiguration = 14
         NumPanes = 1
         Configuration = "(V (2))"
      End
      ActivePaneConfig = 0
   End
   Begin DiagramPane = 
      Begin Origin = 
         Top = 0
         Left = 0
      End
      Begin Tables = 
         Begin Table = "common_dictionary"
            Begin Extent = 
               Top = 6
               Left = 38
               Bottom = 123
               Right = 220
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "vw_type_uniqueness"
            Begin Extent = 
               Top = 6
               Left = 258
               Bottom = 93
               Right = 440
            End
            DisplayFlags = 280
            TopColumn = 0
         End
      End
   End
   Begin SQLPane = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 12
         Column = 1440
         Alias = 900
         Table = 1170
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1350
         SortOrder = 1410
         GroupBy = 1350
         Filter = 1350
         Or = 1350
         Or = 1350
         Or = 1350
      End
   End
End
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'vw_set_provider_license_state_code'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'vw_set_provider_license_state_code'
GO

/****** Object:  View [dbo].[vw_set_provider_name_prefix]    Script Date: 03/18/2012 14:23:46 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

/*create view vw_set_state_name
as
SELECT     common_dictionary.type_value, SUM(common_dictionary.cardinality) as cardinality
FROM         common_dictionary 
INNER JOIN
vw_type_uniqueness 
ON common_dictionary.type_name = vw_type_uniqueness.type_name
where common_dictionary.type_name like '%state name%'
group by common_dictionary.type_value
create view vw_set_taxonomy
as
SELECT     common_dictionary.type_value, SUM(common_dictionary.cardinality) as cardinality
FROM         common_dictionary 
INNER JOIN
vw_type_uniqueness 
ON common_dictionary.type_name = vw_type_uniqueness.type_name
where common_dictionary.type_name like '%taxonomy code%'
group by common_dictionary.type_value
create view vw_set_country_code
as
SELECT     common_dictionary.type_value, SUM(common_dictionary.cardinality) as cardinality
FROM         common_dictionary 
INNER JOIN
vw_type_uniqueness 
ON common_dictionary.type_name = vw_type_uniqueness.type_name
where common_dictionary.type_name like '%country code%'
group by common_dictionary.type_value
create view vw_set_entity_type_code
as
SELECT     common_dictionary.type_value, SUM(common_dictionary.cardinality) as cardinality
FROM         common_dictionary 
INNER JOIN
vw_type_uniqueness 
ON common_dictionary.type_name = vw_type_uniqueness.type_name
where common_dictionary.type_name like '%entity type code%'
group by common_dictionary.type_value
create view vw_set_provider_gender_code
as
SELECT     common_dictionary.type_value, SUM(common_dictionary.cardinality) as cardinality
FROM         common_dictionary 
INNER JOIN
vw_type_uniqueness 
ON common_dictionary.type_name = vw_type_uniqueness.type_name
where common_dictionary.type_name = 'provider gender code'
group by common_dictionary.type_value
create view vw_set_last_update_year_month
as
SELECT     (cast(common_dictionary.as_year as varchar(5)) + '-'
 + cast(common_dictionary.as_month as varchar(3)) ) as [type_value], 
 SUM(common_dictionary.cardinality) as cardinality
FROM         common_dictionary 
INNER JOIN
vw_type_uniqueness 
ON common_dictionary.type_name = vw_type_uniqueness.type_name
where common_dictionary.type_name = 'LAST UPDATE DATE'
group by common_dictionary.as_year, common_dictionary.as_month
create view vw_set_is_sole_proprietor
as
SELECT     common_dictionary.type_value, SUM(common_dictionary.cardinality) as cardinality
FROM         common_dictionary 
INNER JOIN
vw_type_uniqueness 
ON common_dictionary.type_name = vw_type_uniqueness.type_name
where common_dictionary.type_name = 'is sole proprietor'
group by common_dictionary.type_value
create view vw_set_provider_credential_text
as
SELECT     common_dictionary.type_value, SUM(common_dictionary.cardinality) as cardinality
FROM         common_dictionary 
INNER JOIN
vw_type_uniqueness 
ON common_dictionary.type_name = vw_type_uniqueness.type_name
where common_dictionary.type_name = 'PROVIDER CREDENTIAL TEXT'
group by common_dictionary.type_value
create view vw_set_provider_taxonomy_group
as
SELECT     common_dictionary.type_value, SUM(common_dictionary.cardinality) as cardinality
FROM         common_dictionary 
INNER JOIN
vw_type_uniqueness 
ON common_dictionary.type_name = vw_type_uniqueness.type_name
where common_dictionary.type_name like '%PROVIDER TAXONOMY GROUP%'
group by common_dictionary.type_value
create view vw_set_primary_taxonomy_switch
as
SELECT     common_dictionary.type_value, SUM(common_dictionary.cardinality) as cardinality
FROM         common_dictionary 
INNER JOIN
vw_type_uniqueness 
ON common_dictionary.type_name = vw_type_uniqueness.type_name
where common_dictionary.type_name like '%primary taxonomy switch%'
group by common_dictionary.type_value*/
CREATE VIEW [dbo].[vw_set_provider_name_prefix]
AS
SELECT     dbo.common_dictionary.database_name, dbo.common_dictionary.table_name, dbo.common_dictionary.dictionary_id, dbo.common_dictionary.type_value, 
                      SUM(dbo.common_dictionary.cardinality) AS cardinality
FROM         dbo.common_dictionary INNER JOIN
                      dbo.vw_type_uniqueness ON dbo.common_dictionary.type_name = dbo.vw_type_uniqueness.type_name
WHERE     (dbo.common_dictionary.type_name LIKE '%name prefix%')
GROUP BY dbo.common_dictionary.type_value, dbo.common_dictionary.database_name, dbo.common_dictionary.table_name, dbo.common_dictionary.dictionary_id

GO

EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[40] 4[20] 2[20] 3) )"
      End
      Begin PaneConfiguration = 1
         NumPanes = 3
         Configuration = "(H (1 [50] 4 [25] 3))"
      End
      Begin PaneConfiguration = 2
         NumPanes = 3
         Configuration = "(H (1 [50] 2 [25] 3))"
      End
      Begin PaneConfiguration = 3
         NumPanes = 3
         Configuration = "(H (4 [30] 2 [40] 3))"
      End
      Begin PaneConfiguration = 4
         NumPanes = 2
         Configuration = "(H (1 [56] 3))"
      End
      Begin PaneConfiguration = 5
         NumPanes = 2
         Configuration = "(H (2 [66] 3))"
      End
      Begin PaneConfiguration = 6
         NumPanes = 2
         Configuration = "(H (4 [50] 3))"
      End
      Begin PaneConfiguration = 7
         NumPanes = 1
         Configuration = "(V (3))"
      End
      Begin PaneConfiguration = 8
         NumPanes = 3
         Configuration = "(H (1[56] 4[18] 2) )"
      End
      Begin PaneConfiguration = 9
         NumPanes = 2
         Configuration = "(H (1 [75] 4))"
      End
      Begin PaneConfiguration = 10
         NumPanes = 2
         Configuration = "(H (1[66] 2) )"
      End
      Begin PaneConfiguration = 11
         NumPanes = 2
         Configuration = "(H (4 [60] 2))"
      End
      Begin PaneConfiguration = 12
         NumPanes = 1
         Configuration = "(H (1) )"
      End
      Begin PaneConfiguration = 13
         NumPanes = 1
         Configuration = "(V (4))"
      End
      Begin PaneConfiguration = 14
         NumPanes = 1
         Configuration = "(V (2))"
      End
      ActivePaneConfig = 0
   End
   Begin DiagramPane = 
      Begin Origin = 
         Top = 0
         Left = 0
      End
      Begin Tables = 
         Begin Table = "common_dictionary"
            Begin Extent = 
               Top = 6
               Left = 38
               Bottom = 123
               Right = 220
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "vw_type_uniqueness"
            Begin Extent = 
               Top = 6
               Left = 258
               Bottom = 93
               Right = 440
            End
            DisplayFlags = 280
            TopColumn = 0
         End
      End
   End
   Begin SQLPane = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 12
         Column = 1440
         Alias = 900
         Table = 1170
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1350
         SortOrder = 1410
         GroupBy = 1350
         Filter = 1350
         Or = 1350
         Or = 1350
         Or = 1350
      End
   End
End
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'vw_set_provider_name_prefix'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'vw_set_provider_name_prefix'
GO

/****** Object:  View [dbo].[vw_set_provider_taxonomy_group]    Script Date: 03/18/2012 14:23:46 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

/*create view vw_set_state_name
as
SELECT     common_dictionary.type_value, SUM(common_dictionary.cardinality) as cardinality
FROM         common_dictionary 
INNER JOIN
vw_type_uniqueness 
ON common_dictionary.type_name = vw_type_uniqueness.type_name
where common_dictionary.type_name like '%state name%'
group by common_dictionary.type_value
create view vw_set_taxonomy
as
SELECT     common_dictionary.type_value, SUM(common_dictionary.cardinality) as cardinality
FROM         common_dictionary 
INNER JOIN
vw_type_uniqueness 
ON common_dictionary.type_name = vw_type_uniqueness.type_name
where common_dictionary.type_name like '%taxonomy code%'
group by common_dictionary.type_value
create view vw_set_country_code
as
SELECT     common_dictionary.type_value, SUM(common_dictionary.cardinality) as cardinality
FROM         common_dictionary 
INNER JOIN
vw_type_uniqueness 
ON common_dictionary.type_name = vw_type_uniqueness.type_name
where common_dictionary.type_name like '%country code%'
group by common_dictionary.type_value
create view vw_set_entity_type_code
as
SELECT     common_dictionary.type_value, SUM(common_dictionary.cardinality) as cardinality
FROM         common_dictionary 
INNER JOIN
vw_type_uniqueness 
ON common_dictionary.type_name = vw_type_uniqueness.type_name
where common_dictionary.type_name like '%entity type code%'
group by common_dictionary.type_value
create view vw_set_provider_gender_code
as
SELECT     common_dictionary.type_value, SUM(common_dictionary.cardinality) as cardinality
FROM         common_dictionary 
INNER JOIN
vw_type_uniqueness 
ON common_dictionary.type_name = vw_type_uniqueness.type_name
where common_dictionary.type_name = 'provider gender code'
group by common_dictionary.type_value
create view vw_set_last_update_year_month
as
SELECT     (cast(common_dictionary.as_year as varchar(5)) + '-'
 + cast(common_dictionary.as_month as varchar(3)) ) as [type_value], 
 SUM(common_dictionary.cardinality) as cardinality
FROM         common_dictionary 
INNER JOIN
vw_type_uniqueness 
ON common_dictionary.type_name = vw_type_uniqueness.type_name
where common_dictionary.type_name = 'LAST UPDATE DATE'
group by common_dictionary.as_year, common_dictionary.as_month
create view vw_set_is_sole_proprietor
as
SELECT     common_dictionary.type_value, SUM(common_dictionary.cardinality) as cardinality
FROM         common_dictionary 
INNER JOIN
vw_type_uniqueness 
ON common_dictionary.type_name = vw_type_uniqueness.type_name
where common_dictionary.type_name = 'is sole proprietor'
group by common_dictionary.type_value
create view vw_set_provider_credential_text
as
SELECT     common_dictionary.type_value, SUM(common_dictionary.cardinality) as cardinality
FROM         common_dictionary 
INNER JOIN
vw_type_uniqueness 
ON common_dictionary.type_name = vw_type_uniqueness.type_name
where common_dictionary.type_name = 'PROVIDER CREDENTIAL TEXT'
group by common_dictionary.type_value*/
CREATE VIEW [dbo].[vw_set_provider_taxonomy_group]
AS
SELECT     dbo.common_dictionary.database_name, dbo.common_dictionary.table_name, dbo.common_dictionary.dictionary_id, dbo.common_dictionary.type_value, 
                      SUM(dbo.common_dictionary.cardinality) AS cardinality
FROM         dbo.common_dictionary INNER JOIN
                      dbo.vw_type_uniqueness ON dbo.common_dictionary.type_name = dbo.vw_type_uniqueness.type_name
WHERE     (dbo.common_dictionary.type_name LIKE '%PROVIDER TAXONOMY GROUP%')
GROUP BY dbo.common_dictionary.type_value, dbo.common_dictionary.database_name, dbo.common_dictionary.table_name, dbo.common_dictionary.dictionary_id

GO

EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[40] 4[20] 2[20] 3) )"
      End
      Begin PaneConfiguration = 1
         NumPanes = 3
         Configuration = "(H (1 [50] 4 [25] 3))"
      End
      Begin PaneConfiguration = 2
         NumPanes = 3
         Configuration = "(H (1 [50] 2 [25] 3))"
      End
      Begin PaneConfiguration = 3
         NumPanes = 3
         Configuration = "(H (4 [30] 2 [40] 3))"
      End
      Begin PaneConfiguration = 4
         NumPanes = 2
         Configuration = "(H (1 [56] 3))"
      End
      Begin PaneConfiguration = 5
         NumPanes = 2
         Configuration = "(H (2 [66] 3))"
      End
      Begin PaneConfiguration = 6
         NumPanes = 2
         Configuration = "(H (4 [50] 3))"
      End
      Begin PaneConfiguration = 7
         NumPanes = 1
         Configuration = "(V (3))"
      End
      Begin PaneConfiguration = 8
         NumPanes = 3
         Configuration = "(H (1[56] 4[18] 2) )"
      End
      Begin PaneConfiguration = 9
         NumPanes = 2
         Configuration = "(H (1 [75] 4))"
      End
      Begin PaneConfiguration = 10
         NumPanes = 2
         Configuration = "(H (1[66] 2) )"
      End
      Begin PaneConfiguration = 11
         NumPanes = 2
         Configuration = "(H (4 [60] 2))"
      End
      Begin PaneConfiguration = 12
         NumPanes = 1
         Configuration = "(H (1) )"
      End
      Begin PaneConfiguration = 13
         NumPanes = 1
         Configuration = "(V (4))"
      End
      Begin PaneConfiguration = 14
         NumPanes = 1
         Configuration = "(V (2))"
      End
      ActivePaneConfig = 0
   End
   Begin DiagramPane = 
      Begin Origin = 
         Top = 0
         Left = 0
      End
      Begin Tables = 
         Begin Table = "common_dictionary"
            Begin Extent = 
               Top = 6
               Left = 38
               Bottom = 123
               Right = 220
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "vw_type_uniqueness"
            Begin Extent = 
               Top = 6
               Left = 258
               Bottom = 93
               Right = 440
            End
            DisplayFlags = 280
            TopColumn = 0
         End
      End
   End
   Begin SQLPane = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 12
         Column = 1440
         Alias = 900
         Table = 1170
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1350
         SortOrder = 1410
         GroupBy = 1350
         Filter = 1350
         Or = 1350
         Or = 1350
         Or = 1350
      End
   End
End
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'vw_set_provider_taxonomy_group'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'vw_set_provider_taxonomy_group'
GO

/****** Object:  View [dbo].[vw_set_state_name]    Script Date: 03/18/2012 14:23:46 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE VIEW [dbo].[vw_set_state_name]
AS
SELECT     dbo.common_dictionary.database_name, dbo.common_dictionary.table_name, dbo.common_dictionary.dictionary_id, dbo.common_dictionary.type_value, 
                      SUM(dbo.common_dictionary.cardinality) AS cardinality
FROM         dbo.common_dictionary INNER JOIN
                      dbo.vw_type_uniqueness ON dbo.common_dictionary.type_name = dbo.vw_type_uniqueness.type_name
WHERE     (dbo.common_dictionary.type_name LIKE '%state name%')
GROUP BY dbo.common_dictionary.type_value, dbo.common_dictionary.database_name, dbo.common_dictionary.table_name, dbo.common_dictionary.dictionary_id

GO

EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[40] 4[20] 2[20] 3) )"
      End
      Begin PaneConfiguration = 1
         NumPanes = 3
         Configuration = "(H (1 [50] 4 [25] 3))"
      End
      Begin PaneConfiguration = 2
         NumPanes = 3
         Configuration = "(H (1 [50] 2 [25] 3))"
      End
      Begin PaneConfiguration = 3
         NumPanes = 3
         Configuration = "(H (4 [30] 2 [40] 3))"
      End
      Begin PaneConfiguration = 4
         NumPanes = 2
         Configuration = "(H (1 [56] 3))"
      End
      Begin PaneConfiguration = 5
         NumPanes = 2
         Configuration = "(H (2 [66] 3))"
      End
      Begin PaneConfiguration = 6
         NumPanes = 2
         Configuration = "(H (4 [50] 3))"
      End
      Begin PaneConfiguration = 7
         NumPanes = 1
         Configuration = "(V (3))"
      End
      Begin PaneConfiguration = 8
         NumPanes = 3
         Configuration = "(H (1[56] 4[18] 2) )"
      End
      Begin PaneConfiguration = 9
         NumPanes = 2
         Configuration = "(H (1 [75] 4))"
      End
      Begin PaneConfiguration = 10
         NumPanes = 2
         Configuration = "(H (1[66] 2) )"
      End
      Begin PaneConfiguration = 11
         NumPanes = 2
         Configuration = "(H (4 [60] 2))"
      End
      Begin PaneConfiguration = 12
         NumPanes = 1
         Configuration = "(H (1) )"
      End
      Begin PaneConfiguration = 13
         NumPanes = 1
         Configuration = "(V (4))"
      End
      Begin PaneConfiguration = 14
         NumPanes = 1
         Configuration = "(V (2))"
      End
      ActivePaneConfig = 0
   End
   Begin DiagramPane = 
      Begin Origin = 
         Top = 0
         Left = 0
      End
      Begin Tables = 
         Begin Table = "common_dictionary"
            Begin Extent = 
               Top = 6
               Left = 38
               Bottom = 123
               Right = 220
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "vw_type_uniqueness"
            Begin Extent = 
               Top = 6
               Left = 258
               Bottom = 93
               Right = 440
            End
            DisplayFlags = 280
            TopColumn = 0
         End
      End
   End
   Begin SQLPane = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 12
         Column = 1440
         Alias = 900
         Table = 1170
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1350
         SortOrder = 1410
         GroupBy = 1350
         Filter = 1350
         Or = 1350
         Or = 1350
         Or = 1350
      End
   End
End
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'vw_set_state_name'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'vw_set_state_name'
GO

/****** Object:  View [dbo].[vw_set_taxonomy]    Script Date: 03/18/2012 14:23:46 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE VIEW [dbo].[vw_set_taxonomy]
AS
SELECT     dbo.common_dictionary.database_name, dbo.common_dictionary.table_name, dbo.common_dictionary.dictionary_id, dbo.common_dictionary.type_value, 
                      SUM(dbo.common_dictionary.cardinality) AS cardinality
FROM         dbo.common_dictionary INNER JOIN
                      dbo.vw_type_uniqueness ON dbo.common_dictionary.type_name = dbo.vw_type_uniqueness.type_name
WHERE     (dbo.common_dictionary.type_name LIKE '%taxonomy code%')
GROUP BY dbo.common_dictionary.type_value, dbo.common_dictionary.database_name, dbo.common_dictionary.table_name, dbo.common_dictionary.dictionary_id

GO

EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[40] 4[20] 2[20] 3) )"
      End
      Begin PaneConfiguration = 1
         NumPanes = 3
         Configuration = "(H (1 [50] 4 [25] 3))"
      End
      Begin PaneConfiguration = 2
         NumPanes = 3
         Configuration = "(H (1 [50] 2 [25] 3))"
      End
      Begin PaneConfiguration = 3
         NumPanes = 3
         Configuration = "(H (4 [30] 2 [40] 3))"
      End
      Begin PaneConfiguration = 4
         NumPanes = 2
         Configuration = "(H (1 [56] 3))"
      End
      Begin PaneConfiguration = 5
         NumPanes = 2
         Configuration = "(H (2 [66] 3))"
      End
      Begin PaneConfiguration = 6
         NumPanes = 2
         Configuration = "(H (4 [50] 3))"
      End
      Begin PaneConfiguration = 7
         NumPanes = 1
         Configuration = "(V (3))"
      End
      Begin PaneConfiguration = 8
         NumPanes = 3
         Configuration = "(H (1[56] 4[18] 2) )"
      End
      Begin PaneConfiguration = 9
         NumPanes = 2
         Configuration = "(H (1 [75] 4))"
      End
      Begin PaneConfiguration = 10
         NumPanes = 2
         Configuration = "(H (1[66] 2) )"
      End
      Begin PaneConfiguration = 11
         NumPanes = 2
         Configuration = "(H (4 [60] 2))"
      End
      Begin PaneConfiguration = 12
         NumPanes = 1
         Configuration = "(H (1) )"
      End
      Begin PaneConfiguration = 13
         NumPanes = 1
         Configuration = "(V (4))"
      End
      Begin PaneConfiguration = 14
         NumPanes = 1
         Configuration = "(V (2))"
      End
      ActivePaneConfig = 0
   End
   Begin DiagramPane = 
      Begin Origin = 
         Top = 0
         Left = 0
      End
      Begin Tables = 
         Begin Table = "common_dictionary"
            Begin Extent = 
               Top = 6
               Left = 38
               Bottom = 123
               Right = 220
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "vw_type_uniqueness"
            Begin Extent = 
               Top = 6
               Left = 258
               Bottom = 93
               Right = 440
            End
            DisplayFlags = 280
            TopColumn = 0
         End
      End
   End
   Begin SQLPane = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 12
         Column = 1440
         Alias = 900
         Table = 1170
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1350
         SortOrder = 1410
         GroupBy = 1350
         Filter = 1350
         Or = 1350
         Or = 1350
         Or = 1350
      End
   End
End
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'vw_set_taxonomy'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'vw_set_taxonomy'
GO

/****** Object:  View [dbo].[vw_set_telephone_area_code]    Script Date: 03/18/2012 14:23:46 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE VIEW [dbo].[vw_set_telephone_area_code]
AS
SELECT     dbo.common_dictionary.database_name, dbo.common_dictionary.table_name, dbo.common_dictionary.dictionary_id, 
                      SUBSTRING(dbo.common_dictionary.type_value, 1, 3) AS type_value, SUM(dbo.common_dictionary.cardinality) AS cardinality
FROM         dbo.common_dictionary INNER JOIN
                      dbo.vw_type_uniqueness ON dbo.common_dictionary.type_name = dbo.vw_type_uniqueness.type_name
WHERE     (dbo.common_dictionary.type_name LIKE '%telephone number%')
GROUP BY SUBSTRING(dbo.common_dictionary.type_value, 1, 3), dbo.common_dictionary.database_name, dbo.common_dictionary.table_name, 
                      dbo.common_dictionary.dictionary_id

GO

EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[40] 4[20] 2[20] 3) )"
      End
      Begin PaneConfiguration = 1
         NumPanes = 3
         Configuration = "(H (1 [50] 4 [25] 3))"
      End
      Begin PaneConfiguration = 2
         NumPanes = 3
         Configuration = "(H (1 [50] 2 [25] 3))"
      End
      Begin PaneConfiguration = 3
         NumPanes = 3
         Configuration = "(H (4 [30] 2 [40] 3))"
      End
      Begin PaneConfiguration = 4
         NumPanes = 2
         Configuration = "(H (1 [56] 3))"
      End
      Begin PaneConfiguration = 5
         NumPanes = 2
         Configuration = "(H (2 [66] 3))"
      End
      Begin PaneConfiguration = 6
         NumPanes = 2
         Configuration = "(H (4 [50] 3))"
      End
      Begin PaneConfiguration = 7
         NumPanes = 1
         Configuration = "(V (3))"
      End
      Begin PaneConfiguration = 8
         NumPanes = 3
         Configuration = "(H (1[56] 4[18] 2) )"
      End
      Begin PaneConfiguration = 9
         NumPanes = 2
         Configuration = "(H (1 [75] 4))"
      End
      Begin PaneConfiguration = 10
         NumPanes = 2
         Configuration = "(H (1[66] 2) )"
      End
      Begin PaneConfiguration = 11
         NumPanes = 2
         Configuration = "(H (4 [60] 2))"
      End
      Begin PaneConfiguration = 12
         NumPanes = 1
         Configuration = "(H (1) )"
      End
      Begin PaneConfiguration = 13
         NumPanes = 1
         Configuration = "(V (4))"
      End
      Begin PaneConfiguration = 14
         NumPanes = 1
         Configuration = "(V (2))"
      End
      ActivePaneConfig = 0
   End
   Begin DiagramPane = 
      Begin Origin = 
         Top = 0
         Left = 0
      End
      Begin Tables = 
         Begin Table = "common_dictionary"
            Begin Extent = 
               Top = 6
               Left = 38
               Bottom = 123
               Right = 220
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "vw_type_uniqueness"
            Begin Extent = 
               Top = 6
               Left = 258
               Bottom = 93
               Right = 440
            End
            DisplayFlags = 280
            TopColumn = 0
         End
      End
   End
   Begin SQLPane = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 12
         Column = 1440
         Alias = 900
         Table = 1170
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1350
         SortOrder = 1410
         GroupBy = 1350
         Filter = 1350
         Or = 1350
         Or = 1350
         Or = 1350
      End
   End
End
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'vw_set_telephone_area_code'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'vw_set_telephone_area_code'
GO


