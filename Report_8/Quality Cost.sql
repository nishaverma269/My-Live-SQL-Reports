--------------- Quality Cost Graph ---------------
------ Created by Nisha Verma on 03/27/2019 ------
--------------------------------------------------

CREATE TABLE #QualityCost
(
    CostType    VARCHAR(30),
    Cost        DECIMAL(10, 4),
    Period      VARCHAR(7)
)

INSERT #QualityCost
(
    CostType,
    Cost,
    Period
)
Select Case When Q1.Account = '4852' Then 'Failure Cost' Else 'Preventive Cost' END as Cost_Type,
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
      AND LEFT(B.Period, 4) = @Year AND B.Period IS NOT NULL
  UNION ALL
  Select
    '4852' as Cost_Type,
    Sum(C.Currency_Amount) as Cost,
    D.Period as Period
  From Accounting_v_AR_Check_Unapplied as C, Accounting_v_AR_Deposit as D
  Where C.Deposit_Link = D.Deposit_Link
    AND C.AR_Unapplied_Key = 1433 --Quality cost 4852-100000-3500
    AND LEFT(D.Period, 4) = @Year AND D.Period IS NOT NULL
  Group By D.Period
  ) Q1
  
Group By Q1.Account, Format(Q1.Period, '####/##')

Union

Select 'Appraisal Cost' as Cost_Type,
       Sum(Q1.Unit_Cost * Q1.Quantity) as Cost,
       FORMAT(Q1.Report_Date, 'yyyy/MM') as Period
From
  (Select A.Report_Date as Report_Date,
          A.Unit_Cost as Unit_Cost,
          A.Quantity as Quantity
  From  Part_v_Scrap as A) as Q1
Where Format(Q1.Report_Date, 'yyyy') = @Year AND Q1.Report_Date IS NOT NULL
Group By Format(Q1.Report_Date, 'yyyy/MM')

Select A.CostType, A.Cost, A.Period From #QualityCost as A
Order By A.Period, A.CostType