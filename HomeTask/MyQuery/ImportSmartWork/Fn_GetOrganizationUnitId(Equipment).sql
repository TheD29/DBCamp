
GO

/****** Object:  UserDefinedFunction [SupportDefined].[FN_getOrganizationUnitId]    Script Date: 08/31/2015 10:19:00 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


CREATE FUNCTION [SupportDefined].[FN_getOrganizationUnitId] ()
RETURNS INT
AS
/*повертає ідентифікатор для філіалу
110602 A.Chekh
*/
BEGIN
RETURN
(
	SELECT TOP 1 [OU].[OrganizationUnitId] 
FROM [Services].[Setting] SS
JOIN [Organization].[OrganizationUnit] OU ON [SS].[Value] = CONVERT(CHAR(36),[OU].[Guid])
WHERE SS.[SettingId] = 5
)
END
GO


