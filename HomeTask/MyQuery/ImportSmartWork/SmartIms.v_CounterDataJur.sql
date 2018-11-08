USE [PRDIR_Equipment]
GO

/****** Object:  View [SmartIms].[v_CounterDataJur]    Script Date: 09/03/2015 16:55:43 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO







CREATE VIEW [SmartIms].[v_CounterDataJur]
AS
SELECT 

NEWID() AS GroupIndexGuid,
		CounterMeasuringId,
		CoreEquipmentGuid,
		ROUND(DDJ.Value/100,0) AS IndexValue,
		Time AS IndexDate,
		Id AS DevId,
		CounterNumber,
		FilialId,
		ContractNumber,
		FDJ.DirectionType AS EquipmentDirectionType,
		DSJ.DirectionType,
		JuridicalScaleId,
		EquipmentScaleId,
		DSJ.Name

 FROM SmartIms.Device AS D
		JOIN SmartIms.DeviceDataJur AS DDJ ON d.Id=DDJ.DeviceId
		JOIN SmartIms.DeviceScaleJur AS DSJ ON DDJ.TariffId = DSJ.TariffId
		JOIN SmartIms.FilialDeviceJur AS FDJ ON D.SN=CONVERT(NUMERIC,CounterNumber)
WHERE DDJ.LogicalName=DSJ.DeviceScale
		AND FDJ.DirectionType=DSJ.DirectionType
		AND FDJ.Number=DSJ.EquipmentScaleId
		







GO


