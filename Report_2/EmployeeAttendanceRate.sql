------ Displays Employee Attendance Rate ------
------ Created by Nisha Verma on 01/05/2018 -----------------
-------------------------------------------------------------

Select Q1.Department,
       Q1.Employee_Name,
       Q1.Pay_Type,
       Sum(Q1.Actual_Hours) as Actual_Hours,
       Sum(Q1.Scheduled_Hours) as Scheduled_Hours,
       CAST(ROUND((CASE WHEN Sum(Q1.Scheduled_Hours) > 0 THEN Sum(Q1.Actual_Hours)/Sum(Q1.Scheduled_Hours)
            ELSE 0 END),2) AS DECIMAL(18,2)) as Attendance_Rate
FROM
  (Select D.Name as Department,
         Concat(B.First_Name, ' ', B.Last_Name) as Employee_Name,
         C.Pay_Type as Pay_Type,
         CASE WHEN A.Actual_Hours < 8 AND A.Actual_Hours < 4 THEN A.Regular_Hours ELSE A.Actual_Hours END as Actual_Hours,
         A.Shift_Hours as Scheduled_Hours
  From Personnel_v_Clockin as A, Plexus_Control_v_Plexus_User as B, Personnel_v_Employee as C, Common_v_Department as D
  WHERE A.Plexus_User_No = B.Plexus_User_No
    AND C.Plexus_User_No = B.Plexus_User_No
    AND B.Department_No = D.Department_No
    AND C.Employee_Status = 'Active'
    AND A.Scheduled_In_Time Between @StartDate And @EndDate
    AND D.Name LIKE @Department + '%'
    AND B.First_Name LIKE @First_Name + '%'
    AND B.Last_Name LIKE @Last_Name + '%'
    AND C.Pay_type like @paytype + '%') as Q1
Group By Q1.Department, Q1.Employee_Name, Q1.Pay_Type
Order By Q1.Department