--------------- LPA N&NC Rate Graph ---------------
------ Created by Nisha Verma on 03/20/2019 ----------------
------------------------------------------------------------

----------------------------------------Query 1-----------------------------------------------------------------
Select Q1.Layer as Layer,
       Q1.NC_Type as NC_Type,
       Count(*) as Status
From
(SELECT  TRIM(SUBSTRING(A.Description, CHARINDEX('LPA', A.Description)+4, 2)) as Layer,
        Case When CHARINDEX('<NC>', B.Note) > 0 Then 'NC'
             When CHARINDEX('<nc>', B.Note) > 0 Then 'NC'
             When CHARINDEX('<N>', B.Note) > 0 Then 'N'
             When CHARINDEX('<n>', B.Note) > 0 Then 'N'
        END as NC_Type

FROM    Maintenance_v_Work_Request    AS A,
        Maintenance_v_Work_Task       AS B,
        Maintenance_v_Equipment       AS C

WHERE   A.Work_Request_Key = B.Work_Request_Key
  AND   A.Equipment_Key = C.Equipment_Key
  AND   A.Work_Request_Type_Key = 56 --Follow up (54 = PM)
  AND   A.Work_Request_Status_Key = 49 --Completed (48 = New)
  AND   B.Result = 1 --Selected Good in follow up task
  AND   A.Completed_Date BETWEEN @StartDate AND @EndDate
  --AND   C.Equipment_Group = 'LPA'
  ) as Q1
Where Q1.Layer = 'L1'
  AND Q1.NC_Type = 'N'
Group By Q1.Layer, Q1.NC_Type

Union All

----------------------------------------Query 2-----------------------------------------------------------------
Select Q1.Layer as Layer,
       Q1.NC_Type as NC_Type,
       Count(*) as Status
From
(SELECT  TRIM(SUBSTRING(A.Description, CHARINDEX('LPA', A.Description)+4, 2)) as Layer,
        Case When CHARINDEX('<NC>', B.Note) > 0 Then 'NC'
             When CHARINDEX('<nc>', B.Note) > 0 Then 'NC'
             When CHARINDEX('<N>', B.Note) > 0 Then 'N'
             When CHARINDEX('<n>', B.Note) > 0 Then 'N'
        END as NC_Type

FROM    Maintenance_v_Work_Request    AS A,
        Maintenance_v_Work_Task       AS B,
        Maintenance_v_Equipment       AS C

WHERE   A.Work_Request_Key = B.Work_Request_Key
  AND   A.Equipment_Key = C.Equipment_Key
  AND   A.Work_Request_Type_Key = 56 --Follow up (54 = PM)
  AND   A.Work_Request_Status_Key = 49 --Completed (48 = New)
  AND   B.Result = 1 --Selected Good in follow up task
  AND   A.Completed_Date BETWEEN @StartDate AND @EndDate
  --AND   C.Equipment_Group = 'LPA'
  ) as Q1
Where Q1.Layer = 'L1'
  AND Q1.NC_Type = 'NC'
Group By Q1.Layer, Q1.NC_Type

Union All

----------------------------------------Query 3-----------------------------------------------------------------
Select Q1.Layer as Layer,
       Q1.NC_Type as NC_Type,
       Count(*) as Status
From
(SELECT  TRIM(SUBSTRING(A.Description, CHARINDEX('LPA', A.Description)+4, 2)) as Layer,
        Case When CHARINDEX('<NC>', B.Note) > 0 Then 'NC'
             When CHARINDEX('<nc>', B.Note) > 0 Then 'NC'
             When CHARINDEX('<N>', B.Note) > 0 Then 'N'
             When CHARINDEX('<n>', B.Note) > 0 Then 'N'
        END as NC_Type

FROM    Maintenance_v_Work_Request    AS A,
        Maintenance_v_Work_Task       AS B,
        Maintenance_v_Equipment       AS C

WHERE   A.Work_Request_Key = B.Work_Request_Key
  AND   A.Equipment_Key = C.Equipment_Key
  AND   A.Work_Request_Type_Key = 56 --Follow up (54 = PM)
  AND   A.Work_Request_Status_Key = 49 --Completed (48 = New)
  AND   B.Result = 1 --Selected Good in follow up task
  AND   A.Completed_Date BETWEEN @StartDate AND @EndDate
  --AND   C.Equipment_Group = 'LPA'
  ) as Q1
