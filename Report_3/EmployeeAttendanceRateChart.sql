----- Part 1: Displays Employee Attendance Rate Chart by No of employees -----
------ Created by Nisha Verma on 01/07/2019 -----------------
-------------------------------------------------------------

Declare @AttendanceRate1 varchar(40)
SET   @AttendanceRate1 = '100.00% and Above'

Declare @AttendanceRate2 varchar(40)
SET   @AttendanceRate2 = '90~99.99%'

Declare @AttendanceRate3 varchar(40)
SET   @AttendanceRate3 = '80~89.99%'

Declare @AttendanceRate4 varchar(40)
SET   @AttendanceRate4 = '70~79.99%'

Declare @AttendanceRate5 varchar(40)
SET   @AttendanceRate5 = '60~69.99%'

Declare @AttendanceRate6 varchar(40)
SET   @AttendanceRate6 = '50~59.99%'

Declare @AttendanceRate7 varchar(40)
SET   @AttendanceRate7 = '40~49.99%'

Declare @AttendanceRate8 varchar(40)
SET   @AttendanceRate8 = '30~39.99%'

Declare @AttendanceRate9 varchar(40)
SET   @AttendanceRate9 = '20~29.99%'

Declare @AttendanceRate10 varchar(40)
SET   @AttendanceRate10 = '10~19.99%'

Declare @AttendanceRate11 varchar(40)
SET   @AttendanceRate11 = '1~9.99%'

-- Attendance Rate 100%
Select  @AttendanceRate1 AS AttendanceRate,
        Count(Q2.Attendance_Rate) AS NumberOfEmployees
From
(Select Q1.Department,
       Q1.Employee_Name,
       Q1.Pay_Type,
       Sum(Q1.Actual_Hours) as Actual_Hours,
       Sum(Q1.Scheduled_Hours) as Scheduled_Hours,
       CAST(ROUND((CASE WHEN Sum(Q1.Scheduled_Hours) > 0 THEN Sum(Q1.Actual_Hours)/Sum(Q1.Scheduled_Hours)
            ELSE 0 END),2) AS DECIMAL(18,2)) * 100 as Attendance_Rate
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
    AND A.Scheduled_In_Time Between '12/1/18'And '12/31/18') as Q1
Group By Q1.Department, Q1.Employee_Name, Q1.Pay_Type) As Q2
Where Q2.Attendance_Rate >= 100.00

UNION ALL

-- Attendance Rate 90.00 - 99.00
Select @AttendanceRate2, 
        Count(Q2.Attendance_Rate) AS NumberOfEmployees
From (Select Q1.Department,
       Q1.Employee_Name,
       Q1.Pay_Type,
       Sum(Q1.Actual_Hours) as Actual_Hours,
       Sum(Q1.Scheduled_Hours) as Scheduled_Hours,
       CAST(ROUND((CASE WHEN Sum(Q1.Scheduled_Hours) > 0 THEN Sum(Q1.Actual_Hours)/Sum(Q1.Scheduled_Hours)
            ELSE 0 END),2) AS DECIMAL(18,2)) * 100 as Attendance_Rate
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
    AND A.Scheduled_In_Time Between '12/1/18'And '12/31/18') as Q1
Group By Q1.Department, Q1.Employee_Name, Q1.Pay_Type) As Q2
Where Q2.Attendance_Rate Between 90.00 AND 99.99

UNION ALL

-- Attendance Rate 80.00 - 89.00
Select @AttendanceRate3,
       Count(Q2.Attendance_Rate) AS NumberOfEmployees
From (Select Q1.Department,
       Q1.Employee_Name,
       Q1.Pay_Type,
       Sum(Q1.Actual_Hours) as Actual_Hours,
       Sum(Q1.Scheduled_Hours) as Scheduled_Hours,
       CAST(ROUND((CASE WHEN Sum(Q1.Scheduled_Hours) > 0 THEN Sum(Q1.Actual_Hours)/Sum(Q1.Scheduled_Hours)
            ELSE 0 END),2) AS DECIMAL(18,2)) * 100 as Attendance_Rate
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
    AND A.Scheduled_In_Time Between '12/1/18'And '12/31/18') as Q1
Group By Q1.Department, Q1.Employee_Name, Q1.Pay_Type) As Q2
Where Q2.Attendance_Rate Between 80.00 AND 89.99

UNION ALL

