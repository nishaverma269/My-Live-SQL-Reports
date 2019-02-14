------ Displays Employee Attendance Points Rate ------
------ Created by Nisha Verma on 01/23/2019 -----------------
-------------------------------------------------------------

Declare @Text1 varchar(40)
SET   @Text1 = '0 Attendance Points'

Declare @Text2 varchar(40)
SET   @Text2 = '0.5 - 3.0 Attendance Points'

Declare @Text3 varchar(40)
SET   @Text3 = 'Over 3.5 Attendance Points'

Select @Text1 as Attendance_Points,
       ROUND(CASE WHEN cast(SQ3.Total_Employees as decimal) > 0 THEN cast(SQ2.No_of_Employees as decimal)/cast(SQ3.Total_Employees as decimal)
            ELSE 0 END,2)  as 'Attendance Rate by Points',
       SQ2.No_of_Employees,
       SQ1.Names,
       SQ1.Pay_Type
From
   -- Sub query to get total points, employee names, and pay type
   (Select Sum(Q1.Points) as Total_Points,
             Q1.Employee_Name as Names,
             Q1.Pay_Type as Pay_Type
    From
      (Select Concat(B.Last_Name, ', ', B.First_Name, ' ',  B.Middle_Name) as Employee_Name,
              Format(A.Point_Date, 'yyyy/MM/dd') as Point_Date, 
              A.Points as Points,
              C.Pay_Type as Pay_Type
      From Personnel_v_Point as A, Plexus_Control_v_Plexus_User as B, Personnel_v_Employee as C
      Where A.PUN = B.Plexus_User_No
        AND B.Plexus_User_No = C.Plexus_User_No
        AND A.Point_Status_Key = 2
        AND B.Active = -1
        AND C.Pay_Type like @paytype + '%'
        AND A.Point_Date Between @StartDate AND @EndDate-1) as Q1
    Group By Q1.Employee_Name, Q1.Pay_Type) as SQ1,
   -- Sub query to count total number of employees with 0.5 - 3.0 attendance points
   (Select Count(*) as No_of_Employees
   From
    (Select Sum(Q1.Points) as Total_Points,
             Q1.Employee_Name as Names,
             Q1.Pay_Type as PayType
    From
      (Select Concat(B.Last_Name, ', ', B.First_Name, ' ',  B.Middle_Name) as Employee_Name,
              Format(A.Point_Date, 'yyyy/MM/dd') as Point_Date, 
              A.Points as Points,
              C.Pay_Type as Pay_Type
      From Personnel_v_Point as A, Plexus_Control_v_Plexus_User as B, Personnel_v_Employee as C
      Where A.PUN = B.Plexus_User_No
        AND B.Plexus_User_No = C.Plexus_User_No
        AND A.Point_Status_Key = 2
        AND B.Active = -1
        AND C.Pay_Type like @paytype + '%'
        AND A.Point_Date Between @StartDate AND @EndDate-1) as Q1
    Group By Q1.Employee_Name, Q1.Pay_Type) as Q2
  Where Q2.Total_Points <= 0) as SQ2,
   -- Sub query to count total number of employees
  (Select Count(*) as Total_Employees  
  From
    (Select Sum(Q1.Points) as Total_Points,
             Q1.Employee_Name as Names,
             Q1.Pay_Type as PayType
    From
      (Select Concat(B.Last_Name, ', ', B.First_Name, ' ',  B.Middle_Name) as Employee_Name,
              Format(A.Point_Date, 'yyyy/MM/dd') as Point_Date, 
              A.Points as Points,
              C.Pay_Type as Pay_Type
      From Personnel_v_Point as A, Plexus_Control_v_Plexus_User as B, Personnel_v_Employee as C
      Where A.PUN = B.Plexus_User_No
        AND B.Plexus_User_No = C.Plexus_User_No
        AND A.Point_Status_Key = 2
        AND B.Active = -1
        AND C.Pay_Type like @paytype + '%'
        AND A.Point_Date Between @StartDate AND @EndDate-1) as Q1
    Group By Q1.Employee_Name, Q1.Pay_Type) as Q2) as SQ3
