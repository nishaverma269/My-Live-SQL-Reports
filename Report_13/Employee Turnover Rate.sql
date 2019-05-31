-------------------------------------------------------------
------------ Display Employee Turnover Rate -----------------
--------- Created by Nisha Verma on 05/31/2019 --------------
-------------------------------------------------------------

------ CREATE TABLE ------
Create Table #Summary
(
    PayType         VARCHAR(max),
    PreviousMonth   INT,
    Hire            INT,
    Quit            INT,
    Resign          INT
);

INSERT #Summary
(
    PayType,
    PreviousMonth,
    Hire,
    Quit,
    Resign
)
Select 'KJA Hourly' as PayType,
 ( Select IsNull(Count(*), 0) as PreviousMonth From (
  
  Select A.Customer_Employee_No as Employee#,
         Concat(B.First_Name, ' ', B.Middle_Name, ' ',  B.Last_Name) as Employee,
         Case When A.Contract_Worker = 1 THEN FORMAT(C.Contract_Hire_Date, 'yyyy/MM') Else FORMAT(A.Hire_Date, 'yyyy/MM') End as HireDate,
         A.Employee_Status as EmployeeStatus
  From 
       Personnel_v_Employee as A
  Inner Join Plexus_Control_v_Plexus_User as B
       On A.Plexus_User_No = B.Plexus_User_No    
  Left Outer Join Personnel_v_Employee_Attributes as C
       On A.Plexus_User_No = C.PUN
  Where A.Employee_Status = 'Active'   
    AND  A.Pay_Type = 'Hourly'
    AND A.Contract_Worker != 1
    AND (Case When A.Contract_Worker = 1 THEN FORMAT(C.Contract_Hire_Date, 'yyyyMM') Else FORMAT(A.Hire_Date, 'yyyyMM') END) < @Month
  ) as Q1 ) as PreviousMonth,
  
   ( Select IsNull(Count(*), 0) as Hire From (
  
  Select A.Customer_Employee_No as Employee#,
         Concat(B.First_Name, ' ', B.Middle_Name, ' ',  B.Last_Name) as Employee,
         Case When A.Contract_Worker = 1 THEN FORMAT(C.Contract_Hire_Date, 'yyyy/MM') Else FORMAT(A.Hire_Date, 'yyyy/MM') End as HireDate,
         A.Employee_Status as EmployeeStatus
  From 
       Personnel_v_Employee as A
  Inner Join Plexus_Control_v_Plexus_User as B
       On A.Plexus_User_No = B.Plexus_User_No    
  Left Outer Join Personnel_v_Employee_Attributes as C
       On A.Plexus_User_No = C.PUN
  Where A.Employee_Status = 'Active'   
    AND  A.Pay_Type = 'Hourly'
    AND A.Contract_Worker != 1
    AND (Case When A.Contract_Worker = 1 THEN FORMAT(C.Contract_Hire_Date, 'yyyyMM') Else FORMAT(A.Hire_Date, 'yyyyMM') END) = @Month
  ) as Q1 ) as Hire,
  
   ( Select  IsNull(Count(*), 0) as Quit From (
  
  Select  A.Pay_Type,
          Concat(D.First_Name, ' ', D.Middle_Name, ' ',  D.Last_Name) as Employee,
          C.Termination_Code as TerminationCode 
  From 
       Personnel_v_Employee as A
  Left Outer Join Personnel_v_Termination as B
       On A.Plexus_User_No = B.PUN
  Left Outer Join Personnel_v_Termination_Code as C
       On B.Termination_Code_Key = C.Termination_Code_Key
  Inner Join Plexus_Control_v_Plexus_User as D
       On A.Plexus_User_No = D.Plexus_User_No     
  Where Format(B.Termination_Date, 'yyyyMM') = @Month
    AND A.Employee_Status = 'Inactive'
    AND (C.Termination_Code = 'Quit')
    AND A.Pay_Type = 'Hourly'
    AND A.Contract_Worker != 1
  
  ) as Q1
  Group By Q1.TerminationCode ) as Quit,
  
  ( Select  IsNull(Count(*), 0) as Resignation From (
  
  Select  A.Pay_Type,
          Concat(D.First_Name, ' ', D.Middle_Name, ' ',  D.Last_Name) as Employee,
          C.Termination_Code as TerminationCode 
  From 
       Personnel_v_Employee as A
  Left Outer Join Personnel_v_Termination as B
       On A.Plexus_User_No = B.PUN
  Left Outer Join Personnel_v_Termination_Code as C
       On B.Termination_Code_Key = C.Termination_Code_Key
  Inner Join Plexus_Control_v_Plexus_User as D
       On A.Plexus_User_No = D.Plexus_User_No     
  Where Format(B.Termination_Date, 'yyyyMM') = @Month
    AND A.Employee_Status = 'Inactive'
    AND (C.Termination_Code = 'Resignation')
    AND A.Pay_Type = 'Hourly'
    AND A.Contract_Worker != 1
  
  ) as Q1
  Group By Q1.TerminationCode ) as Resign

