-------------------------------------------------------------
------ Displays Employee Emergency Contact Information ------
------ Created by Nisha Verma on 12/10/2018 -----------------
-------------------------------------------------------------

--Retreiving required columns from Database
Select B.Customer_Employee_No as "Employee #", 
       A.First_Name as "First Name",
       A.Middle_Name as "Middle Name", 
       A.Last_Name as "Last Name", 
       FORMAT(B.Hire_Date, 'MM/dd/yyyy', 'en-US' ) as "Hire Date", 
       B.Emergency_Note as "Notes", 
       B.Badge_No as "Badge #"
--Joining Multiple Tables
From Plexus_Control_v_Plexus_User as A
Join Personnel_v_Employee as B
ON A.Plexus_User_No = B.Plexus_User_No
--Using Filters
Where B.Employee_Status = 'Active'
  AND B.Customer_Employee_No LIKE @Employee_No + '%'
  AND A.First_Name LIKE @First_Name + '%'
  AND A.Last_Name LIKE @Last_Name + '%'
  AND B.Badge_No LIKE @Badge_No + '%'
Order By A.First_Name