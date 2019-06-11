--------------------------------------------------------------------
--------------- Track Printer Toner Inventory  ---------------------
------------- Created by Nisha Verma on 06/11/2019 -----------------
--------------------------------------------------------------------

Select A.Item_No, 
       --B.Item_Group, 
       --D.Item_Type, 
       A.Description, 
       A.Min_Quantity, 
       C.Quantity as Current_Quantity,
       CASE WHEN A.Min_Quantity - C.Quantity > 0 THEN A.Min_Quantity - C.Quantity
            ELSE 0 END  as To_Be_Order,
       Concat(F.First_Name, ' ', F.Middle_Name, ' ',  F.Last_Name) as Used_By,
       Format(E.Usage_Date, 'yyyy/MM/dd') as Date
From Purchasing_v_Item as A, Purchasing_v_Item_Group as B, Purchasing_v_Item_Location as C, Purchasing_v_Item_Type as D, Purchasing_v_Item_Usage as E, Plexus_Control_v_Plexus_User as F
Where A.Item_Group_Key = B.Item_Group_Key
  AND A.Item_Key = C.Item_Key
  AND A.Item_Type_Key = D.Item_Type_Key
  AND A.Item_Key = E.Item_Key
  AND E.Used_By = F.Plexus_User_No
  AND A.Active = 1
  AND B.Item_Group = 'IT'
  AND D.Item_Type = 'IT Supply'
  AND Format(E.Usage_Date,'MMMM yyyy') =  @Month 
Group By A.Item_No, A.Description, A.Min_Quantity, C.Quantity, F.First_Name, F.Middle_Name, F.Last_Name, Format(E.Usage_Date, 'yyyy/MM/dd')
Order By A.Item_No, Format(E.Usage_Date, 'yyyy/MM/dd')