-- Attendance Rate 70.00 - 79.00
Select @AttendanceRate4, Count(Q2.Attendance_Rate) AS NumberOfEmployees
From (Select Q1.Department,
       Q1.Employee_Name,
       Q1.Pay_Type,
       Sum(Q1.Actual_Hours) as Actual_Hours,
       Sum(Q1.Scheduled_Hours) as Scheduled_Hours,
       CAST(ROUND((CASE WHEN Sum(Q1.Scheduled_Hours) > 0 THEN Sum(Q1.Actual_Hours)/Sum(Q1.Scheduled_Hours)
            ELSE 0 END),2) AS DECIMAL(18,2)) * 100 as Attendance_Rate
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
    AND A.Scheduled_In_Time Between '12/1/18'And '12/31/18') as Q1
Group By Q1.Department, Q1.Employee_Name, Q1.Pay_Type) As Q2
Where Q2.Attendance_Rate Between 70.00 AND 79.99

UNION ALL

-- Attendance Rate 60.00 - 69.00
Select @AttendanceRate5, Count(Q2.Attendance_Rate) AS NumberOfEmployees
From (Select Q1.Department,
       Q1.Employee_Name,
       Q1.Pay_Type,
       Sum(Q1.Actual_Hours) as Actual_Hours,
       Sum(Q1.Scheduled_Hours) as Scheduled_Hours,
       CAST(ROUND((CASE WHEN Sum(Q1.Scheduled_Hours) > 0 THEN Sum(Q1.Actual_Hours)/Sum(Q1.Scheduled_Hours)
            ELSE 0 END),2) AS DECIMAL(18,2)) * 100 as Attendance_Rate
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
    AND A.Scheduled_In_Time Between '12/1/18'And '12/31/18') as Q1
Group By Q1.Department, Q1.Employee_Name, Q1.Pay_Type) As Q2
Where Q2.Attendance_Rate Between 60.00 AND 69.99

UNION ALL

-- Attendance Rate 50.00 - 59.00
Select @AttendanceRate6, Count(Q2.Attendance_Rate) AS NumberOfEmployees
From (Select Q1.Department,
       Q1.Employee_Name,
       Q1.Pay_Type,
       Sum(Q1.Actual_Hours) as Actual_Hours,
       Sum(Q1.Scheduled_Hours) as Scheduled_Hours,
       CAST(ROUND((CASE WHEN Sum(Q1.Scheduled_Hours) > 0 THEN Sum(Q1.Actual_Hours)/Sum(Q1.Scheduled_Hours)
            ELSE 0 END),2) AS DECIMAL(18,2)) * 100 as Attendance_Rate
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
    AND A.Scheduled_In_Time Between '12/1/18'And '12/31/18') as Q1
Group By Q1.Department, Q1.Employee_Name, Q1.Pay_Type) As Q2
Where Q2.Attendance_Rate Between 50.00 AND 59.99

UNION ALL

-- Attendance Rate 40.00 - 49.00
Select @AttendanceRate7,Count(Q2.Attendance_Rate) AS NumberOfEmployees
From (Select Q1.Department,
       Q1.Employee_Name,
       Q1.Pay_Type,
       Sum(Q1.Actual_Hours) as Actual_Hours,
       Sum(Q1.Scheduled_Hours) as Scheduled_Hours,
       CAST(ROUND((CASE WHEN Sum(Q1.Scheduled_Hours) > 0 THEN Sum(Q1.Actual_Hours)/Sum(Q1.Scheduled_Hours)
            ELSE 0 END),2) AS DECIMAL(18,2)) * 100 as Attendance_Rate
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
    AND A.Scheduled_In_Time Between '12/1/18'And '12/31/18') as Q1
Group By Q1.Department, Q1.Employee_Name, Q1.Pay_Type) As Q2
Where Q2.Attendance_Rate Between 40.00 AND 49.99

UNION ALL

-- Attendance Rate 30.00 - 39.00
Select @AttendanceRate8, Count(Q2.Attendance_Rate) AS NumberOfEmployees
From (Select Q1.Department,
       Q1.Employee_Name,
       Q1.Pay_Type,
       Sum(Q1.Actual_Hours) as Actual_Hours,
       Sum(Q1.Scheduled_Hours) as Scheduled_Hours,
       CAST(ROUND((CASE WHEN Sum(Q1.Scheduled_Hours) > 0 THEN Sum(Q1.Actual_Hours)/Sum(Q1.Scheduled_Hours)
            ELSE 0 END),2) AS DECIMAL(18,2)) * 100 as Attendance_Rate
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
    AND A.Scheduled_In_Time Between '12/1/18'And '12/31/18') as Q1
Group By Q1.Department, Q1.Employee_Name, Q1.Pay_Type) As Q2
Where Q2.Attendance_Rate Between 30.00 AND 39.99

