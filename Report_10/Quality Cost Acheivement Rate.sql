-------- IntelliPlex Quality Cost Achievement Rate ----------
--------- Created by Nisha Verma on 04/2/2019 ----------
--------------------------------------------------------


DECLARE @Year VARCHAR(10)
SET @Year = FORMAT( GETDATE()-7, 'yyyy')

CREATE TABLE #Year_Base
(
    Month   VARCHAR(20)
)

INSERT INTO #Year_Base (Month)
VALUES (@Year+'/01'), (@Year+'/02'), (@Year+'/03'), (@Year+'/04'), (@Year+'/05'), (@Year+'/06'), 
(@Year+'/07'), (@Year+'/08'), (@Year+'/09'), (@Year+'/10'), (@Year+'/11'), (@Year+'/12')

Create Table #Trend 
(
  Month         VARCHAR(10),
  Result        Decimal(10,2)
)

INSERT INTO #Trend (Month, Result)
Values ('2019/01', 0.29), ('2019/02', 0.21), ('2019/03', 0.47)

Select A.Month as Month, B.Month as Period, 0.21 as Target, B.Result, (0.21/B.Result) as Achieved_Rate, (0.21/B.Result)*100 as Achieved_Rate_Percent
From #Year_base as A
LEFT OUTER JOIN
     #Trend as B
    ON A.Month = B.Month
Order By A.Month