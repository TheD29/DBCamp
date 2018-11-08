
SET NOCOUNT ON;
SET XACT_ABORT ON;
GO

BEGIN TRANSACTION;
INSERT INTO [Services].[DatabasePath]([DatabasePathId], [Guid], [DBAlias], [ServerName], [DBName])
SELECT 6, N'326e9fe2-f04d-447d-a9cd-b9998cdf1e0c', N'JuridicalDB', N'[JuridicalServer]', N'[PR240_Juridical]'
COMMIT;
RAISERROR (N'[Services].[DatabasePath]: Insert Batch: 1.....Done!', 10, 1) WITH NOWAIT;
GO