UNION ALL

-- Attendance Rate 20.00 - 29.00
Select @AttendanceRate9,Count(Q2.Attendance_Rate) AS NumberOfEmployees
From (Select Q1.Department,
       Q1.Employee_Name,
       Q1.Pay_Type,
       Sum(Q1.Actual_Hours) as Actual_Hours,
       Sum(Q1.Scheduled_Hours) as Scheduled_Hours,
       CAST(ROUND((CASE WHEN Sum(Q1.Scheduled_Hours) > 0 THEN Sum(Q1.Actual_Hours)/Sum(Q1.Scheduled_Hours)
            ELSE 0 END),2) AS DECIMAL(18,2)) * 100 as Attendance_Rate
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
    AND A.Scheduled_In_Time Between '12/1/18'And '12/31/18') as Q1
Group By Q1.Department, Q1.Employee_Name, Q1.Pay_Type) As Q2
Where Q2.Attendance_Rate Between 20.00 AND 29.99

UNION ALL

-- Attendance Rate 10.00 - 19.00
Select @AttendanceRate10,Count(Q2.Attendance_Rate) AS NumberOfEmployees
From (Select Q1.Department,
       Q1.Employee_Name,
       Q1.Pay_Type,
       Sum(Q1.Actual_Hours) as Actual_Hours,
       Sum(Q1.Scheduled_Hours) as Scheduled_Hours,
       CAST(ROUND((CASE WHEN Sum(Q1.Scheduled_Hours) > 0 THEN Sum(Q1.Actual_Hours)/Sum(Q1.Scheduled_Hours)
            ELSE 0 END),2) AS DECIMAL(18,2)) * 100 as Attendance_Rate
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
    AND A.Scheduled_In_Time Between '12/1/18'And '12/31/18') as Q1
Group By Q1.Department, Q1.Employee_Name, Q1.Pay_Type) As Q2
Where Q2.Attendance_Rate Between 10.00 AND 19.99

UNION ALL

-- Attendance Rate 1.00 - 9.00
Select @AttendanceRate11,
       Count(Q2.Attendance_Rate) AS NumberOfEmployees
From (Select Q1.Department,
       Q1.Employee_Name,
       Q1.Pay_Type,
       Sum(Q1.Actual_Hours) as Actual_Hours,
       Sum(Q1.Scheduled_Hours) as Scheduled_Hours,
       CAST(ROUND((CASE WHEN Sum(Q1.Scheduled_Hours) > 0 THEN Sum(Q1.Actual_Hours)/Sum(Q1.Scheduled_Hours)
            ELSE 0 END),2) AS DECIMAL(18,2)) * 100 as Attendance_Rate
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
    AND A.Scheduled_In_Time Between '12/1/18'And '12/31/18') as Q1
Group By Q1.Department, Q1.Employee_Name, Q1.Pay_Type) As Q2
Where Q2.Attendance_Rate Between 1.00 AND 9.99

----- Part 2: Displays Employee Attendance Rate Chart by Month -----
---------- Created by Nisha Verma on 01/07/2019 --------------------
--------------------------------------------------------------------

Declare @Text1 varchar(40)
SET   @Text1 = 'JAN'

Declare @Text2 varchar(40)
SET   @Text2 = 'FEB'

Declare @Text3 varchar(40)
SET   @Text3 = 'MAR'

Declare @Text4 varchar(40)
SET   @Text4 = 'APR'

Declare @Text5 varchar(40)
SET   @Text5 = 'MAY'

Declare @Text6 varchar(40)
SET   @Text6 = 'JUN'

Declare @Text7 varchar(40)
SET   @Text7 = 'JUL'

Declare @Text8 varchar(40)
SET   @Text8 = 'AUG'

Declare @Text9 varchar(40)
SET   @Text9 = 'SEP'

Declare @Text10 varchar(40)
SET   @Text10 = 'OCT'

Declare @Text11 varchar(40)
SET   @Text11 = 'NOV'

Declare @Text12 varchar(40)
SET   @Text12 = 'DEC'

-- Attendance Rate for Jan
Select  @Text1 AS Month,
         CAST(ROUND((CASE WHEN Sum(Q2.Scheduled_Hours) > 0 THEN Sum(Q2.Actual_Hours)/Sum(Q2.Scheduled_Hours)
            ELSE 0 END),2) AS DECIMAL(18,2)) * 100 as Attendance_Rate
From (Select Q1.Department,
       Q1.Employee_Name,
       Q1.Pay_Type,
       Sum(Q1.Actual_Hours) as Actual_Hours,
       Sum(Q1.Scheduled_Hours) as Scheduled_Hours
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
    AND A.Scheduled_In_Time Between '01/01/18' AND '01/31/18') as Q1
