----------- Displays Customer Shipping Summary  -------------
---------- Created by Nisha Verma on 02/06/2019 -------------
-------------------------------------------------------------

Select Q2.Customer,
       Q2.Address,
       Q2.Part_No,
       Q2.Part_Name,
       Q2.Unit_Price,
       Sum(Q2.Shipped_Quantity) as Shipped_Quantity,
       Sum(Q2.Shipped_Amount) as Shipped_Amount
From
(Select Q1.Customer,
       Q1.Address,
       Q1.Part_No,
       Q1.Part_Name,
       Q1.Ship_Date,
       Q1.Unit_Price,
       Q1.Quantity as Shipped_Quantity,
       Sum(Q1.Shipped_Amount) as Shipped_Amount
From
(Select A.Customer_Name as Customer,
       A.Customer_Address_Code, 
       A.Address as Address,
       A.Part_No as Part_No,
       A.Customer_Part_Description as Part_Name,
       Format(A.Ship_Date,'yyyy/MM/dd') as Ship_Date, 
       B.Price as Unit_Price,
       B.Quantity as Quantity,
       (B.Price * A.Quantity) as Shipped_Amount
From Part_v_Container_Label as A, Sales_v_Shipper_Line as B
Where A.Shipper_Line_Key = B.Shipper_Line_Key
  AND A.Ship_Date Between @StartDate And @EndDate-1
  AND A.Customer_Name LIKE @Customer + '%'
  AND A.Address LIKE @Customer_Address + '%'
  AND A.Part_No LIKE @Part_No + '%') as Q1
Group By Q1.Ship_Date, Q1.Customer, Q1.Address, Q1.Part_No, Q1.Part_Name, Q1.Unit_Price, Q1.Quantity) as Q2
Group By Q2.Unit_Price, Q2.Customer, Q2.Address, Q2.Part_No, Q2.Part_Name


------------ Displays Customer Shipping Details -------------
---------- Created by Nisha Verma on 02/06/2019 -------------
-------------------------------------------------------------

Select Q1.Customer,
       Q1.Address,
       Q1.Part_No,
       Q1.Part_Name,
       Q1.Ship_Date,
       Q1.Unit_Price,
       Q1.Quantity as Shipped_Quantity,
       Sum(Q1.Shipped_Amount) as Shipped_Amount
From
(Select A.Customer_Name as Customer,
       A.Customer_Address_Code, 
       A.Address as Address,
       A.Part_No as Part_No,
       A.Customer_Part_Description as Part_Name,
       Format(A.Ship_Date,'yyyy/MM/dd') as Ship_Date, 
       B.Price as Unit_Price,
       B.Quantity as Quantity,
       (B.Price * A.Quantity) as Shipped_Amount
From Part_v_Container_Label as A, Sales_v_Shipper_Line as B
Where A.Shipper_Line_Key = B.Shipper_Line_Key
  AND A.Ship_Date Between @StartDate And @EndDate-1
  AND A.Customer_Name LIKE @Customer + '%'
  AND A.Address LIKE @Customer_Address + '%'
  AND A.Part_No LIKE @Part_No + '%') as Q1
Group By Q1.Ship_Date, Q1.Customer, Q1.Address, Q1.Part_No, Q1.Part_Name, Q1.Unit_Price, Q1.Quantity
Order By Q1.Ship_Date