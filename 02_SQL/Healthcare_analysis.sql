USE healthcare


--DATASET
SELECT * FROM healthcare_data

--1.Which age groups require the most medical care?

SELECT TOP (3) age_groups ,COUNT(*) AS Total_Patients FROM 
(SELECT
CASE 
	WHEN age BETWEEN 0 AND 18 THEN '0-18'
	WHEN age BETWEEN 19 AND 35 THEN '19-35'
	WHEN age BETWEEN 36 AND 50 THEN '36-50'
	WHEN age BETWEEN 51 AND 65 THEN '51-65'
	ELSE '65+'
	END AS age_groups
FROM healthcare_data) AS t
GROUP BY age_groups
ORDER BY Total_Patients DESC

--2.What is the gender distribution across different medical conditions?

SELECT medical_condition, gender,
COUNT(*) AS total_patients
FROM healthcare_data
GROUP BY medical_condition, gender
ORDER BY medical_condition, gender DESC

--3.Which blood groups are most frequently admitted?

SELECT blood_type, COUNT(name) AS patients 
FROM healthcare_data
GROUP BY blood_type
ORDER BY patients DESC

--4.What are the most common medical conditions?

SELECT TOP (1) medical_condition , 
COUNT(medical_condition) AS Total_Count FROM healthcare_data
GROUP BY medical_condition
ORDER BY Total_Count DESC

--5.Which diseases generate the highest treatment costs?

SELECT TOP (1) medical_condition,
ROUND(SUM(billing_amount),2) AS Total_Amount FROM healthcare_data
GROUP BY medical_condition
ORDER BY Total_Amount DESC

--6.Which diseases have the longest hospital stays?

SELECT TOP (1) medical_condition,
SUM(DATEDIFF(DAY, date_of_admission,discharge_date)) AS Total_days
FROM healthcare_data
GROUP BY medical_condition
ORDER BY Total_days DESC

--7.Which hospitals admit the highest number of patients?

SELECT TOP (1) hospital, COUNT(name) total_patients
FROM healthcare_data
GROUP BY hospital
ORDER BY total_patients DESC

--8.Which hospitals generate the highest billing revenue?

SELECT TOP(1) hospital , ROUND(SUM(billing_amount),2) AS Total_amount
FROM healthcare_data
GROUP BY hospital
ORDER BY hospital DESC

--9.Which hospitals have the longest average patient stay?

SELECT hospital ,
ROUND(AVG(DATEDIFF(DAY, date_of_admission, discharge_date)),2) AS Average_days
FROM healthcare_data
GROUP BY hospital
ORDER BY Average_days DESC

--10.Which doctors treat the most patients?

SELECT doctor, COUNT(name) AS patients 
FROM healthcare_data
GROUP BY doctor
ORDER BY patients DESC

--11.Which doctors handle the most complex or high-cost cases?

SELECT doctor ,COUNT(bill) AS Total_high_cost_cases FROM
(SELECT doctor, billing_amount,
CASE 
	WHEN billing_amount > 40000 THEN 1
	END AS bill
FROM healthcare_data) AS t
GROUP BY doctor
ORDER BY Total_high_cost_cases DESC

--12.What is the average billing amount per doctor?

SELECT doctor ,
ROUND(AVG(billing_amount),2) AS Average_billing_amount
FROM healthcare_data
GROUP BY doctor 
ORDER BY Average_billing_amount DESC

--13.Which insurance providers cover the largest number of patients?

SELECT TOP (1) insurance_provider, COUNT(name) AS patients
FROM healthcare_data
GROUP BY insurance_provider
ORDER BY patients DESC

--14.Which insurance providers account for the highest billing amounts?

SELECT TOP(1) insurance_provider,
ROUND(SUM(billing_amount),2) AS Total_billing_amount
FROM healthcare_data
GROUP BY insurance_provider
ORDER BY Total_billing_amount DESC

--15.What is the average billing amount by admission type?

SELECT admission_type,
ROUND(AVG(billing_amount),2) AS Average_billing_amount
FROM healthcare_data
GROUP BY admission_type
ORDER BY Average_billing_amount DESC

--16.Which medical conditions contribute the most to hospital revenue?

SELECT medical_condition, ROUND(SUM(billing_amount),2) AS Total_Revenue
FROM healthcare_data
GROUP BY medical_condition
ORDER BY Total_Revenue DESC

--17.What percentage of admissions are Emergency, Urgent, and Elective?

SELECT admission_type,
ROUND(COUNT(*) * 100.0/ SUM(COUNT(*)) OVER(),2)
FROM healthcare_data
GROUP BY admission_type

--18.Which admission type results in the highest average billing?

SELECT admission_type,
ROUND(AVG(billing_amount),2) AS Average_billing_amount
FROM healthcare_data
GROUP BY admission_type
ORDER BY Average_billing_amount DESC

--19.Which admission type has the longest average stay?

SELECT admission_type,
AVG(DATEDIFF(DAY,date_of_admission,discharge_date)) AS Average_Stay
FROM healthcare_data
GROUP BY admission_type

--20.Which medications are prescribed most frequently?

SELECT medication, COUNT(medication) AS Count_medications
FROM healthcare_data
GROUP BY medication
ORDER BY Count_medications DESC 

--21.Which medications are associated with abnormal test results?

SELECT medication, COUNT(test_results) AS abnormal_count
FROM healthcare_data
WHERE test_results = 'Abnormal'
GROUP BY medication
ORDER BY abnormal_count DESC

--22.What are the most commonly prescribed medications for each medical condition?

WITH CTE AS
(
SELECT
medical_condition,medication,
COUNT(*) AS Prescription_Count,
ROW_NUMBER() OVER (PARTITION BY medical_condition ORDER BY COUNT(*) DESC) AS rn
FROM healthcare_data
GROUP BY medical_condition, medication
)
SELECT medical_condition,medication,Prescription_Count
FROM CTE
WHERE rn = 1;

--23.What percentage of laboratory results are Normal, Abnormal, and Inconclusive?

SELECT test_results,
ROUND(COUNT(*) * 100.0 / SUM(COUNT(*)) OVER(),2) AS PCT_test
FROM healthcare_data
GROUP BY test_results
ORDER BY PCT_test DESC

--24.Which medical conditions have the highest abnormal test rate?

SELECT medical_condition, COUNT(test_results) AS abnormal_count
FROM healthcare_data
WHERE test_results = 'Abnormal' 
GROUP BY medical_condition
ORDER BY abnormal_count DESC

--25.Which hospitals report the highest percentage of abnormal test results?

SELECT hospital,
ROUND(SUM(CASE WHEN test_results = 'Abnormal' THEN 1 ELSE 0 END) * 100/ COUNT(*), 2) AS PCT_Abnormal
FROM healthcare_data
GROUP BY hospital
ORDER BY PCT_Abnormal DESC;

--26.What is the average length of stay by hospital?

SELECT hospital, ROUND(AVG(DATEDIFF(DAY,date_of_admission,discharge_date )),2) AS AVG_stay
FROM healthcare_data
GROUP BY hospital
ORDER BY AVG_stay DESC

--27.Which hospitals experience the highest patient volume?

SELECT hospital,COUNT(*) AS Total_patient FROM healthcare_data
GROUP BY hospital
ORDER BY Total_patient DESC

--28.Which months experience peak admissions?

SELECT DATENAME(MONTH, date_of_admission) AS MONTH_of_admissions,
COUNT(*) AS admissions
FROM healthcare_data
GROUP BY DATENAME(MONTH, date_of_admission)
ORDER BY admissions DESC
