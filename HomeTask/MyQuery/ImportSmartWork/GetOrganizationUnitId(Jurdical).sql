
GO

/****** Object:  UserDefinedFunction [SupportDefined].[FN_getOrganizationUnitId]    Script Date: 09/01/2015 15:19:02 ******/
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
	SELECT OU.OrganizationUnitId FROM dbo.OrganizationUnit AS OU
WHERE ContractorId IS NOT NULL
)
END
GO