Where SQ1.Total_Points <= 0

Union -- This will unite Records with 0 attendance points to records with attendance points between 0.5 to 3

Select @Text2 as Attendance_Points,
       ROUND(CASE WHEN cast(SQ3.Total_Employees as decimal) > 0 THEN cast(SQ2.No_of_Employees as decimal)/cast(SQ3.Total_Employees as decimal)
            ELSE 0 END,2)  as 'Attendance Rate by Points',
       SQ2.No_of_Employees,
       SQ1.Names,
       SQ1.Pay_Type
From
   -- Sub query to get total points, employee names, and pay type
   (Select Sum(Q1.Points) as Total_Points,
             Q1.Employee_Name as Names,
             Q1.Pay_Type as Pay_Type
    From
      (Select Concat(B.Last_Name, ', ', B.First_Name, ' ',  B.Middle_Name) as Employee_Name,
              Format(A.Point_Date, 'yyyy/MM/dd') as Point_Date, 
              A.Points as Points,
              C.Pay_Type as Pay_Type
      From Personnel_v_Point as A, Plexus_Control_v_Plexus_User as B, Personnel_v_Employee as C
      Where A.PUN = B.Plexus_User_No
        AND B.Plexus_User_No = C.Plexus_User_No
        AND A.Point_Status_Key = 2
        AND B.Active = -1
        AND C.Pay_Type like @paytype + '%'
        AND A.Point_Date Between @StartDate AND @EndDate-1) as Q1
    Group By Q1.Employee_Name, Q1.Pay_Type) as SQ1,
   -- Sub query to count total number of employees with 0.5 - 3.0 attendance points
   (Select Count(*) as No_of_Employees
   From
    (Select Sum(Q1.Points) as Total_Points,
             Q1.Employee_Name as Names,
             Q1.Pay_Type as PayType
    From
      (Select Concat(B.Last_Name, ', ', B.First_Name, ' ',  B.Middle_Name) as Employee_Name,
              Format(A.Point_Date, 'yyyy/MM/dd') as Point_Date, 
              A.Points as Points,
              C.Pay_Type as Pay_Type
      From Personnel_v_Point as A, Plexus_Control_v_Plexus_User as B, Personnel_v_Employee as C
      Where A.PUN = B.Plexus_User_No
        AND B.Plexus_User_No = C.Plexus_User_No
        AND A.Point_Status_Key = 2
        AND B.Active = -1
        AND C.Pay_Type like @paytype + '%'
        AND A.Point_Date Between @StartDate AND @EndDate-1) as Q1
    Group By Q1.Employee_Name, Q1.Pay_Type) as Q2
  Where Q2.Total_Points Between 0.5 AND 3.0) as SQ2,
   -- Sub query to count total number of employees
  (Select Count(*) as Total_Employees  
  From
    (Select Sum(Q1.Points) as Total_Points,
             Q1.Employee_Name as Names,
             Q1.Pay_Type as PayType
    From
      (Select Concat(B.Last_Name, ', ', B.First_Name, ' ',  B.Middle_Name) as Employee_Name,
              Format(A.Point_Date, 'yyyy/MM/dd') as Point_Date, 
              A.Points as Points,
              C.Pay_Type as Pay_Type
      From Personnel_v_Point as A, Plexus_Control_v_Plexus_User as B, Personnel_v_Employee as C
      Where A.PUN = B.Plexus_User_No
        AND B.Plexus_User_No = C.Plexus_User_No
        AND A.Point_Status_Key = 2
        AND B.Active = -1
        AND C.Pay_Type like @paytype + '%'
        AND A.Point_Date Between @StartDate AND @EndDate-1) as Q1
    Group By Q1.Employee_Name, Q1.Pay_Type) as Q2) as SQ3
