-------- IntelliPlex Quality Cost Trend Graph ----------
------ Created by Nisha Verma on 04/1/2019 -------------
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

CREATE TABLE #QualityCost
(
    Account    VARCHAR(30),
    Cost        DECIMAL(10, 4),
    Period      VARCHAR(7)
)

INSERT #QualityCost
(
    Account,
    Cost,
    Period
)

Select Q1.Account as Account,
       Sum(Q1.Debit) as Cost,
       Format(Q1.Period, '####/##') as Period
From

  (Select LEFT(A.Account_No, 4) as Account, 
           A.Debit as Debit,
           B.Period as Period
    From Accounting_v_AP_Invoice_Dist as A, Accounting_v_AP_Invoice as B
    Where A.Invoice_Link = B.Invoice_Link
      AND (A.Account_No LIKE '4852-' + '%' OR A.Account_No LIKE '4853-' + '%')
      AND B.AP_Invoice_Status_Key IN (81, 83, 	2347)
      AND Left(B.Period, 4) = YEAR(GetDate())
  UNION ALL
  Select
    '4852' as Account,
    Sum(C.Currency_Amount) as Cost,
    D.Period as Period
  From Accounting_v_AR_Check_Unapplied as C, Accounting_v_AR_Deposit as D
  Where C.Deposit_Link = D.Deposit_Link
    AND C.AR_Unapplied_Key = 1433 --Quality cost 4852-100000-3500
    AND Left(D.Period, 4) = YEAR(GetDate())
  Group By D.Period
  ) Q1
Group By Q1.Account, Format(Q1.Period, '####/##')

Union

Select '0000' as Account,
       Sum(Q1.Unit_Cost * Q1.Quantity) as Cost,
       FORMAT(Q1.Report_Date, 'yyyy/MM') as Period
From
  (Select A.Report_Date as Report_Date,
          A.Unit_Cost as Unit_Cost,
          A.Quantity as Quantity
  From  Part_v_Scrap as A) as Q1
Where Format(Q1.Report_Date, 'yyyy') = YEAR(GetDate())
Group By Format(Q1.Report_Date, 'yyyy/MM')

------- ********** Retrieve Data *************** --------

Select A.Month, ISNULL([4852], 0) Failure_Cost, ISNULL([4853], 0) Preventive_Cost, ISNULL([0000], 0) Appraisal_Cost, ISNULL([4852]+[4853]+[0000],0) as Total
From #Year_Base as A
LEFT OUTER JOIN
  #QualityCost as B
  Pivot (
      Sum(B.Cost) for B.Account in ([4852],[4853],[0000])
  ) as P
ON Period = A.Month-------- IntelliPlex Quality Cost Trend Graph ----------
------ Created by Nisha Verma on 04/1/2019 -------------
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

CREATE TABLE #QualityCost
(
    Account    VARCHAR(30),
    Cost        DECIMAL(10, 4),
    Period      VARCHAR(7)
)

INSERT #QualityCost
(
    Account,
    Cost,
    Period
)

Select Q1.Account as Account,
       Sum(Q1.Debit) as Cost,
       Format(Q1.Period, '####/##') as Period
From

  (Select LEFT(A.Account_No, 4) as Account, 
           A.Debit as Debit,
           B.Period as Period
    From Accounting_v_AP_Invoice_Dist as A, Accounting_v_AP_Invoice as B
    Where A.Invoice_Link = B.Invoice_Link
      AND (A.Account_No LIKE '4852-' + '%' OR A.Account_No LIKE '4853-' + '%')
      AND B.AP_Invoice_Status_Key IN (81, 83, 	2347)
      AND Left(B.Period, 4) = YEAR(GetDate())
  UNION ALL
  Select
    '4852' as Account,
    Sum(C.Currency_Amount) as Cost,
    D.Period as Period
  From Accounting_v_AR_Check_Unapplied as C, Accounting_v_AR_Deposit as D
  Where C.Deposit_Link = D.Deposit_Link
    AND C.AR_Unapplied_Key = 1433 --Quality cost 4852-100000-3500
    AND Left(D.Period, 4) = YEAR(GetDate())
  Group By D.Period
  ) Q1
Group By Q1.Account, Format(Q1.Period, '####/##')

Union

Select '0000' as Account,
       Sum(Q1.Unit_Cost * Q1.Quantity) as Cost,
       FORMAT(Q1.Report_Date, 'yyyy/MM') as Period
From
  (Select A.Report_Date as Report_Date,
          A.Unit_Cost as Unit_Cost,
          A.Quantity as Quantity
  From  Part_v_Scrap as A) as Q1
Where Format(Q1.Report_Date, 'yyyy') = YEAR(GetDate())
Group By Format(Q1.Report_Date, 'yyyy/MM')

------- ********** Retrieve Data *************** --------

Select A.Month, ISNULL([4852], 0) Failure_Cost, ISNULL([4853], 0) Preventive_Cost, ISNULL([0000], 0) Appraisal_Cost, ISNULL([4852]+[4853]+[0000],0) as Total
From #Year_Base as A
LEFT OUTER JOIN
  #QualityCost as B
  Pivot (
      Sum(B.Cost) for B.Account in ([4852],[4853],[0000])
  ) as P
ON Period = A.Month