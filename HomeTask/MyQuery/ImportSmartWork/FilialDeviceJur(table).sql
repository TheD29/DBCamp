SELECT 
	DJ.Id
FROM SmartIms.ReportDay AS RD
	JOIN SmartIms.FilialDeviceJur AS FDJ ON RD.FilialId = FDJ.FilialId
	JOIN SmartIms.DeviceJur AS DJ ON CONVERT(NUMERIC,FDJ.CounterNumber)=DJ.SN
WHERE FDJ.CounterNumber=RD.CounterNumber
	AND DATEPART(DAY,GETDATE())=RD.ReportDay
GROUP BY DJ.Id
HAVING COUNT(dj.Id)>=1