Where SQ1.Total_Points Between 0.5 AND 3.0

Union -- This will unite Records with 0 attendance points and records with attendance points between 0.5 - 3 to records with >= 3.5 attendance points

Select @Text3 as Attendance_Points,
       ROUND(CASE WHEN cast(SQ3.Total_Employees as decimal) > 0 THEN cast(SQ2.No_of_Employees as decimal)/cast(SQ3.Total_Employees as decimal)
            ELSE 0 END,2)  as 'Attendance Rate by Points',
       SQ2.No_of_Employees,
       SQ1.Names,
       SQ1.Pay_Type
From
   -- Sub query to get total points, employee names, and pay type
   (Select Sum(Q1.Points) as Total_Points,
             Q1.Employee_Name as Names,
             Q1.Pay_Type as Pay_Type
    From
      (Select Concat(B.Last_Name, ', ', B.First_Name, ' ',  B.Middle_Name) as Employee_Name,
              Format(A.Point_Date, 'yyyy/MM/dd') as Point_Date, 
              A.Points as Points,
              C.Pay_Type as Pay_Type
      From Personnel_v_Point as A, Plexus_Control_v_Plexus_User as B, Personnel_v_Employee as C
      Where A.PUN = B.Plexus_User_No
        AND B.Plexus_User_No = C.Plexus_User_No
        AND A.Point_Status_Key = 2
        AND B.Active = -1
        AND C.Pay_Type like @paytype + '%'
        AND A.Point_Date Between @StartDate AND @EndDate-1) as Q1
    Group By Q1.Employee_Name, Q1.Pay_Type) as SQ1,
   -- Sub query to count total number of employees with 0.5 - 3.0 attendance points
   (Select Count(*) as No_of_Employees
   From
    (Select Sum(Q1.Points) as Total_Points,
             Q1.Employee_Name as Names,
             Q1.Pay_Type as PayType
    From
      (Select Concat(B.Last_Name, ', ', B.First_Name, ' ',  B.Middle_Name) as Employee_Name,
              Format(A.Point_Date, 'yyyy/MM/dd') as Point_Date, 
              A.Points as Points,
              C.Pay_Type as Pay_Type
      From Personnel_v_Point as A, Plexus_Control_v_Plexus_User as B, Personnel_v_Employee as C
      Where A.PUN = B.Plexus_User_No
        AND B.Plexus_User_No = C.Plexus_User_No
        AND A.Point_Status_Key = 2
        AND B.Active = -1
        AND C.Pay_Type like @paytype + '%'
        AND A.Point_Date Between @StartDate AND @EndDate-1) as Q1
    Group By Q1.Employee_Name, Q1.Pay_Type) as Q2
  Where Q2.Total_Points >= 3.5) as SQ2,
   -- Sub query to count total number of employees
  (Select Count(*) as Total_Employees  
  From
    (Select Sum(Q1.Points) as Total_Points,
             Q1.Employee_Name as Names,
             Q1.Pay_Type as PayType
    From
      (Select Concat(B.Last_Name, ', ', B.First_Name, ' ',  B.Middle_Name) as Employee_Name,
              Format(A.Point_Date, 'yyyy/MM/dd') as Point_Date, 
              A.Points as Points,
              C.Pay_Type as Pay_Type
      From Personnel_v_Point as A, Plexus_Control_v_Plexus_User as B, Personnel_v_Employee as C
      Where A.PUN = B.Plexus_User_No
        AND B.Plexus_User_No = C.Plexus_User_No
        AND A.Point_Status_Key = 2
        AND B.Active = -1
        AND C.Pay_Type like @paytype + '%'
        AND A.Point_Date Between @StartDate AND @EndDate-1) as Q1
    Group By Q1.Employee_Name, Q1.Pay_Type) as Q2) as SQ3
Where SQ1.Total_Points >= 3.5