Where Q1.Layer = 'L2'
  AND Q1.NC_Type = 'N'
Group By Q1.Layer, Q1.NC_Type

Union All

----------------------------------------Query 4-----------------------------------------------------------------
Select Q1.Layer as Layer,
       Q1.NC_Type as NC_Type,
       Count(*) as Status
From
(SELECT  TRIM(SUBSTRING(A.Description, CHARINDEX('LPA', A.Description)+4, 2)) as Layer,
        Case When CHARINDEX('<NC>', B.Note) > 0 Then 'NC'
             When CHARINDEX('<nc>', B.Note) > 0 Then 'NC'
             When CHARINDEX('<N>', B.Note) > 0 Then 'N'
             When CHARINDEX('<n>', B.Note) > 0 Then 'N'
        END as NC_Type

FROM    Maintenance_v_Work_Request    AS A,
        Maintenance_v_Work_Task       AS B,
        Maintenance_v_Equipment       AS C

WHERE   A.Work_Request_Key = B.Work_Request_Key
  AND   A.Equipment_Key = C.Equipment_Key
  AND   A.Work_Request_Type_Key = 56 --Follow up (54 = PM)
  AND   A.Work_Request_Status_Key = 49 --Completed (48 = New)
  AND   B.Result = 1 --Selected Good in follow up task
  AND   A.Completed_Date BETWEEN @StartDate AND @EndDate
  --AND   C.Equipment_Group = 'LPA'
  ) as Q1
Where Q1.Layer = 'L2'
  AND Q1.NC_Type = 'NC'
Group By Q1.Layer, Q1.NC_Type

Union All

----------------------------------------Query 5-----------------------------------------------------------------
Select Q1.Layer as Layer,
       Q1.NC_Type as NC_Type,
       Count(*) as Status
From
(SELECT  TRIM(SUBSTRING(A.Description, CHARINDEX('LPA', A.Description)+4, 2)) as Layer,
        Case When CHARINDEX('<NC>', B.Note) > 0 Then 'NC'
             When CHARINDEX('<nc>', B.Note) > 0 Then 'NC'
             When CHARINDEX('<N>', B.Note) > 0 Then 'N'
             When CHARINDEX('<n>', B.Note) > 0 Then 'N'
        END as NC_Type

FROM    Maintenance_v_Work_Request    AS A,
        Maintenance_v_Work_Task       AS B,
        Maintenance_v_Equipment       AS C

WHERE   A.Work_Request_Key = B.Work_Request_Key
  AND   A.Equipment_Key = C.Equipment_Key
  AND   A.Work_Request_Type_Key = 56 --Follow up (54 = PM)
  AND   A.Work_Request_Status_Key = 49 --Completed (48 = New)
  AND   B.Result = 1 --Selected Good in follow up task
  AND   A.Completed_Date BETWEEN @StartDate AND @EndDate
  --AND   C.Equipment_Group = 'LPA'
  ) as Q1
Where Q1.Layer = 'L3'
  AND Q1.NC_Type = 'N'
Group By Q1.Layer, Q1.NC_Type

Union All

----------------------------------------Query 6-----------------------------------------------------------------
Select Q1.Layer as Layer,
       Q1.NC_Type as NC_Type,
       Count(*) as Status
