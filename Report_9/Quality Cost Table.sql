-------- IntelliPlex Quality Cost Table ----------
------ Created by Nisha Verma on 04/29/2019 -------------
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


CREATE TABLE #AppraisalCost
(
    Cost        DECIMAL(10, 4),
    Period      VARCHAR(7)
)

INSERT #AppraisalCost
(
    Cost,
    Period
)

Select Sum(Q1.Unit_Cost * Q1.Quantity) as Cost,
       FORMAT(Q1.Report_Date, 'yyyy/MM') as Period
From
  (Select A.Report_Date as Report_Date,
          A.Unit_Cost as Unit_Cost,
          A.Quantity as Quantity
  From  Part_v_Scrap as A) as Q1
Where Format(Q1.Report_Date, 'yyyy') = YEAR(GetDate())
Group By Format(Q1.Report_Date, 'yyyy/MM')

CREATE TABLE #FailureCost
(
    Cost        DECIMAL(10, 4),
    Period      VARCHAR(7)
)

INSERT #FailureCost
(
    Cost,
    Period
)

Select Sum(Q1.Debit) as Cost,
       Format(Q1.Period, '####/##') as Period
From

  (Select  A.Debit as Debit,
           B.Period as Period
    From Accounting_v_AP_Invoice_Dist as A, Accounting_v_AP_Invoice as B
    Where A.Invoice_Link = B.Invoice_Link
      AND (A.Account_No LIKE '4852-' + '%')
      AND B.AP_Invoice_Status_Key IN (81, 83, 2347)
      AND Left(B.Period, 4) = YEAR(GetDate())
  UNION ALL
  Select
    Sum(C.Currency_Amount) as Cost,
    D.Period as Period
  From Accounting_v_AR_Check_Unapplied as C, Accounting_v_AR_Deposit as D
  Where C.Deposit_Link = D.Deposit_Link
    AND C.AR_Unapplied_Key = 1433 --Quality cost 4852-100000-3500
    AND Left(D.Period, 4) = YEAR(GetDate())
  Group By D.Period
  ) Q1
Group By Format(Q1.Period, '####/##')

CREATE TABLE #PreventiveCost
(
    Cost        DECIMAL(10, 4),
    Period      VARCHAR(7)
)

INSERT #PreventiveCost
(
    Cost,
    Period
)

Select Sum(Q1.Debit) as Cost,
       Format(Q1.Period, '####/##') as Period
From

  (Select  A.Debit as Debit,
           B.Period as Period
    From Accounting_v_AP_Invoice_Dist as A, Accounting_v_AP_Invoice as B
    Where A.Invoice_Link = B.Invoice_Link
      AND (A.Account_No LIKE '4853-' + '%')
      AND B.AP_Invoice_Status_Key IN (81, 83, 2347)
      AND Left(B.Period, 4) = YEAR(GetDate())) Q1
  Group By Format(Q1.Period, '####/##')
  
------- ********** Retrieve Data *************** --------
Select RIGHT(A.Month, 2) as Month, 'Total Cost' as Account, B.Cost+C.Cost+D.Cost as Total
From #AppraisalCost as B
JOIN #FailureCost as C
  ON B.Period = C.Period
JOIN #PreventiveCost as D
  ON C.Period = D.Period
Right Outer Join #Year_Base as A
   on A.Month = D.Period

Union All

Select RIGHT(A.Month, 2) as Month, 'Appraisal Cost' as Account, B.Cost as Total
From #Year_Base as A
LEFT OUTER JOIN #AppraisalCost as B
  ON B.Period = A.Month

Union All

Select RIGHT(A.Month, 2) as Month, 'Failure Cost' as Account, B.Cost as Total
From #Year_Base as A
LEFT OUTER JOIN #FailureCost as B
  ON B.Period = A.Month
  
Union All

Select RIGHT(A.Month, 2) as Month, 'Preventive Cost' as Account, B.Cost as Total
From #Year_Base as A
LEFT OUTER JOIN #PreventiveCost as B
  ON B.Period = A.Month