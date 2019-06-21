-------------------------------------------------------------
------------ Display Sales Forecast Graph -------------------
--------- Created by Nisha Verma on 06/18/2019 --------------
-------------------------------------------------------------

Select
    Q1.Period,
    Q1.BookedForecast as 'Booked Order',
    Q2.NewForecast as 'Booked + Next Gen'
From
(
  Select E.Forecast_Period as Period, Sum(F.Amount) as BookedForecast
  From Sales_v_Forecast_Row as A, Part_v_Part as B, Part_v_Part_Group as C, Sales_v_Forecast_Version as D, Sales_v_Forecast_Period as E, Sales_v_Forecast_Value as F
  Where A.Part_Key = B.Part_Key
    AND B.Part_Group_Key = C.Part_Group_Key
    AND A.Forecast_Version_Key = D.Forecast_Version_Key
    AND A.Forecast_Row_Key = F.Forecast_Row_Key
    AND E.Forecast_Period_Key = F.Forecast_Period_Key
    
    --FILTERS
    AND D.Description = '2019 forecast'
    
  Group By E.Forecast_Period
) Q1,
(
  Select E.Forecast_Period as Period, Sum(F.Amount) as NewForecast
  From Sales_v_Forecast_Row as A, Part_v_Part as B, Part_v_Part_Group as C, Sales_v_Forecast_Version as D, Sales_v_Forecast_Period as E, Sales_v_Forecast_Value as F
  Where A.Part_Key = B.Part_Key
    AND B.Part_Group_Key = C.Part_Group_Key
    AND A.Forecast_Version_Key = D.Forecast_Version_Key
    AND A.Forecast_Row_Key = F.Forecast_Row_Key
    AND E.Forecast_Period_Key = F.Forecast_Period_Key
    
    --FILTERS
    AND D.Description = '2019 2nd Half'
    
  Group By E.Forecast_Period
) Q2

Where Q1.Period = Q2.Period

Order By Right(Q1.Period, 2)