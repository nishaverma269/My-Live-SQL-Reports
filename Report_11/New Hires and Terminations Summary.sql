----------- HR New Hires and Terminations Summary Report  -------------
-------------- Created by Nisha Verma on 03/06/2019 -------------------
-----------------------------------------------------------------------

------ CREATE NEW HIRES TABLE ------
Create Table #Hires
(
    Status          VARCHAR(max),
    Company         VARCHAR(max),
    PayType         VARCHAR(max),
    Employee#       INT,
    Employee        VARCHAR(max),
    Position        VARCHAR(max),
    HireDate        VARCHAR(50),
    TerminationDate VARCHAR(max),
    Department      VARCHAR(max),
    ReportsTo       VARCHAR(max),
    TerminationCode VARCHAR(max),
    Worker          VARCHAR(max),
    EmployeeStatus  VARCHAR(max)
);

INSERT #Hires
(
    Status,
    Company,       
    PayType,       
    Employee#,    
    Employee,    
    Position,
    HireDate,
    TerminationDate,
    Department,
    ReportsTo,
    TerminationCode,
    Worker,
    EmployeeStatus
)
Select Null as Status,
       D.Supplier_Code as Company,
       A.Pay_Type as PayType, 
       A.Customer_Employee_No as Employee#,
       Concat(B.First_Name, ' ', B.Middle_Name, ' ',  B.Last_Name) as Employee,
       E.Position as Position,
       Case When A.Contract_Worker = 1 THEN FORMAT(C.Contract_Hire_Date, 'MM/dd/yyyy') Else FORMAT(A.Hire_Date, 'MM/dd/yyyy') End as HireDate,
       '' as TerminationDate,
       F.Department_Code as Department,
       Concat(G.First_Name, ' ', G.Middle_Name, ' ',  G.Last_Name) as ReportsTo,
       '' as TerminationCode,
       A.Contract_Worker as Worker,  --0 is Non-Contract, 1 is Contract
       A.Employee_Status as EmployeeStatus
From 
     Personnel_v_Employee as A
Inner Join Plexus_Control_v_Plexus_User as B
     On A.Plexus_User_No = B.Plexus_User_No
Left Outer Join Personnel_v_Employee_Attributes as C
     On A.Plexus_User_No = C.PUN
Left Join Common_v_Supplier as D
     On A.Supplier_Key = D.Supplier_No
Inner Join Common_v_Position as E
     On B.Position_Key = E.Position_Key
Inner Join Common_v_Department as F
     On B.Department_No = F.Department_No
Left Outer Join Plexus_Control_v_Plexus_User as G
     On A.Reports_To = G.Plexus_User_No
     
------ CREATE TERMINATIONS TABLE ------
Create Table #Terminations
(
    Status          VARCHAR(max),
    Company         VARCHAR(max),
    PayType         VARCHAR(max),
    Employee#       INT,
    Employee        VARCHAR(max),
    Position        VARCHAR(max),
    HireDate        VARCHAR(50),
    TerminationDate VARCHAR(max),
    Department      VARCHAR(max),
    ReportsTo       VARCHAR(max),
    TerminationCode VARCHAR(max),
    Worker          VARCHAR(max),
    EmployeeStatus  VARCHAR(max)
);
INSERT #Terminations
(
    Status,
    Company,       
    PayType,       
    Employee#,    
    Employee,    
    Position,
    HireDate,
    TerminationDate,
    Department,
    ReportsTo,
    TerminationCode,
    Worker,
    EmployeeStatus
)
Select 'Terms Only' as Status,
        D.Supplier_Code as Company,
        A.Pay_Type as PayType,
        A.Customer_Employee_No as Employee#,
       Concat(B.First_Name, ' ', B.Middle_Name, ' ',  B.Last_Name) as Employee, 
       E.Position as Position,
       Case When A.Contract_Worker = 1 THEN FORMAT(C.Contract_Hire_Date, 'MM/dd/yyyy') Else FORMAT(A.Hire_Date, 'MM/dd/yyyy') End as Hire_Date,
       FORMAT(H.Termination_Date, 'MM/dd/yyyy') as TerminationDate,
       F.Department_Code as Department,
       Concat(G.First_Name, ' ', G.Middle_Name, ' ',  G.Last_Name) as ReportsTo,
       I.Termination_Code as TerminationCode,
       A.Contract_Worker,  --0 is Non-Contract, 1 is Contract
       A.Employee_Status as EmployeeStatus
From 
     Personnel_v_Employee as A
Inner Join Plexus_Control_v_Plexus_User as B
     On A.Plexus_User_No = B.Plexus_User_No
Left Outer Join Personnel_v_Employee_Attributes as C
     On A.Plexus_User_No = C.PUN
Left Join Common_v_Supplier as D
     On A.Supplier_Key = D.Supplier_No
Inner Join Common_v_Position as E
     On B.Position_Key = E.Position_Key
Inner Join Common_v_Department as F
     On B.Department_No = F.Department_No
Left Outer Join Plexus_Control_v_Plexus_User as G
     On A.Reports_To = G.Plexus_User_No
Left Outer Join Personnel_v_Termination as H
     On B.Plexus_User_No = H.PUN
Left Outer Join Personnel_v_Termination_Code as I
     On H.Termination_Code_Key = I.Termination_Code_Key

------ RETREIVE DATA FROM COMBINED TABLES ------
Select  ISNULL(Max(Q1.Status), 'Hires Only') as Status,
        Q1.Company,       
        Q1.PayType,       
        Q1.Employee#,    
        Q1.Employee,    
        Q1.Position,
        Q1.HireDate,
        Max(Q1.TerminationDate) as TerminationDate,
        Q1.Department,
        Q1.ReportsTo,
        Max(Q1.TerminationCode) as TerminationCode,
        Q1.Worker,
        Q1.EmployeeStatus
From
------ COMBINE NEW HIRES AND TERMINATIONS TABLE ------
(Select * From #Hires as A 
  Where HireDate Between @StartDate And @EndDate
    Union All
Select * From #Terminations as B 
  Where TerminationDate Between @StartDate And @EndDate 
  AND EmployeeStatus = 'Inactive') as Q1
------ FILTERS ------
Where Q1.Department LIKE @Department + '%'
  AND Q1.PayType LIKE @PayType + '%'
  AND ISNULL(Q1.Company, '') LIKE @Company + '%'
  AND Q1.Worker LIKE @Worker + '%'
  AND ISNULL(Q1.Status, 'Hires Only') LIKE @Status +'%'
Group By  Q1.Company,       
          Q1.PayType,       
          Q1.Employee#,    
          Q1.Employee,    
          Q1.Position,
          Q1.HireDate,
          Q1.Department,
          Q1.ReportsTo,
          Q1.Worker,
          Q1.EmployeeStatus
Order By Q1.Employee