Group By Q1.Department, Q1.Employee_Name, Q1.Pay_Type) As Q2

Union All

-- Attendance Rate for Feb
Select  @Text2 AS Month,
        CAST(ROUND((CASE WHEN Sum(Q2.Scheduled_Hours) > 0 THEN Sum(Q2.Actual_Hours)/Sum(Q2.Scheduled_Hours)
            ELSE 0 END),2) AS DECIMAL(18,2)) * 100 as Attendance_Rate
From (Select Q1.Department,
       Q1.Employee_Name,
       Q1.Pay_Type,
       Sum(Q1.Actual_Hours) as Actual_Hours,
       Sum(Q1.Scheduled_Hours) as Scheduled_Hours
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
    AND A.Scheduled_In_Time Between '02/02/18' AND '02/28/18') as Q1
Group By Q1.Department, Q1.Employee_Name, Q1.Pay_Type) As Q2

Union All

-- Attendance Rate for MAR
Select  @Text3 AS Month,
        CAST(ROUND((CASE WHEN Sum(Q2.Scheduled_Hours) > 0 THEN Sum(Q2.Actual_Hours)/Sum(Q2.Scheduled_Hours)
            ELSE 0 END),2) AS DECIMAL(18,2)) * 100 as Attendance_Rate
From (Select Q1.Department,
       Q1.Employee_Name,
       Q1.Pay_Type,
       Sum(Q1.Actual_Hours) as Actual_Hours,
       Sum(Q1.Scheduled_Hours) as Scheduled_Hours
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
    AND A.Scheduled_In_Time Between '03/01/18' AND '03/31/18') as Q1
Group By Q1.Department, Q1.Employee_Name, Q1.Pay_Type) As Q2

Union All

-- Attendance Rate for APR
Select  @Text4 AS Month,
       CAST(ROUND((CASE WHEN Sum(Q2.Scheduled_Hours) > 0 THEN Sum(Q2.Actual_Hours)/Sum(Q2.Scheduled_Hours)
            ELSE 0 END),2) AS DECIMAL(18,2)) * 100 as Attendance_Rate
From (Select Q1.Department,
       Q1.Employee_Name,
       Q1.Pay_Type,
       Sum(Q1.Actual_Hours) as Actual_Hours,
       Sum(Q1.Scheduled_Hours) as Scheduled_Hours
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
    AND A.Scheduled_In_Time Between '04/01/18' AND '04/30/18') as Q1
Group By Q1.Department, Q1.Employee_Name, Q1.Pay_Type) As Q2

Union All

-- Attendance Rate for MAY
Select  @Text5 AS Month,
        CAST(ROUND((CASE WHEN Sum(Q2.Scheduled_Hours) > 0 THEN Sum(Q2.Actual_Hours)/Sum(Q2.Scheduled_Hours)
            ELSE 0 END),2) AS DECIMAL(18,2)) * 100 as Attendance_Rate
From (Select Q1.Department,
       Q1.Employee_Name,
       Q1.Pay_Type,
       Sum(Q1.Actual_Hours) as Actual_Hours,
       Sum(Q1.Scheduled_Hours) as Scheduled_Hours
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
    AND A.Scheduled_In_Time Between '05/01/18' AND '05/31/18') as Q1
Group By Q1.Department, Q1.Employee_Name, Q1.Pay_Type) As Q2

Union All

-- Attendance Rate for JUN
Select  @Text6 AS Month,
        CAST(ROUND((CASE WHEN Sum(Q2.Scheduled_Hours) > 0 THEN Sum(Q2.Actual_Hours)/Sum(Q2.Scheduled_Hours)
            ELSE 0 END),2) AS DECIMAL(18,2)) * 100 as Attendance_Rate
From (Select Q1.Department,
       Q1.Employee_Name,
       Q1.Pay_Type,
       Sum(Q1.Actual_Hours) as Actual_Hours,
       Sum(Q1.Scheduled_Hours) as Scheduled_Hours
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
    AND A.Scheduled_In_Time Between '06/01/18' AND '06/30/18') as Q1
Group By Q1.Department, Q1.Employee_Name, Q1.Pay_Type) As Q2

Union All

-- Attendance Rate for JUL
Select  @Text7 AS Month,
        CAST(ROUND((CASE WHEN Sum(Q2.Scheduled_Hours) > 0 THEN Sum(Q2.Actual_Hours)/Sum(Q2.Scheduled_Hours)
            ELSE 0 END),2) AS DECIMAL(18,2)) * 100 as Attendance_Rate
