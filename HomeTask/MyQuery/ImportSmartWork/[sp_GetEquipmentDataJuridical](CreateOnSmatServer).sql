USE [ADDAXDB_APPSERVER]
GO

/****** Object:  StoredProcedure [dbo].[sp_GetEquipmentDataJuridical]    Script Date: 09/03/2015 17:01:17 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO













ALTER PROCEDURE [dbo].[sp_GetEquipmentDataJuridical] (@Type TINYINT,
 @CounterId INT = NULL,
  @date SMALLDATETIME = NULL)
AS BEGIN

-- Лічильники Device
IF @Type = 1
BEGIN
SELECT * FROM [dbo].[dm_Devices] AS DD
END




-- Інформація про показники лічильника за період DeviceData
IF @Type = 4
BEGIN

IF @CounterId IS NULL OR @date Is NULL  RETURN

SELECT  TOP 1  RT.[Ident]
       ,RRD.[DeviceId]
       ,RRD.ClassId
       ,RRD.LogicalName
       ,RRD.AttId
       ,RRD.[Time]
       ,[ReceivedTime]
       ,[Value]
       ,[Event]
       ,RTP.[Unit]
       ,RTP.[Scaler]
       ,[NormValue]
       , (CASE WHEN RTP.Number IN (7) THEN 6
			WHEN RTP.Number IN (8) THEN 5 
			WHEN RTP.Number IN (9) THEN 7 
			WHEN RTP.Number IN (15) THEN 3
			WHEN RTP.Number IN (16) THEN 2
			WHEN RTP.Number IN (5) THEN 1
       END) AS Number
       ,     NULL AS TariffId
       
FROM dbo.RW_TemplateParameter AS RTP
			LEFT JOIN dbo.RW_Template AS RT ON RTP.TemplateId = RT.Ident
			LEFT JOIN dbo.RW_ReceivedData AS RRD ON RRD.LogicalName=RTP.LogicalName
			LEFT JOIN dbo.v_Devices AS VD ON VD.Id=RRD.DeviceId
	WHERE  RRD.Time=@date
                       -- AND DeviceId IN (25441,11505,31602)
                      AND TemplateId=10 AND [Option]=0
                       AND RTP.ClassId=4
                       AND RRD.LogicalName NOT IN (0x01034B0800FF,0x0101230800FF,0x0102370800FF)
                       AND VD.Id=@CounterId
                     
          
--SELECT CONVERT(SMALLDATETIME,DATEADD(DAY, DATEDIFF(day, 0, GETDATE()), 0)) FROM dbo.RW_ReceivedData AS RRD
                       
--				SELECT * FROM dbo.RW_ReceivedData AS RRD WHERE Time='20150903'
				
--							SELECT  [Ident]
--       ,[DeviceId]
--       ,RD.[ClassId]
--       ,RD.[LogicalName]
--       ,RD.[AttId]
--       ,[Time]
--       ,[ReceivedTime]
--       ,[Value]
--       ,[Event]
--       ,[Unit]
--       ,[Scaler]
--       ,[NormValue]
--FROM    ( SELECT    DENSE_RANK() OVER ( PARTITION BY [DeviceId] ORDER BY [Time] DESC ) AS RowNumber
--                   ,[RRD].*
--          FROM      RW_ReceivedData AS RRD ( NOLOCK )
--                    JOIN [dbo].[dm_Devices] AS DD (NOLOCK) ON [RRD].[DeviceId] = [DD].[Id]
--          WHERE     [Time] ='20150819'
--                     AND [RRD].[LogicalName] IN (0x01000F0800FF,
--0x0100640800FF,
--0x0100650800FF,
--0x01000F0801FF,
--0x01000F0802FF,
--0x01000F0803FF,
--0x01000F0801FF,
--0x01000F0802FF)
--        ) RD
----join (SELECT DISTINCT [TemplateId], [AttId], [ClassId], [DisplayName], [LogicalName] from [dbo].[RW_TemplateParameter] (NOLOCK)) AS RTP ON [RD].[AttId] = [RTP].[AttId] AND [RD].[ClassId] = [RTP].[ClassId] AND [RD].[LogicalName] = [RTP].[LogicalName] AND [TemplateId] = 7
--WHERE   [RowNumber] = 1
--AND RD.DeviceId IN (25441,11505,31602)
--AND RD.LogicalName<>0x0001600502FF
				
--ORDER BY ReceivedTime DESC
END
END














GO


