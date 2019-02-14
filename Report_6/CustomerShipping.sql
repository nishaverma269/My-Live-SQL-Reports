----------- Displays Customer Shipping Summary  -------------
---------- Created by Nisha Verma on 02/06/2019 -------------
-------------------------------------------------------------

Select D.Name as Customer,
       E.Customer_Address_Code as Address_Code,
       F.Part_Group,
       C.Part_No as Part_No, C.Name as Part_Name,
       B.Price as Unit_Price, 
       Sum(B.Quantity) as Shipped_Quantity,
       Sum((B.Price * B.Quantity)) as Shipped_Amount
From Sales_v_Shipper as A, Sales_v_Shipper_Line as B, Part_v_Part as C, Common_v_Customer as D, Common_v_customer_address as E, Part_v_Part_Group as F
Where A.Shipper_Key = B.Shipper_Key
  AND B.Part_Key = C.Part_Key
  AND A.Customer_No = D.Customer_No
  AND A.Customer_Address_No = E.Customer_Address_No
  AND C.Part_Group_Key = F.Part_Group_Key
  AND A.Ship_Date Between @StartDate And @EndDate
  AND D.Name LIKE @Customer + '%'
  AND E.Customer_Address_Code LIKE @Customer_Address + '%'
  AND C.Part_No LIKE @Part_No + '%'
  AND F.Part_Group LIKE @Part_Group + '%'
Group By B.Price, C.Part_No, C.Name, D.Name, E.Customer_Address_Code, F.Part_Group
Order By D.Name


------------ Displays Customer Shipping Details -------------
---------- Created by Nisha Verma on 02/06/2019 -------------
-------------------------------------------------------------
Select D.Name as Customer,
       E.Customer_Address_Code as Address_Code,
       F.Part_Group,
       C.Part_No as Part_No, C.Name as Part_Name,
       B.Price as Unit_Price, 
       Format(A.Ship_Date, 'yyyy/MM/dd') as Shipped_Date,
       B.Quantity as Shipped_Quantity,
       (B.Price * B.Quantity) as Shipped_Amount
From Sales_v_Shipper as A, Sales_v_Shipper_Line as B, Part_v_Part as C, Common_v_Customer as D, Common_v_customer_address as E, Part_v_Part_Group as F
Where A.Shipper_Key = B.Shipper_Key
  AND B.Part_Key = C.Part_Key
  AND A.Customer_No = D.Customer_No
  AND A.Customer_Address_No = E.Customer_Address_No
  AND C.Part_Group_Key = F.Part_Group_Key
  AND A.Ship_Date Between @StartDate And @EndDate
  AND D.Name LIKE @Customer + '%'
  AND E.Customer_Address_Code LIKE @Customer_Address + '%'
  AND C.Part_No LIKE @Part_No + '%'
  AND B.Price LIKE @Unit_Price + '%'
Group By A.Ship_Date, B.Price, B.Quantity, C.Part_No, C.Name, D.Name, E.Customer_Address_Code, F.Part_Group
Order BY A.Ship_Date