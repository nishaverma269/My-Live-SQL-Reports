-------------------------------------------------------------
----------- Display Termination Code Summary ----------------
--------- Created by Nisha Verma on 05/20/2019 --------------
-------------------------------------------------------------
Select SQ2.Company,
       SQ2.TerminationCode,
       SQ2.Count,
       Cast (SQ2.Count as Decimal) / Cast (SQ1.Total as Decimal) as Percentage
From

(Select Count(*) as Total From (

Select D.Supplier_Code as Company,
       C.Termination_Code as TerminationCode
From 
     Personnel_v_Employee as A
Left Outer Join Personnel_v_Termination as B
     On A.Plexus_User_No = B.PUN
Left Outer Join Personnel_v_Termination_Code as C
     On B.Termination_Code_Key = C.Termination_Code_Key
Left Join Common_v_Supplier as D
     On A.Supplier_Key = D.Supplier_No
     
Where B.Termination_Date Between @StartDate And @EndDate
  AND A.Employee_Status = 'Inactive'
  
) as Q1) as SQ1,

(Select Q1.Company, Q1.TerminationCode, Count(*) as Count From (

Select D.Supplier_Code as Company,
       C.Termination_Code as TerminationCode 
From 
     Personnel_v_Employee as A
Left Outer Join Personnel_v_Termination as B
     On A.Plexus_User_No = B.PUN
Left Outer Join Personnel_v_Termination_Code as C
     On B.Termination_Code_Key = C.Termination_Code_Key
Left Join Common_v_Supplier as D
     On A.Supplier_Key = D.Supplier_No
     
Where B.Termination_Date Between @StartDate And @EndDate 
  AND A.Employee_Status = 'Inactive'
  
) as Q1
Where Q1.TerminationCode = 'Quit'
  AND ISNULL(Q1.Company, '') LIKE @Company + '%'
Group By Q1.Company, Q1.TerminationCode) as SQ2

Union All 

Select SQ2.Company,
       SQ2.TerminationCode,
       SQ2.Count,
       Cast (SQ2.Count as Decimal) / Cast (SQ1.Total as Decimal) as Percentage
From

(Select Count(*) as Total From (

Select D.Supplier_Code as Company,
       C.Termination_Code as TerminationCode
From 
     Personnel_v_Employee as A
Left Outer Join Personnel_v_Termination as B
     On A.Plexus_User_No = B.PUN
Left Outer Join Personnel_v_Termination_Code as C
     On B.Termination_Code_Key = C.Termination_Code_Key
Left Join Common_v_Supplier as D
     On A.Supplier_Key = D.Supplier_No
     
Where B.Termination_Date Between @StartDate And @EndDate
  AND A.Employee_Status = 'Inactive'
  
) as Q1) as SQ1,

(Select Q1.Company, Q1.TerminationCode, Count(*) as Count From (

Select D.Supplier_Code as Company,
       C.Termination_Code as TerminationCode 
From 
     Personnel_v_Employee as A
Left Outer Join Personnel_v_Termination as B
     On A.Plexus_User_No = B.PUN
Left Outer Join Personnel_v_Termination_Code as C
     On B.Termination_Code_Key = C.Termination_Code_Key
Left Join Common_v_Supplier as D
     On A.Supplier_Key = D.Supplier_No
     
Where B.Termination_Date Between @StartDate And @EndDate 
  AND A.Employee_Status = 'Inactive'
  
) as Q1
Where Q1.TerminationCode = 'Released-Attendance'
  AND ISNULL(Q1.Company, '') LIKE @Company + '%'
Group By Q1.Company, Q1.TerminationCode) as SQ2

Union All 

Select SQ2.Company,
       SQ2.TerminationCode,
       SQ2.Count,
       Cast (SQ2.Count as Decimal) / Cast (SQ1.Total as Decimal) as Percentage
From

(Select Count(*) as Total From (

Select D.Supplier_Code as Company,
       C.Termination_Code as TerminationCode
From 
     Personnel_v_Employee as A
Left Outer Join Personnel_v_Termination as B
     On A.Plexus_User_No = B.PUN
Left Outer Join Personnel_v_Termination_Code as C
     On B.Termination_Code_Key = C.Termination_Code_Key
Left Join Common_v_Supplier as D
     On A.Supplier_Key = D.Supplier_No
     
Where B.Termination_Date Between @StartDate And @EndDate
  AND A.Employee_Status = 'Inactive'
  
) as Q1) as SQ1,