------- Combining Queries ------------
Union All

Select 'Temp Hourly' as PayType,
 ( Select IsNull(Count(*), 0) as PreviousMonth From (
  
  Select A.Customer_Employee_No as Employee#,
         Concat(B.First_Name, ' ', B.Middle_Name, ' ',  B.Last_Name) as Employee,
         Case When A.Contract_Worker = 1 THEN FORMAT(C.Contract_Hire_Date, 'yyyy/MM') Else FORMAT(A.Hire_Date, 'yyyy/MM') End as HireDate,
         A.Employee_Status as EmployeeStatus
  From 
       Personnel_v_Employee as A
  Inner Join Plexus_Control_v_Plexus_User as B
       On A.Plexus_User_No = B.Plexus_User_No    
  Left Outer Join Personnel_v_Employee_Attributes as C
       On A.Plexus_User_No = C.PUN
  Where A.Employee_Status = 'Active'   
    AND  A.Pay_Type = 'Hourly'
    AND A.Contract_Worker = 1
    AND (Case When A.Contract_Worker = 1 THEN FORMAT(C.Contract_Hire_Date, 'yyyyMM') Else FORMAT(A.Hire_Date, 'yyyyMM') END) < @Month
  ) as Q1 ) as PreviousMonth,
  
   ( Select IsNull(Count(*), 0) as Hire From (
  
  Select A.Customer_Employee_No as Employee#,
         Concat(B.First_Name, ' ', B.Middle_Name, ' ',  B.Last_Name) as Employee,
         Case When A.Contract_Worker = 1 THEN FORMAT(C.Contract_Hire_Date, 'yyyy/MM') Else FORMAT(A.Hire_Date, 'yyyy/MM') End as HireDate,
         A.Employee_Status as EmployeeStatus
  From 
       Personnel_v_Employee as A
  Inner Join Plexus_Control_v_Plexus_User as B
       On A.Plexus_User_No = B.Plexus_User_No    
  Left Outer Join Personnel_v_Employee_Attributes as C
       On A.Plexus_User_No = C.PUN
  Where A.Employee_Status = 'Active'   
    AND  A.Pay_Type = 'Hourly'
    AND A.Contract_Worker = 1
    AND (Case When A.Contract_Worker = 1 THEN FORMAT(C.Contract_Hire_Date, 'yyyyMM') Else FORMAT(A.Hire_Date, 'yyyyMM') END) = @Month
  ) as Q1 ) as Hire,
  
   ( Select  IsNull(Count(*), 0) as Quit From (
  
  Select  A.Pay_Type,
          Concat(D.First_Name, ' ', D.Middle_Name, ' ',  D.Last_Name) as Employee,
          C.Termination_Code as TerminationCode 
  From 
       Personnel_v_Employee as A
  Left Outer Join Personnel_v_Termination as B
       On A.Plexus_User_No = B.PUN
  Left Outer Join Personnel_v_Termination_Code as C
       On B.Termination_Code_Key = C.Termination_Code_Key
  Inner Join Plexus_Control_v_Plexus_User as D
       On A.Plexus_User_No = D.Plexus_User_No     
  Where Format(B.Termination_Date, 'yyyyMM') = @Month
    AND A.Employee_Status = 'Inactive'
    AND (C.Termination_Code = 'Quit')
    AND A.Pay_Type = 'Hourly'
    AND A.Contract_Worker = 1
  
  ) as Q1
  Group By Q1.TerminationCode ) as Quit,
  
  ( Select  IsNull(Count(*), 0) as Resignation From (
  
  Select  A.Pay_Type,
          Concat(D.First_Name, ' ', D.Middle_Name, ' ',  D.Last_Name) as Employee,
          C.Termination_Code as TerminationCode 
  From 
       Personnel_v_Employee as A
  Left Outer Join Personnel_v_Termination as B
       On A.Plexus_User_No = B.PUN
  Left Outer Join Personnel_v_Termination_Code as C
       On B.Termination_Code_Key = C.Termination_Code_Key
  Inner Join Plexus_Control_v_Plexus_User as D
       On A.Plexus_User_No = D.Plexus_User_No     
  Where Format(B.Termination_Date, 'yyyyMM') = @Month
    AND A.Employee_Status = 'Inactive'
    AND (C.Termination_Code = 'Resignation')
    AND A.Pay_Type = 'Hourly'
    AND A.Contract_Worker = 1
  
  ) as Q1
  Group By Q1.TerminationCode ) as Resign
  
