------ Displays Employee Attendance Points Rate Chart ------
------ Created by Nisha Verma on 01/29/2019 -----------------
-------------------------------------------------------------

Declare @Text1 varchar(40)
SET   @Text1 = '0 Attendance Points'

Declare @Text2 varchar(40)
SET   @Text2 = '0.5 - 3.0 Attendance Points'

Declare @Text3 varchar(40)
SET   @Text3 = 'Over 3.5 Attendance Points'

Select @Text1 as Attendance_Points,
       ROUND(CASE WHEN cast(Q1.Total_Employees as decimal) > 0 THEN cast(Q3.No_of_Employees as decimal)/cast(Q1.Total_Employees as decimal)
            ELSE 0 END,2)  * 100 as 'Attendance Rate by Points'
From
  (Select Count(Q2.Names) as No_of_Employees
  From
  (Select Sum(Q1.Points) as Total_Points,
         Q1.Employee_Name as Names,
         Q1.Pay_Type as PayType
  From
  (Select A.Points as Points,
          Concat(C.First_Name, ' ', C.Middle_Name, ' ',  C.Last_Name) as Employee_Name,
          FORMAT(A.Point_Date, 'yyyy/MM/dd') AS Date,
          B.Pay_Type as Pay_Type
          From Personnel_v_Point as A, Personnel_v_Employee as B, Plexus_Control_v_Plexus_User as C, Personnel_v_Clockin as D, Personnel_v_Point_Status as E
          Where A.PUN = B.Plexus_User_No
            AND B.Plexus_User_No = C.Plexus_User_No
            AND C.Plexus_User_No = D.Plexus_User_No
            AND A.Point_Status_Key = E.Point_Status_Key
            AND B.Employee_Status = 'Active'
            AND A.Point_Date Between '1/01/2019' AND '1/31/2019'
            Group By  A.Points, C.First_Name, C.Middle_Name, C.Last_Name, A.Point_Date, B.Pay_Type) as Q1
  Group By Q1.Employee_Name, Q1.Pay_Type) as Q2
  Where Q2.Total_Points = 0) as Q3,  -- This is a subquery to caluclate No. of Employees with 0 attendance points
  (Select Sum(Q1.Points) as Total_Points,
         Q1.Employee_Name as Names,
         Q1.Pay_Type as PayType
  From
  (Select A.Points as Points,
          Concat(C.First_Name, ' ', C.Middle_Name, ' ',  C.Last_Name) as Employee_Name,
          FORMAT(A.Creation_Date, 'yyyy/MM/dd') AS Date,
          B.Pay_Type as Pay_Type
          From Personnel_v_Point as A, Personnel_v_Employee as B, Plexus_Control_v_Plexus_User as C, Personnel_v_Clockin as D, Personnel_v_Point_Status as E
          Where A.PUN = B.Plexus_User_No
            AND B.Plexus_User_No = C.Plexus_User_No
            AND C.Plexus_User_No = D.Plexus_User_No
            AND A.Point_Status_Key = E.Point_Status_Key
            AND B.Employee_Status = 'Active'
            AND A.Creation_Date Between '1/01/2019' AND '1/31/2019'
            Group By  A.Points, C.First_Name, C.Middle_Name, C.Last_Name, A.Creation_Date, B.Pay_Type) as Q1
  Group By Q1.Employee_Name, Q1.Pay_Type) as Q2, -- This is a subquery to caluclate Total Points for each employee
  (Select Count(Q2.Names) as Total_Employees
   From
  (Select Sum(Q1.Points) as Total_Points,
         Q1.Employee_Name as Names,
         Q1.Pay_Type as PayType
   From
  (Select A.Points as Points,
          Concat(C.First_Name, ' ', C.Middle_Name, ' ',  C.Last_Name) as Employee_Name,
          FORMAT(A.Creation_Date, 'yyyy/MM/dd') AS Date,
          B.Pay_Type as Pay_Type
          From Personnel_v_Point as A, Personnel_v_Employee as B, Plexus_Control_v_Plexus_User as C, Personnel_v_Clockin as D, Personnel_v_Point_Status as E
          Where A.PUN = B.Plexus_User_No
            AND B.Plexus_User_No = C.Plexus_User_No
            AND C.Plexus_User_No = D.Plexus_User_No
            AND A.Point_Status_Key = E.Point_Status_Key
            AND B.Employee_Status = 'Active'
            AND A.Creation_Date Between '1/01/2019' AND '1/31/2019'
            Group By  A.Points, C.First_Name, C.Middle_Name, C.Last_Name, A.Creation_Date, B.Pay_Type) as Q1
  Group By Q1.Employee_Name, Q1.Pay_Type) as Q2) as Q1 -- This is a subquery to caluclate Total Employees with active attendance point
