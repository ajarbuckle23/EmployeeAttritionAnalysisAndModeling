


# In this script, I write queries to answer ad-hoc analysis questions an HR Business Partner might ask about this dataset



CREATE TABLE attrition_table (
	Age INTEGER,
	Attrition VARCHAR(255),
	BusinessTravel VARCHAR(255),
	DailyRate INTEGER,
	Department VARCHAR(255),
	DistanceFromHome INTEGER,
	Education INTEGER,
	EducationField VARCHAR(255),
	EmployeeCount INTEGER,
	EmployeeNumber INTEGER,
	EnvironmentSatisfaction INTEGER,
	Gender VARCHAR(255),
	HourlyRate INTEGER,
	JobInvolvement INTEGER,
	JobLevel INTEGER,
	JobRole VARCHAR(255),
	JobSatisfaction INTEGER,
	MaritalStatus VARCHAR(255),
	MonthlyIncome INTEGER,
	MonthlyRate INTEGER,
	NumCompaniesWorked INTEGER,
	Over18 VARCHAR(255),
	OverTime VARCHAR(255),
	PercentSalaryHike INTEGER,
	PerformanceRating INTEGER,
	RelationshipSatisfaction INTEGER,
	StandardHours INTEGER,
	StockOptionLevel INTEGER,
	TotalWorkingYears INTEGER,
	TrainingTimesLastYear INTEGER,
	WorkLifeBalance INTEGER,
	YearsAtCompany INTEGER,
	YearsInCurrentRole INTEGER,
	YearsSinceLastPromotion INTEGER,
	YearsWithCurrManager INTEGER
);


# Checking to make sure data import worked properly
SELECT * FROM attrition_table;



# Ad-hoc analysis questions 



# What are the differences in overtime work, performance rating, and job satisfaction for each job role? 
# CONDITION: Round figures to 2 decimal places
SELECT
	JobRole,
	ROUND(100 * (SUM(CASE WHEN OverTime = 'Yes' THEN 1 ELSE 0 END) / COUNT(*)), 2) AS 'Percentage of Employees who Work Overtime',
	ROUND(AVG(PerformanceRating), 2) AS 'Average Performance Rating',
	ROUND(AVG(JobSatisfaction), 2) AS 'Average Job Satisfaction Rating'
FROM attrition_table
GROUP BY JobRole;

# What are the differences in performance rating, job satisfaction, and work-life balance for employees who do and do not work overtime? 
# CONDITION: Round figures to 2 decimal places
SELECT
	OverTime,
	ROUND(AVG(PerformanceRating), 2) AS 'Average Performance Rating', 
	ROUND(AVG(JobSatisfaction), 2) AS 'Average Job Satisfaction Rating', 
	ROUND(AVG(WorkLifeBalance), 2) AS 'Average Work-Life Balance Rating'
FROM attrition_table
GROUP BY OverTime

# What are the differences in overtime work, performance rating, and job satisfaction for each education field? 
# CONDITION: Round figures to 2 decimal places
SELECT
	EducationField,
	ROUND(100 * (SUM(CASE WHEN OverTime = 'Yes' THEN 1 ELSE 0 END) / COUNT(*)), 2) AS 'Percentage of Employees who Work Overtime',
	ROUND(AVG(PerformanceRating), 2) AS 'Average Performance Rating',
	ROUND(AVG(JobSatisfaction), 2) AS 'Average Job Satisfaction Rating'
FROM attrition_table
GROUP BY EducationField;

# What is the average tenure of employees by department? 
# CONDITION: Round the average tenures to 2 decimal places and order the table by descending average tenures
SELECT
	Department, 
	ROUND(AVG(YearsAtCompany), 2) AS 'Average Employee Tenure (Years)'
FROM attrition_table 
GROUP BY Department
ORDER BY AVG(YearsAtCompany) DESC;

# Which job role had the highest average percent increase in salary? 
# CONDITION: Round the percentage increase in salary to 2 decimal places 
SELECT 
	JobRole, 
	ROUND(AVG(PercentSalaryHike), 2) AS 'Percent Salary Hike'
FROM attrition_table
GROUP BY JobRole
ORDER BY AVG(PercentSalaryHike) DESC 
LIMIT 1;

# How do Job Satisfaction and Work Life Balance ratings differ between employees who have and have not left the company?
# CONDITION: Round the ratings to 2 decimal places  
SELECT 
	Attrition, 
	ROUND(AVG(JobSatisfaction), 2) AS 'Average Job Satisfaction rating',
	ROUND(AVG(WorkLifeBalance), 2) AS 'Average Work Life Balance rating'
FROM attrition_table
GROUP BY Attrition;

# What is the average age of employees in this dataset? 
# CONDITION: Round the result to the nearest whole number
SELECT 
	ROUND(AVG(Age), 0) AS 'Average Employee Age'
FROM attrition_table;

# How many employees in this dataset left the company? 
SELECT
	COUNT(*) AS 'Number of Employees that Left the Company'
FROM attrition_table 
WHERE Attrition LIKE 'Yes';

# What is the highest monthly income among the employees who left the company? 
SELECT
	MonthlyIncome AS 'Highest Monthly Income Among Employees who Left the Company'
FROM attrition_table
WHERE Attrition LIKE 'Yes'
ORDER BY MonthlyIncome DESC 
LIMIT 1; 

# What is the highest job level, and how many employees have it? 
SELECT
	JobLevel AS 'Highest Job Level',
	COUNT(*) AS 'Number of Employees'