------- Combining Queries ------------
Union All

Select 'Hourly Total' as PayType,
 ( Select IsNull(Count(*), 0) as PreviousMonth From (
  
  Select A.Customer_Employee_No as Employee#,
         Concat(B.First_Name, ' ', B.Middle_Name, ' ',  B.Last_Name) as Employee,
         Case When A.Contract_Worker = 1 THEN FORMAT(C.Contract_Hire_Date, 'yyyy/MM') Else FORMAT(A.Hire_Date, 'yyyy/MM') End as HireDate,
         A.Employee_Status as EmployeeStatus
  From 
       Personnel_v_Employee as A
  Inner Join Plexus_Control_v_Plexus_User as B
       On A.Plexus_User_No = B.Plexus_User_No    
  Left Outer Join Personnel_v_Employee_Attributes as C
       On A.Plexus_User_No = C.PUN
  Where A.Employee_Status = 'Active'   
    AND  A.Pay_Type = 'Hourly'
    AND (Case When A.Contract_Worker = 1 THEN FORMAT(C.Contract_Hire_Date, 'yyyyMM') Else FORMAT(A.Hire_Date, 'yyyyMM') END) < @Month
  ) as Q1 ) as PreviousMonth,
  
  ( Select IsNull(Count(*), 0) as Hire From (
  
  Select A.Customer_Employee_No as Employee#,
         Concat(B.First_Name, ' ', B.Middle_Name, ' ',  B.Last_Name) as Employee,
         Case When A.Contract_Worker = 1 THEN FORMAT(C.Contract_Hire_Date, 'yyyy/MM') Else FORMAT(A.Hire_Date, 'yyyy/MM') End as HireDate,
         A.Employee_Status as EmployeeStatus
  From 
       Personnel_v_Employee as A
  Inner Join Plexus_Control_v_Plexus_User as B
       On A.Plexus_User_No = B.Plexus_User_No    
  Left Outer Join Personnel_v_Employee_Attributes as C
       On A.Plexus_User_No = C.PUN
  Where A.Employee_Status = 'Active'   
    AND  A.Pay_Type = 'Hourly'
    AND (Case When A.Contract_Worker = 1 THEN FORMAT(C.Contract_Hire_Date, 'yyyyMM') Else FORMAT(A.Hire_Date, 'yyyyMM') END) = @Month
  ) as Q1 ) as Hire,
  
   ( Select  IsNull(Count(*), 0) as Quit From (
  
  Select  A.Pay_Type,
          Concat(D.First_Name, ' ', D.Middle_Name, ' ',  D.Last_Name) as Employee,
          C.Termination_Code as TerminationCode 
  From 
       Personnel_v_Employee as A
  Left Outer Join Personnel_v_Termination as B
       On A.Plexus_User_No = B.PUN
  Left Outer Join Personnel_v_Termination_Code as C
       On B.Termination_Code_Key = C.Termination_Code_Key
  Inner Join Plexus_Control_v_Plexus_User as D
       On A.Plexus_User_No = D.Plexus_User_No     
       
  Where Format(B.Termination_Date, 'yyyyMM') = @Month
    AND A.Employee_Status = 'Inactive'
    AND (C.Termination_Code = 'Quit')
    AND A.Pay_Type = 'Hourly'
  
  ) as Q1
  Group By Q1.TerminationCode ) as Quit,
  
   ( Select  IsNull(Count(*), 0) as Resignation From (
  
  Select  A.Pay_Type,
          Concat(D.First_Name, ' ', D.Middle_Name, ' ',  D.Last_Name) as Employee,
          C.Termination_Code as TerminationCode 
  From 
       Personnel_v_Employee as A
  Left Outer Join Personnel_v_Termination as B
       On A.Plexus_User_No = B.PUN
  Left Outer Join Personnel_v_Termination_Code as C
       On B.Termination_Code_Key = C.Termination_Code_Key
  Inner Join Plexus_Control_v_Plexus_User as D
       On A.Plexus_User_No = D.Plexus_User_No     
       
  Where Format(B.Termination_Date, 'yyyyMM') = @Month
    AND A.Employee_Status = 'Inactive'
    AND (C.Termination_Code = 'Resignation')
    AND A.Pay_Type = 'Hourly'
  
  ) as Q1
  Group By Q1.TerminationCode ) as Resign
  
------- Combining Queries ------------
Union All

