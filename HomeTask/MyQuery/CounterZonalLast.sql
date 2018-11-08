 DECLARE @sql VARCHAR(max)

SET @sql = '




SELECT 

AccountNumber,
CG.ShortName
 
FROM AccountingCommon.Account AS A 
left join AccountingCommon.Contract AS contr on contr.AccountID=a.AccountId
JOIN AccountingCommon.Address AS A3 ON A.AddressId = A3.AddressId
  JOIN AccountingCommon.UsageObject AS UO ON A.AccountId = UO.AccountId
  JOIN AccountingCommon.Address AS A2 ON UO.AddressId = A2.AddressId
  JOIN AccountingCommon.Point AS P ON UO.UsageObjectId = P.UsageObjectId
  JOIN Measuring.Counter AS C ON p.PointId=C.PointId
  JOIN Measuring.CounterType AS CT ON c.CounterTypeId=CT.CounterTypeId
  OUTER APPLY (SELECT TOP 1 cg2.* FROM AccountingCommon.ClassifierGroupAccount AS CGA 
  JOIN Dictionary.ClassifierGroup AS CG2 ON CGA.ClassifierGroupId = CG2.ClassifierGroupId AND CG2.ClassifierGroupId IN (2,3,6,20)
  WHERE a.AccountId=CGA.AccountId) CG  
  LEFT JOIN AccountingCommon.PhysicalPerson AS PP ON a.PhysicalPersonId=PP.PhysicalPersonId
  LEFT JOIN AccountingDictionary.OblElement AS OE ON p.OblElementId=OE.OblElementId
 join  [EquipmentDB].Billing.[CounterTimeZonal] tz on tz.CounterTimeZonalId=c.counterId            
         JOIN  [EquipmentDB].Counter.[CounterMeasuring] fcm ON tz.CounterMeasuringId = fcm.CounterMeasuringId
         JOIN  [EquipmentDB].Counter.[CounterHistory] fch ON fcm.CounterHistoryId = fch.CounterHistoryId
         JOIN  [EquipmentDB].EquipmentDictionary.[CounterType] fct ON fch.CounterTypeId = fct.CounterTypeId
 
WHERE C.DateTo=''20790606''
--AND fCH.IsActiveScaleCountProgrammable=1
AND contr.DateTo=''20790606''

--AND CT.Code NOT IN (10242,10243,10244)-- Smart 3
and contr.ContractRegularTypeId in (1,10)-- Договір та договір на буд майданчик (тип договору)
and cg.shortname IS NOT NUll
'
SET @sql = [Services].[ReplaceDatabasePath]('EquipmentDB', @sql)
EXEC (@sql) --AT UtilityServer"


