-------------------------------------------------------------
---------- Display Daily Production Job Overview ------------
----------- Created by Nisha Verma on 06/19/2019 ------------
-------------------------------------------------------------

CREATE TABLE #Date_Base
(
    Date     Datetime,
    VALUE    INT
)

INSERT INTO #Date_Base 
VALUES (GetDate(), 1), ((Getdate()+1), 2) , ((Getdate()+2), 3) 

Select
 Q2.WorkCenter, Q2.PartNo, ISNULL([1], 0) as Today, ISNULL([2], 0) as Tomorrow, ISNULL([3], 0) as DayAfter
From
 (Select D.Name as Workcenter, A.Part_No as PartNo, B.Quantity as Quantity, E.Value
  
  From Part_v_Part as A
  
  Inner Join Part_v_Job as B  
    ON A.Part_Key = B.Part_Key
  Left Outer Join Part_v_Production as C
    ON A.Part_Key = C.Part_Key
  Left Outer Join Part_v_Workcenter as D
    ON C.Workcenter_Key = D.Workcenter_Key
  Right Outer Join #Date_Base as E
    ON Format(B.Due_Date, 'MM/dd/yyyy') = Format(E.Date, 'MM/dd/yyyy')
) Q1
PIVOT
(
  MAX(Quantity) 
  FOR Value IN ([1], [2], [3])
) Q2
Where Q2.PartNo != 'NULL'