(Select Q1.Company, Q1.TerminationCode, Count(*) as Count From (

Select D.Supplier_Code as Company,
       C.Termination_Code as TerminationCode 
From 
     Personnel_v_Employee as A
Left Outer Join Personnel_v_Termination as B
     On A.Plexus_User_No = B.PUN
Left Outer Join Personnel_v_Termination_Code as C
     On B.Termination_Code_Key = C.Termination_Code_Key
Left Join Common_v_Supplier as D
     On A.Supplier_Key = D.Supplier_No
     
Where B.Termination_Date Between @StartDate And @EndDate 
  AND A.Employee_Status = 'Inactive'
  
) as Q1
Where Q1.TerminationCode = 'Released-Performance'
  AND ISNULL(Q1.Company, '') LIKE @Company + '%'
Group By Q1.Company, Q1.TerminationCode) as SQ2

Union All 

Select SQ2.Company,
       SQ2.TerminationCode,
       SQ2.Count,
       Cast (SQ2.Count as Decimal) / Cast (SQ1.Total as Decimal) as Percentage
From

(Select Count(*) as Total From (

Select D.Supplier_Code as Company,
       C.Termination_Code as TerminationCode
From 
     Personnel_v_Employee as A
Left Outer Join Personnel_v_Termination as B
     On A.Plexus_User_No = B.PUN
Left Outer Join Personnel_v_Termination_Code as C
     On B.Termination_Code_Key = C.Termination_Code_Key
Left Join Common_v_Supplier as D
     On A.Supplier_Key = D.Supplier_No
     
Where B.Termination_Date Between @StartDate And @EndDate
  AND A.Employee_Status = 'Inactive'
  
) as Q1) as SQ1,

(Select Q1.Company, Q1.TerminationCode, Count(*) as Count From (

Select D.Supplier_Code as Company,
       C.Termination_Code as TerminationCode 
From 
     Personnel_v_Employee as A
Left Outer Join Personnel_v_Termination as B
     On A.Plexus_User_No = B.PUN
Left Outer Join Personnel_v_Termination_Code as C
     On B.Termination_Code_Key = C.Termination_Code_Key
Left Join Common_v_Supplier as D
     On A.Supplier_Key = D.Supplier_No
     
Where B.Termination_Date Between @StartDate And @EndDate 
  AND A.Employee_Status = 'Inactive'
  
) as Q1
Where Q1.TerminationCode = 'Resignation'
  AND ISNULL(Q1.Company, '') LIKE @Company + '%'
Group By Q1.Company, Q1.TerminationCode) as SQ2

Union All 

Select SQ2.Company,
       SQ2.TerminationCode,
       SQ2.Count,
       Cast (SQ2.Count as Decimal) / Cast (SQ1.Total as Decimal) as Percentage
From

(Select Count(*) as Total From (

Select D.Supplier_Code as Company,
       C.Termination_Code as TerminationCode
From 
     Personnel_v_Employee as A
Left Outer Join Personnel_v_Termination as B
     On A.Plexus_User_No = B.PUN
Left Outer Join Personnel_v_Termination_Code as C
     On B.Termination_Code_Key = C.Termination_Code_Key
Left Join Common_v_Supplier as D
     On A.Supplier_Key = D.Supplier_No
     
Where B.Termination_Date Between @StartDate And @EndDate
  AND A.Employee_Status = 'Inactive'
  
) as Q1) as SQ1,

(Select Q1.Company, Q1.TerminationCode, Count(*) as Count From (

Select D.Supplier_Code as Company,
       C.Termination_Code as TerminationCode 
From 
     Personnel_v_Employee as A
Left Outer Join Personnel_v_Termination as B
     On A.Plexus_User_No = B.PUN
Left Outer Join Personnel_v_Termination_Code as C
     On B.Termination_Code_Key = C.Termination_Code_Key
Left Join Common_v_Supplier as D
     On A.Supplier_Key = D.Supplier_No
     
Where B.Termination_Date Between @StartDate And @EndDate 
  AND A.Employee_Status = 'Inactive'
  
) as Q1
Where Q1.TerminationCode = 'Terminated'
  AND ISNULL(Q1.Company, '') LIKE @Company + '%'
Group By Q1.Company, Q1.TerminationCode) as SQ2