From (Select Q1.Department,
       Q1.Employee_Name,
       Q1.Pay_Type,
       Sum(Q1.Actual_Hours) as Actual_Hours,
       Sum(Q1.Scheduled_Hours) as Scheduled_Hours
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
    AND A.Scheduled_In_Time Between '07/01/18' AND '07/31/18') as Q1
Group By Q1.Department, Q1.Employee_Name, Q1.Pay_Type) As Q2

Union All

-- Attendance Rate for AUG
Select  @Text8 AS Month,
       CAST(ROUND((CASE WHEN Sum(Q2.Scheduled_Hours) > 0 THEN Sum(Q2.Actual_Hours)/Sum(Q2.Scheduled_Hours)
            ELSE 0 END),2) AS DECIMAL(18,2)) * 100 as Attendance_Rate
From (Select Q1.Department,
       Q1.Employee_Name,
       Q1.Pay_Type,
       Sum(Q1.Actual_Hours) as Actual_Hours,
       Sum(Q1.Scheduled_Hours) as Scheduled_Hours
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
    AND A.Scheduled_In_Time Between '08/01/18' AND '08/31/18') as Q1
Group By Q1.Department, Q1.Employee_Name, Q1.Pay_Type) As Q2

Union All

-- Attendance Rate for SEP
Select  @Text9 AS Month,
        CAST(ROUND((CASE WHEN Sum(Q2.Scheduled_Hours) > 0 THEN Sum(Q2.Actual_Hours)/Sum(Q2.Scheduled_Hours)
            ELSE 0 END),2) AS DECIMAL(18,2)) * 100 as Attendance_Rate
From (Select Q1.Department,
       Q1.Employee_Name,
       Q1.Pay_Type,
       Sum(Q1.Actual_Hours) as Actual_Hours,
       Sum(Q1.Scheduled_Hours) as Scheduled_Hours
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
    AND A.Scheduled_In_Time Between '09/01/18' AND '09/30/18') as Q1
Group By Q1.Department, Q1.Employee_Name, Q1.Pay_Type) As Q2

Union All

-- Attendance Rate for OCT
Select  @Text10 AS Month,
        CAST(ROUND((CASE WHEN Sum(Q2.Scheduled_Hours) > 0 THEN Sum(Q2.Actual_Hours)/Sum(Q2.Scheduled_Hours)
            ELSE 0 END),2) AS DECIMAL(18,2)) * 100 as Attendance_Rate
From (Select Q1.Department,
       Q1.Employee_Name,
       Q1.Pay_Type,
       Sum(Q1.Actual_Hours) as Actual_Hours,
       Sum(Q1.Scheduled_Hours) as Scheduled_Hours
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
    AND A.Scheduled_In_Time Between '10/01/18' AND '10/31/18') as Q1
Group By Q1.Department, Q1.Employee_Name, Q1.Pay_Type) As Q2

Union All

-- Attendance Rate for NOV
Select  @Text11 AS Month,
        CAST(ROUND((CASE WHEN Sum(Q2.Scheduled_Hours) > 0 THEN Sum(Q2.Actual_Hours)/Sum(Q2.Scheduled_Hours)
            ELSE 0 END),2) AS DECIMAL(18,2)) * 100 as Attendance_Rate
From (Select Q1.Department,
       Q1.Employee_Name,
       Q1.Pay_Type,
       Sum(Q1.Actual_Hours) as Actual_Hours,
       Sum(Q1.Scheduled_Hours) as Scheduled_Hours
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
    AND A.Scheduled_In_Time Between '11/01/18' AND '11/30/18') as Q1
Group By Q1.Department, Q1.Employee_Name, Q1.Pay_Type) As Q2

Union All

-- Attendance Rate for DEC
Select  @Text12 AS Month,
       CAST(ROUND((CASE WHEN Sum(Q2.Scheduled_Hours) > 0 THEN Sum(Q2.Actual_Hours)/Sum(Q2.Scheduled_Hours)
            ELSE 0 END),2) AS DECIMAL(18,2)) * 100 as Attendance_Rate
From (Select Q1.Department,
       Q1.Employee_Name,
       Q1.Pay_Type,
       Sum(Q1.Actual_Hours) as Actual_Hours,
       Sum(Q1.Scheduled_Hours) as Scheduled_Hours
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
    AND A.Scheduled_In_Time Between '12/01/18' AND '12/31/18') as Q1
Group By Q1.Department, Q1.Employee_Name, Q1.Pay_Type) As Q2