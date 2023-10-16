# Employee Attrition Analysis and Logistic Regression Model 

## About the Dataset

In this project, I made use of a fictional dataset created by IBM data scientists that contained employee attributes (such as department, performance rating, number of years with the company, etc.), employee survey responses (on topics such as work-life balance, job satisfaction, etc.), and whether or not the employee left the company. 
    
LINK: https://www.kaggle.com/datasets/pavansubhasht/ibm-hr-analytics-attrition-dataset

## Visualizing

Before beginning to create a predictive model and analyze the dataset, I first created an interactive Tableau dashboard to visualize its key metrics. This both helped me get a general overview of the workforce, as well as inspect specific segments of it more closely because of its filtering options. 

LINK: https://public.tableau.com/app/profile/aj.arbuckle/viz/HRAnalyticsDashboard_16963456456300/Dashboard1

## Modeling 

I then created a logistic regression model that predicted whether or not an employee would leave the company based on all the other information available in the dataset. To prepare the data for modeling, I eliminated irrelevant features (employee ID and columns that had the same value for all employees); one-hot encoded non-ordinal categorical features; assigned numerical values to the ordinal categorical features; and scaled other numerical features. I then trained the model, calculated performance metrics, analyzed feature importance, and determined which feature coefficients were statistically significant. 

## Results 

**Performance Metrics:**

Model Accuracy: 89.34%

Model Precision: 79.49%

Model Sensitivity: 44.29%

Model Specificity: 97.84%

**Statistically Significant Features:**

OverTime_No: Coefficient = -0.907 (p = .04)

OverTime_Yes: Coefficient = 0.905 (p = .04)

JobRole_Sales Representative: Coefficient =	0.839 (p < .001)

EducationField_Human Resources:	Coefficient = 0.625 (p < .001)

JobRole_Research Director: Coefficient = -0.531 (p = .02)

## Interpretation

This model is on the whole fairly accurate, as nearly 90% of its predictions were correct. It had very high specificity, meaning that it very rarely predicted that an employee would leave the company when they actually didn't. Conversely, it had relatively low sensitivity, meaning that it only detected that an employee had left the company about 50% of the time. To improve this model, it may be wise to aim for a higher sensitivity at the cost of specificity, as it would likely be more costly to the company to fail to detect that an employee will leave than to inaccurately predict that an employee will leave. 

By far the most influential feature in the model was whether the employee worked overtime, with those who worked overtime being more likely to leave the company than those who did not. This suggests that the company should investigate differences between employees who do and don't work overtime, and possibly re-evaluate its overtime policy. Being a Sales Representatives also seemed to influence employees to leave the company, while being a Research Director seemed to be a protective factor against attrition. This difference suggests that the company may need to investigate differences between employees with different job titles. Lastly, having studied Human Resources seemed to be associated with an increased probability of leaving the company. Educational background is less clearly related to attrition than the other statistically significant features, so while it may be a good idea for the company to investigate differences between employees with different academic backgrounds, this association may best be explored with qualitative data, such as from interviews. 

## Ad-Hoc Analyses

In the SQL file, I segmented the dataset by the most influential features in the model to further investigate differences in job satisfaction ratings and performance ratings. I also investigated differences in pay and work-life balance ratings between employees who do or do not work overtime, and interestingly, there was also very little difference between the two groups along these metrics. This suggests that there may be some other reason that working overtime influences employees to leave the company other than just the number of hours worked. In the same file, I also answered many other questions that an HR Business Partner might pose about this dataset for ad-hoc analyses, such as "What is the average number of years in their current role for employees with a Job Involvement rating of 4?", "Which department has the highest percentage of employees who work overtime?", and "How is the amount of busines travel employees do related to their monthly income?"

    