Select 'Salaried' as PayType,
 ( Select IsNull(Count(*), 0) as PreviousMonth From (
  
  Select A.Customer_Employee_No as Employee#,
         Concat(B.First_Name, ' ', B.Middle_Name, ' ',  B.Last_Name) as Employee,
         Case When A.Contract_Worker = 1 THEN FORMAT(C.Contract_Hire_Date, 'yyyy/MM') Else FORMAT(A.Hire_Date, 'yyyy/MM') End as HireDate,
         A.Employee_Status as EmployeeStatus
  From 
       Personnel_v_Employee as A
  Inner Join Plexus_Control_v_Plexus_User as B
       On A.Plexus_User_No = B.Plexus_User_No    
  Left Outer Join Personnel_v_Employee_Attributes as C
       On A.Plexus_User_No = C.PUN
  Where A.Employee_Status = 'Active'   
    AND  A.Pay_Type = 'Salary'
    AND (Case When A.Contract_Worker = 1 THEN FORMAT(C.Contract_Hire_Date, 'yyyyMM') Else FORMAT(A.Hire_Date, 'yyyyMM') END) < @Month --Format(GetDate(), 'yyyy/MM')
  ) as Q1 ) as PreviousMonth,

 ( Select IsNull(Count(*), 0) as Hire From (
  
  Select A.Customer_Employee_No as Employee#,
         Concat(B.First_Name, ' ', B.Middle_Name, ' ',  B.Last_Name) as Employee,
         Case When A.Contract_Worker = 1 THEN FORMAT(C.Contract_Hire_Date, 'yyyy/MM') Else FORMAT(A.Hire_Date, 'yyyy/MM') End as HireDate,
         A.Employee_Status as EmployeeStatus
  From 
       Personnel_v_Employee as A
  Inner Join Plexus_Control_v_Plexus_User as B
       On A.Plexus_User_No = B.Plexus_User_No    
  Left Outer Join Personnel_v_Employee_Attributes as C
       On A.Plexus_User_No = C.PUN
  Where A.Employee_Status = 'Active'   
    AND  A.Pay_Type = 'Salary'
    AND (Case When A.Contract_Worker = 1 THEN FORMAT(C.Contract_Hire_Date, 'yyyyMM') Else FORMAT(A.Hire_Date, 'yyyyMM') END) = @Month --Format(GetDate(), 'yyyy/MM')
  ) as Q1 ) as Hire,

 ( Select  IsNull(Count(*), 0) as Quit From (
  
  Select  A.Pay_Type,
          Concat(D.First_Name, ' ', D.Middle_Name, ' ',  D.Last_Name) as Employee,
          C.Termination_Code as TerminationCode 
  From 
       Personnel_v_Employee as A
  Left Outer Join Personnel_v_Termination as B
       On A.Plexus_User_No = B.PUN
  Left Outer Join Personnel_v_Termination_Code as C
       On B.Termination_Code_Key = C.Termination_Code_Key
  Inner Join Plexus_Control_v_Plexus_User as D
       On A.Plexus_User_No = D.Plexus_User_No     
       
  Where Format(B.Termination_Date, 'yyyyMM') = @Month
    AND A.Employee_Status = 'Inactive'
    AND (C.Termination_Code = 'Quit')
    AND A.Pay_Type = 'Salary'
  
  ) as Q1
  Group By Q1.TerminationCode ) as Quit,

 ( Select  IsNull(Count(*), 0) as Resignation From (
  
  Select  A.Pay_Type,
          Concat(D.First_Name, ' ', D.Middle_Name, ' ',  D.Last_Name) as Employee,
          C.Termination_Code as TerminationCode 
  From 
       Personnel_v_Employee as A
  Left Outer Join Personnel_v_Termination as B
       On A.Plexus_User_No = B.PUN
  Left Outer Join Personnel_v_Termination_Code as C
       On B.Termination_Code_Key = C.Termination_Code_Key
  Inner Join Plexus_Control_v_Plexus_User as D
       On A.Plexus_User_No = D.Plexus_User_No     
       
  Where Format(B.Termination_Date, 'yyyyMM') =  @Month
    AND A.Employee_Status = 'Inactive'
    AND (C.Termination_Code = 'Resignation')
    AND A.Pay_Type = 'Salary'
  
  ) as Q1
  Group By Q1.TerminationCode ) as Resign
  
---- RETREIVE VALUES ----
--Select * From #Summary as A

---- Calculate Turnover Rate -----
Select A.PayType, 
       Case When (IsNull(A.PreviousMonth, 0) +  IsNull(A.Hire, 0)) > 0 Then
         Cast((IsNull(A.Quit, 0) +  IsNull(A.Resign, 0)) as Decimal) / Cast((IsNull(A.PreviousMonth, 0) +  IsNull(A.Hire, 0)) as Decimal)
         Else 0 End as Rate
From #Summary as A