Where Total_Points = 0

Union -- This will unite Records with 0 attendance points to records with attendance points between 0.5 to 3

Select @Text2 as Attendance_Points,
       ROUND(CASE WHEN cast(Q1.Total_Employees as decimal) > 0 THEN cast(Q3.No_of_Employees as decimal)/cast(Q1.Total_Employees as decimal)
            ELSE 0 END,2)  * 100 as 'Attendance Rate by Points'
From
  (Select Count(Q2.Names) as No_of_Employees
  From
  (Select Sum(Q1.Points) as Total_Points,
         Q1.Employee_Name as Names,
         Q1.Pay_Type as PayType
  From
  (Select A.Points as Points,
          Concat(C.First_Name, ' ', C.Middle_Name, ' ',  C.Last_Name) as Employee_Name,
          FORMAT(A.Point_Date, 'yyyy/MM/dd') AS Date,
          B.Pay_Type as Pay_Type
          From Personnel_v_Point as A, Personnel_v_Employee as B, Plexus_Control_v_Plexus_User as C, Personnel_v_Clockin as D, Personnel_v_Point_Status as E
          Where A.PUN = B.Plexus_User_No
            AND B.Plexus_User_No = C.Plexus_User_No
            AND C.Plexus_User_No = D.Plexus_User_No
            AND A.Point_Status_Key = E.Point_Status_Key
            AND B.Employee_Status = 'Active'
           AND A.Point_Date Between '1/01/2019' AND '1/31/2019'
            Group By  A.Points, C.First_Name, C.Middle_Name, C.Last_Name, A.Point_Date, B.Pay_Type) as Q1
  Group By Q1.Employee_Name, Q1.Pay_Type) as Q2
  Where Q2.Total_Points Between 0.5 AND 3.4) as Q3,  -- This is a subquery to caluclate No. of Employees with 0.5 - 3 attendance points
  (Select Sum(Q1.Points) as Total_Points,
         Q1.Employee_Name as Names,
         Q1.Pay_Type as PayType
  From
  (Select A.Points as Points,
          Concat(C.First_Name, ' ', C.Middle_Name, ' ',  C.Last_Name) as Employee_Name,
          FORMAT(A.Creation_Date, 'yyyy/MM/dd') AS Date,
          B.Pay_Type as Pay_Type
          From Personnel_v_Point as A, Personnel_v_Employee as B, Plexus_Control_v_Plexus_User as C, Personnel_v_Clockin as D, Personnel_v_Point_Status as E
          Where A.PUN = B.Plexus_User_No
            AND B.Plexus_User_No = C.Plexus_User_No
            AND C.Plexus_User_No = D.Plexus_User_No
            AND A.Point_Status_Key = E.Point_Status_Key
            AND B.Employee_Status = 'Active'
            AND A.Creation_Date Between '1/01/2019' AND '1/31/2019'
            Group By  A.Points, C.First_Name, C.Middle_Name, C.Last_Name, A.Creation_Date, B.Pay_Type) as Q1
  Group By Q1.Employee_Name, Q1.Pay_Type) as Q2, -- This is a subquery to caluclate Total Points for each employee
  (Select Count(Q2.Names) as Total_Employees
   From
  (Select Sum(Q1.Points) as Total_Points,
         Q1.Employee_Name as Names,
         Q1.Pay_Type as PayType
   From
  (Select A.Points as Points,
          Concat(C.First_Name, ' ', C.Middle_Name, ' ',  C.Last_Name) as Employee_Name,
          FORMAT(A.Creation_Date, 'yyyy/MM/dd') AS Date,
          B.Pay_Type as Pay_Type
          From Personnel_v_Point as A, Personnel_v_Employee as B, Plexus_Control_v_Plexus_User as C, Personnel_v_Clockin as D, Personnel_v_Point_Status as E
          Where A.PUN = B.Plexus_User_No
            AND B.Plexus_User_No = C.Plexus_User_No
            AND C.Plexus_User_No = D.Plexus_User_No
            AND A.Point_Status_Key = E.Point_Status_Key
            AND B.Employee_Status = 'Active'
            AND A.Creation_Date Between '1/01/2019' AND '1/31/2019'
            Group By  A.Points, C.First_Name, C.Middle_Name, C.Last_Name, A.Creation_Date, B.Pay_Type) as Q1
  Group By Q1.Employee_Name, Q1.Pay_Type) as Q2) as Q1 -- This is a subquery to caluclate Total Employees with active attendance point
