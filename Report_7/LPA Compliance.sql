--------------- LPA Complaince Rate Graph ---------------
------ Created by Nisha Verma on 03/21/2019 ----------------
------------------------------------------------------------

----------------------------------------Query 1-----------------------------------------------------------------
Select SQ1.Layer,
       SQ1.Planned,
       SQ2.Completed
From 
(Select Q1.Layer as Layer,
       Count(*) as Planned
From
(Select  TRIM(SUBSTRING(A.Description, CHARINDEX('LPA', A.Description)+4, 2)) as Layer 
From Maintenance_v_Work_Request as A, Maintenance_v_Equipment as B
Where A.Equipment_Key = B.Equipment_Key
 AND  A.Due_Date BETWEEN @StartDate AND @EndDate-1
 AND  A.Work_Request_Type_Key = 54 --PM (56 = Follow up)
 AND  B.Equipment_Group = 'LPA') as Q1
Where Q1.Layer = 'L1'
Group By Q1.Layer) as SQ1,

(Select Q1.Layer as Layer,
       Count(*) as Completed
From
(Select  TRIM(SUBSTRING(A.Description, CHARINDEX('LPA', A.Description)+4, 2)) as Layer 
From Maintenance_v_Work_Request as A, Maintenance_v_Equipment as B
Where A.Equipment_Key = B.Equipment_Key
 AND  A.Due_Date BETWEEN @StartDate AND @EndDate-1
 AND  A.Work_Request_Status_Key = 49
 AND  A.Work_Request_Type_Key = 54 --PM (56 = Follow up)
 AND  B.Equipment_Group = 'LPA') as Q1
Where Q1.Layer = 'L1'
Group By Q1.Layer) as SQ2

Union All

 ----------------------------------------Query 2-----------------------------------------------------------------
Select SQ1.Layer,
       SQ1.Planned,
       SQ2.Completed
From 
(Select Q1.Layer as Layer,
       Count(*) as Planned
From
(Select  TRIM(SUBSTRING(A.Description, CHARINDEX('LPA', A.Description)+4, 2)) as Layer 
From Maintenance_v_Work_Request as A, Maintenance_v_Equipment as B
Where A.Equipment_Key = B.Equipment_Key
 AND  A.Due_Date BETWEEN @StartDate AND @EndDate-1
 AND  A.Work_Request_Type_Key = 54 --PM (56 = Follow up)
 AND  B.Equipment_Group = 'LPA') as Q1
Where Q1.Layer = 'L2'
Group By Q1.Layer) as SQ1,

(Select Q1.Layer as Layer,
       Count(*) as Completed
From
(Select  TRIM(SUBSTRING(A.Description, CHARINDEX('LPA', A.Description)+4, 2)) as Layer 
From Maintenance_v_Work_Request as A, Maintenance_v_Equipment as B
Where A.Equipment_Key = B.Equipment_Key
 AND  A.Due_Date BETWEEN @StartDate AND @EndDate-1
 AND  A.Work_Request_Status_Key = 49
 AND  A.Work_Request_Type_Key = 54 --PM (56 = Follow up)
 AND  B.Equipment_Group = 'LPA') as Q1
Where Q1.Layer = 'L2'
Group By Q1.Layer) as SQ2

Union All

 ----------------------------------------Query 3-----------------------------------------------------------------
Select SQ1.Layer,
       SQ1.Planned,
       SQ2.Completed
From 
(Select Q1.Layer as Layer,
       Count(*) as Planned
From
(Select  TRIM(SUBSTRING(A.Description, CHARINDEX('LPA', A.Description)+4, 2)) as Layer 
From Maintenance_v_Work_Request as A, Maintenance_v_Equipment as B
Where A.Equipment_Key = B.Equipment_Key
 AND  A.Due_Date BETWEEN @StartDate AND @EndDate-1
 AND  A.Work_Request_Type_Key = 54 --PM (56 = Follow up)
 AND  B.Equipment_Group = 'LPA') as Q1
Where Q1.Layer = 'L3'
Group By Q1.Layer) as SQ1,

(Select Q1.Layer as Layer,
       Count(*) as Completed
From
(Select  TRIM(SUBSTRING(A.Description, CHARINDEX('LPA', A.Description)+4, 2)) as Layer 
From Maintenance_v_Work_Request as A, Maintenance_v_Equipment as B
Where A.Equipment_Key = B.Equipment_Key
 AND  A.Due_Date BETWEEN @StartDate AND @EndDate-1
 AND  A.Work_Request_Status_Key = 49
 AND  A.Work_Request_Type_Key = 54 --PM (56 = Follow up)
 AND  B.Equipment_Group = 'LPA') as Q1
Where Q1.Layer = 'L3'
Group By Q1.Layer) as SQ2

Union All

 ----------------------------------------Query 4-----------------------------------------------------------------
Select SQ1.Layer,
       SQ1.Planned,
       SQ2.Completed
From 
(Select Q1.Layer as Layer,
       Count(*) as Planned
From
(Select  TRIM(SUBSTRING(A.Description, CHARINDEX('LPA', A.Description)+4, 2)) as Layer 
From Maintenance_v_Work_Request as A, Maintenance_v_Equipment as B
Where A.Equipment_Key = B.Equipment_Key
 AND  A.Due_Date BETWEEN @StartDate AND @EndDate-1
 AND  A.Work_Request_Type_Key = 54 --PM (56 = Follow up)
 AND  B.Equipment_Group = 'LPA') as Q1
Where Q1.Layer = 'L4'
Group By Q1.Layer) as SQ1,

(Select Q1.Layer as Layer,
       Count(*) as Completed
From
(Select  TRIM(SUBSTRING(A.Description, CHARINDEX('LPA', A.Description)+4, 2)) as Layer 
From Maintenance_v_Work_Request as A, Maintenance_v_Equipment as B
Where A.Equipment_Key = B.Equipment_Key
 AND  A.Due_Date BETWEEN @StartDate AND @EndDate-1
 AND  A.Work_Request_Status_Key = 49
 AND  A.Work_Request_Type_Key = 54 --PM (56 = Follow up)
 AND  B.Equipment_Group = 'LPA') as Q1
Where Q1.Layer = 'L4'
Group By Q1.Layer) as SQ2