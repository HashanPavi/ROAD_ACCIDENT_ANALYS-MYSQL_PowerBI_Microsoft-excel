SELECT*FROM Road_Accident

--CY Casualties--

SELECT
SUM(Number_of_Casualties) AS CY_Casualties
FROM Road_Accident
WHERE YEAR(Accident_Date) = '2022' 

--CY Accident--

SELECT
COUNT( Accident_Index) AS CY_Accident
FROM Road_Accident
WHERE YEAR(Accident_Date) = '2022' 

--CY Fatal Casualties--

SELECT
SUM(Number_of_Casualties) AS CY_Fatal_Casualties
FROM Road_Accident
WHERE YEAR(Accident_Date) = '2022'  AND Accident_Severity='Fatal'

--CY Serious Casualties--

SELECT
SUM(Number_of_Casualties) AS CY_Serious_Casualties
FROM Road_Accident
WHERE YEAR(Accident_Date) = '2022'  AND Accident_Severity='Serious'

--CY Slight Casualties--

SELECT
SUM(Number_of_Casualties) AS CY_Slight_Casualties
FROM Road_Accident
WHERE YEAR(Accident_Date) = '2022'  AND Accident_Severity='Slight'

--CY Casualties vs PY Casualties  Monthly Trend--
 
SELECT
DATENAME(MONTH,Accident_Date),
SUM(Number_of_casualties)
FROM Road_Accident
WHERE YEAR(Accident_Date) = '2021'
GROUP BY DATENAME(MONTH,Accident_Date)

--Casualties by Road Type--

SELECT
Road_Type,
SUM(Number_of_Casualties) AS CY_Casualties
FROM Road_Accident
WHERE YEAR(Accident_Date) = '2022' AND Road_Type IS NOT NULL
GROUP BY Road_Type

-- Casualties by Urban/Rural Area--

SELECT
Urban_or_Rural_Area,
CAST(SUM(Number_of_Casualties) AS DECIMAL(10,2))*100/
(SELECT
CAST(SUM(Number_of_Casualties) AS DECIMAL(10,2))
FROM Road_Accident
WHERE YEAR(Accident_Date) = '2022') AS CY_Casualties
FROM Road_Accident
WHERE YEAR(Accident_Date) = '2022'
GROUP BY Urban_or_Rural_Area

--Casualties  by Light Condition--

SELECT 
CASE
WHEN Light_Conditions IN ('Daylight') THEN 'Day'
WHEN Light_Conditions IN ('Darkness - lights lit','Darkness - lighting unknown','Darkness - no lighting','Darkness - lights unlight') THEN 'Night'
END AS Light_Conditions,
CAST(CAST(SUM(Number_of_Casualties) AS DECIMAL(10,2))*100/(SELECT
CAST(SUM(Number_of_Casualties) AS DECIMAL(10,2))
FROM Road_Accident
WHERE YEAR(Accident_Date) = '2022') AS DECIMAL(10,2))
AS CY_Casualties_PCT
FROM Road_Accident
WHERE YEAR(Accident_Date) = '2022'
AND  Light_Conditions IN ('Darkness - lights lit','Darkness - lighting unknown','Darkness - no lighting','Darkness - lights unlight','Daylight')
GROUP BY 
CASE
WHEN Light_Conditions IN ('Daylight') THEN 'Day'
WHEN Light_Conditions IN ('Darkness - lights lit','Darkness - lighting unknown','Darkness - no lighting','Darkness - lights unlight') THEN 'Night'
END

--Location by Number  of  Casualties--

SELECT TOP 10
Local_Authority_District,
SUM(Number_of_Casualties) AS Total_Casualties
FROM Road_Accident
GROUP BY Local_Authority_District 
ORDER BY  Total_Casualties DESC