From
(SELECT  TRIM(SUBSTRING(A.Description, CHARINDEX('LPA', A.Description)+4, 2)) as Layer,
        Case When CHARINDEX('<NC>', B.Note) > 0 Then 'NC'
             When CHARINDEX('<nc>', B.Note) > 0 Then 'NC'
             When CHARINDEX('<N>', B.Note) > 0 Then 'N'
             When CHARINDEX('<n>', B.Note) > 0 Then 'N'
        END as NC_Type

FROM    Maintenance_v_Work_Request    AS A,
        Maintenance_v_Work_Task       AS B,
        Maintenance_v_Equipment       AS C

WHERE   A.Work_Request_Key = B.Work_Request_Key
  AND   A.Equipment_Key = C.Equipment_Key
  AND   A.Work_Request_Type_Key = 56 --Follow up (54 = PM)
  AND   A.Work_Request_Status_Key = 49 --Completed (48 = New)
  AND   B.Result = 1 --Selected Good in follow up task
  AND   A.Completed_Date BETWEEN @StartDate AND @EndDate
  --AND   C.Equipment_Group = 'LPA'
  ) as Q1
Where Q1.Layer = 'L3'
  AND Q1.NC_Type = 'NC'
Group By Q1.Layer, Q1.NC_Type

Union All

----------------------------------------Query 7-----------------------------------------------------------------
Select Q1.Layer as Layer,
       Q1.NC_Type as NC_Type,
       Count(*) as Status
From
(SELECT  TRIM(SUBSTRING(A.Description, CHARINDEX('LPA', A.Description)+4, 2)) as Layer,
        Case When CHARINDEX('<NC>', B.Note) > 0 Then 'NC'
             When CHARINDEX('<nc>', B.Note) > 0 Then 'NC'
             When CHARINDEX('<N>', B.Note) > 0 Then 'N'
             When CHARINDEX('<n>', B.Note) > 0 Then 'N'
        END as NC_Type

FROM    Maintenance_v_Work_Request    AS A,
        Maintenance_v_Work_Task       AS B,
        Maintenance_v_Equipment       AS C

WHERE   A.Work_Request_Key = B.Work_Request_Key
  AND   A.Equipment_Key = C.Equipment_Key
  AND   A.Work_Request_Type_Key = 56 --Follow up (54 = PM)
  AND   A.Work_Request_Status_Key = 49 --Completed (48 = New)
  AND   B.Result = 1 --Selected Good in follow up task
  AND   A.Completed_Date BETWEEN @StartDate AND @EndDate
  --AND   C.Equipment_Group = 'LPA'
  ) as Q1
Where Q1.Layer = 'L4'
  AND Q1.NC_Type = 'N'
Group By Q1.Layer, Q1.NC_Type

Union All

----------------------------------------Query 8-----------------------------------------------------------------
Select Q1.Layer as Layer,
       Q1.NC_Type as NC_Type,
       Count(*) as Status
From
(SELECT  TRIM(SUBSTRING(A.Description, CHARINDEX('LPA', A.Description)+4, 2)) as Layer,
        Case When CHARINDEX('<NC>', B.Note) > 0 Then 'NC'
             When CHARINDEX('<nc>', B.Note) > 0 Then 'NC'
             When CHARINDEX('<N>', B.Note) > 0 Then 'N'
             When CHARINDEX('<n>', B.Note) > 0 Then 'N'
        END as NC_Type

FROM    Maintenance_v_Work_Request    AS A,
        Maintenance_v_Work_Task       AS B,
        Maintenance_v_Equipment       AS C

WHERE   A.Work_Request_Key = B.Work_Request_Key
  AND   A.Equipment_Key = C.Equipment_Key
  AND   A.Work_Request_Type_Key = 56 --Follow up (54 = PM)
  AND   A.Work_Request_Status_Key = 49 --Completed (48 = New)
  AND   B.Result = 1 --Selected Good in follow up task
  AND   A.Completed_Date BETWEEN @StartDate AND @EndDate
  --AND   C.Equipment_Group = 'LPA'
  ) as Q1
Where Q1.Layer = 'L4'
  AND Q1.NC_Type = 'NC'
Group By Q1.Layer, Q1.NC_Type