FROM attrition_table 
GROUP BY JobLevel
ORDER BY JobLevel DESC
LIMIT 1;

# How does Job Satisfaction rating compare between employees who do and don't work overtime? 
SELECT 
	OverTime AS 'Overtime Worked?',
	ROUND(AVG(JobSatisfaction), 2) AS 'Job Satisfaction Rating'
FROM attrition_table 
GROUP BY OverTime;

# What is the average distance from home for employees from each department?
# CONDITION: Order the table by the average distance in descending order, and round the average distance to 2 decimal places 
SELECT 
	Department, 
	ROUND(AVG(DistanceFromHome), 2) AS 'Average Distance from Home'
FROM attrition_table
GROUP BY Department 
ORDER BY AVG(DistanceFromHome) DESC;

# How many employees have worked for more than 10 years at the company? 
SELECT 
	COUNT(*) AS 'Number of Employees with > 10 Years at Company'
FROM attrition_table
WHERE YearsAtCompany > 10;

# What is the average number of training times last year for employees with a job level of 3? 
# CONDITION: Round the result to 2 decimal places
SELECT 
	ROUND(AVG(TrainingTimesLastYear), 2) AS 'Average Number of Training Times Last Year for Level 3 Employees'
FROM attrition_table 
WHERE JobLevel = 3;

# Which department has the highest average Environment Satisfaction rating? 
# CONDITION: Include the department and the rating, and round the rating to 2 decimal places 
SELECT 
	Department,
	ROUND(AVG(EnvironmentSatisfaction), 2) AS 'Average Environment Satisfaction Rating'
FROM attrition_table
GROUP BY Department
ORDER BY AVG(EnvironmentSatisfaction) DESC 
LIMIT 1; 

# What is the average monthly income for employees with a bachelor's degree? (Education = 3)
# CONDITION: Round the result to 2 decimal places 
SELECT
	ROUND(AVG(MonthlyIncome), 2) AS "Average Monthly Income for Employees with a Bachelor's"
FROM attrition_table
WHERE Education = 3;

# What is the most common marital status among employees? 
SELECT
	MaritalStatus AS 'Most Common Marital Status Among Employees'
FROM attrition_table
GROUP BY MaritalStatus
ORDER BY COUNT(*) DESC
LIMIT 1;

# Which job role has the highest average monthly income, and what is it? 
# CONDITION: Round the average monthly income to 2 decimal places 
SELECT 
	JobRole,
	ROUND(AVG(MonthlyIncome), 2) AS 'Average Monthly Income'
FROM attrition_table 
GROUP BY JobRole
ORDER BY AVG(MonthlyIncome) DESC 
LIMIT 1;

# What is the average number of years in their current role for employees with a Job Involvement rating of 4?
# CONDITION: Round the result to 2 decimal places 
SELECT 
	ROUND(AVG(YearsInCurrentRole), 2) AS 'Average Years in Current Role for Employees with Job Involvement Rating of 4'
FROM attrition_table
WHERE JobInvolvement = 4;

# Which department has the highest percentage of employees who work overtime? 
# CONDITION: Round the percentage to 2 decimal places 
SELECT
	Department,
	ROUND(100 * (SUM(CASE WHEN OverTime = 'Yes' THEN 1 ELSE 0 END) / COUNT(*)), 2) AS 'Percentage of Employees who Work Overtime'
FROM attrition_table
GROUP BY Department
ORDER BY SUM(CASE WHEN OverTime = 'Yes' THEN 1 ELSE 0 END) / COUNT(*) DESC
LIMIT 1;

# What is the average percent salary hike for employees with more than 10 total working years?
# CONDITION: Round the result to 2 decimal places 
SELECT 
	ROUND(AVG(PercentSalaryHike), 2) AS 'Average Percent Salary Hike for Employees with > 10 Total Working Years'
FROM attrition_table
WHERE TotalWorkingYears > 10;

# What is the average stock option level for male employees? 
# CONDITION: Round the result to 2 decimal places 
SELECT
	ROUND(AVG(StockOptionLevel), 2) AS 'Average Stock Option Level for Male Employees'
FROM attrition_table
WHERE Gender = 'Male';

# Which employee has the highest daily rate? What is their daily rate, education level, eduaction field, department, and job level? 
SELECT
	EmployeeNumber AS 'Employee ID', 
	DailyRate AS 'Daily Rate',
	Education AS 'Education Level', 
	EducationField AS 'Education Field', 
	Department, 
	JobLevel AS 'Job Level'
FROM attrition_table
ORDER BY DailyRate DESC 
LIMIT 1; 

# What is the average number of years with their current manager for employees with a Job Satisfaction rating of 1? 
# CONDITION: Round the result to 2 decimal places 
SELECT 
	ROUND(AVG(YearsWithCurrManager), 2) AS 'Average Years with Current Manager for Employees with Job Satisfaction Rating of 1'
FROM attrition_table
WHERE JobSatisfaction = 1;

# How many employees have a Relationship Satisfaction rating of 4 or higher? 
SELECT
	COUNT(*) AS 'Number of Employees with Relationship Satisfaction of 4 or Higher'
FROM attrition_table
WHERE RelationshipSatisfaction >= 4;

# How is the amount of busines travel employees do related to their monthly income? 
# CONDITION: Round average monthly income to 2 decimal places, and order the table by descending average monthly income
SELECT
	BusinessTravel, 
	ROUND(AVG(MonthlyIncome), 2) AS 'Average Monthly Income'
FROM attrition_table
GROUP BY BusinessTravel
ORDER BY AVG(MonthlyIncome) DESC;


	