Where Total_Points Between 0.5 AND 3.4

Union -- This will unite Records with 0 attendance points and records with attendance points between 0.5 - 3 to records with >= 3.5 attendance points

Select @Text3 as Attendance_Points,
       ROUND(CASE WHEN cast(Q1.Total_Employees as decimal) > 0 THEN cast(Q3.No_of_Employees as decimal)/cast(Q1.Total_Employees as decimal)
            ELSE 0 END,2)  * 100 as 'Attendance Rate by Points'
From
  (Select Count(Q2.Names) as No_of_Employees
  From
  (Select Sum(Q1.Points) as Total_Points,
         Q1.Employee_Name as Names,
         Q1.Pay_Type as PayType
  From
  (Select A.Points as Points,
          Concat(C.First_Name, ' ', C.Middle_Name, ' ',  C.Last_Name) as Employee_Name,
          FORMAT(A.Point_Date, 'yyyy/MM/dd') AS Date,
          B.Pay_Type as Pay_Type
          From Personnel_v_Point as A, Personnel_v_Employee as B, Plexus_Control_v_Plexus_User as C, Personnel_v_Clockin as D, Personnel_v_Point_Status as E
          Where A.PUN = B.Plexus_User_No
            AND B.Plexus_User_No = C.Plexus_User_No
            AND C.Plexus_User_No = D.Plexus_User_No
            AND A.Point_Status_Key = E.Point_Status_Key
            AND B.Employee_Status = 'Active'
            AND A.Point_Date Between '1/01/2019' AND '1/31/2019'
            Group By  A.Points, C.First_Name, C.Middle_Name, C.Last_Name, A.Point_Date, B.Pay_Type) as Q1
  Group By Q1.Employee_Name, Q1.Pay_Type) as Q2
  Where Q2.Total_Points >= 3.5) as Q3,  -- This is a subquery to caluclate No. of Employees with 0 attendance points
  (Select Sum(Q1.Points) as Total_Points,
         Q1.Employee_Name as Names,
         Q1.Pay_Type as PayType
  From
  (Select A.Points as Points,
          Concat(C.First_Name, ' ', C.Middle_Name, ' ',  C.Last_Name) as Employee_Name,
          FORMAT(A.Creation_Date, 'yyyy/MM/dd') AS Date,
          B.Pay_Type as Pay_Type
          From Personnel_v_Point as A, Personnel_v_Employee as B, Plexus_Control_v_Plexus_User as C, Personnel_v_Clockin as D, Personnel_v_Point_Status as E
          Where A.PUN = B.Plexus_User_No
            AND B.Plexus_User_No = C.Plexus_User_No
            AND C.Plexus_User_No = D.Plexus_User_No
            AND A.Point_Status_Key = E.Point_Status_Key
            AND B.Employee_Status = 'Active'
            AND A.Creation_Date Between '1/01/2019' AND '1/31/2019'
            Group By  A.Points, C.First_Name, C.Middle_Name, C.Last_Name, A.Creation_Date, B.Pay_Type) as Q1
  Group By Q1.Employee_Name, Q1.Pay_Type) as Q2, -- This is a subquery to caluclate Total Points for each employee
  (Select Count(Q2.Names) as Total_Employees
   From
  (Select Sum(Q1.Points) as Total_Points,
         Q1.Employee_Name as Names,
         Q1.Pay_Type as PayType
   From
  (Select A.Points as Points,
          Concat(C.First_Name, ' ', C.Middle_Name, ' ',  C.Last_Name) as Employee_Name,
          FORMAT(A.Creation_Date, 'yyyy/MM/dd') AS Date,
          B.Pay_Type as Pay_Type
          From Personnel_v_Point as A, Personnel_v_Employee as B, Plexus_Control_v_Plexus_User as C, Personnel_v_Clockin as D, Personnel_v_Point_Status as E
          Where A.PUN = B.Plexus_User_No
            AND B.Plexus_User_No = C.Plexus_User_No
            AND C.Plexus_User_No = D.Plexus_User_No
            AND A.Point_Status_Key = E.Point_Status_Key
            AND B.Employee_Status = 'Active'
            AND A.Creation_Date Between '1/01/2019' AND '1/31/2019'
            Group By  A.Points, C.First_Name, C.Middle_Name, C.Last_Name, A.Creation_Date, B.Pay_Type) as Q1
  Group By Q1.Employee_Name, Q1.Pay_Type) as Q2) as Q1 -- This is a subquery to caluclate Total Employees with active attendance point
Where Total_Points >= 3.5