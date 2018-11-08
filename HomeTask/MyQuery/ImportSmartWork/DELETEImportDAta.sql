DELETE FROM dbo.CounterMeterage WHERE MeterageDate='20150913' AND StaffId=375

DELETE FROM dbo.CounterMeterage WHERE EquipmentGroupIndexGuid IN 
(SELECT Guid FROM 
PR240_Equipment.Counter.GroupIndex AS GI 
WHERE Date=CONVERT(SMALLDATETIME,DATEADD(DAY, DATEDIFF(day, 0, GETDATE()), -1)) AND GroupIndexSourceId=112)


DELETE FROM  PR240_Equipment.Counter.[Index]
WHERE GroupIndexId IN 
(SELECT GroupIndexId FROM 
PR240_Equipment.Counter.GroupIndex AS GI 
WHERE Date=CONVERT(SMALLDATETIME,DATEADD(DAY, DATEDIFF(day, 0, GETDATE()), -1)) AND GroupIndexSourceId=112)


DELETE FROM PR240_Equipment.Counter.GroupIndex
WHERE GroupIndexId IN 
(SELECT GroupIndexId FROM 
PR240_Equipment.Counter.GroupIndex AS GI 
WHERE Date=CONVERT(SMALLDATETIME,DATEADD(DAY, DATEDIFF(day, 0, GETDATE()), -1)) AND GroupIndexSourceId=112)
