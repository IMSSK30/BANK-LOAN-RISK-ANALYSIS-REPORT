# RISK SEGMENTATION ANALYSIS

-- Customer risk segmentation

SELECT
CASE
    WHEN credit_score >= 750 
    AND previous_loan_defaults_on_file = 'No'
    AND loan_percent_income < 0.3
    THEN 'Low Risk'

    WHEN credit_score BETWEEN 600 AND 750
    AND loan_percent_income BETWEEN 0.3 AND 0.5
    THEN 'Medium Risk'
    ELSE 'High Risk'
END AS risk_category,
COUNT(*) AS total_customers,
SUM(loan_status) AS total_defaults,
ROUND(SUM(loan_status)*100.0/COUNT(*),2) AS default_rate
FROM loan_data
GROUP BY risk_category
ORDER BY default_rate DESC;

-- Rank loan purposes based on default rate

SELECT
loan_intent,
COUNT(*) AS total_loans,
SUM(loan_status) AS total_defaults,
ROUND(SUM(loan_status)*100.0/COUNT(*),2) AS default_rate,
RANK() OVER(
ORDER BY ROUND(SUM(loan_status)*100.0/COUNT(*),2) DESC
) AS risk_rank
FROM loan_data
GROUP BY loan_intent;

-- Count high risk customers

SELECT
COUNT(*) AS high_risk_customers
FROM loan_data
WHERE credit_score < 600
OR previous_loan_defaults_on_file = 'Yes'
OR loan_percent_income > 0.5;

-- Risk category distribution

SELECT
CASE
    WHEN credit_score >= 750 
    AND previous_loan_defaults_on_file = 'No'
    AND loan_percent_income < 0.3
    THEN 'Low Risk'

    WHEN credit_score BETWEEN 600 AND 750
    AND loan_percent_income BETWEEN 0.3 AND 0.5
    THEN 'Medium Risk'
	ELSE 'High Risk'
END AS risk_category,
COUNT(*) AS total_customers,
ROUND(COUNT(*)*100.0/(SELECT COUNT(*) FROM loan_data),2) AS percentage
FROM loan_data
GROUP BY risk_category;

-- Default rate by employment experience

SELECT
CASE
    WHEN person_emp_exp <= 2 THEN 'Low Experience'
    WHEN person_emp_exp BETWEEN 3 AND 10 THEN 'Medium Experience'
    ELSE 'High Experience'
END AS experience_group,
COUNT(*) AS total_customers,
SUM(loan_status) AS total_defaults,
ROUND(SUM(loan_status)*100.0/COUNT(*),2) AS default_rate
FROM loan_data
GROUP BY experience_group
ORDER BY default_rate DESC;

-- Default rate by age group

SELECT
CASE
    WHEN person_age < 25 THEN 'Young'
    WHEN person_age BETWEEN 25 AND 40 THEN 'Adult'
    WHEN person_age BETWEEN 41 AND 60 THEN 'Middle Age'
    ELSE 'Senior'
END AS age_group,
COUNT(*) AS total_customers,
SUM(loan_status) AS total_defaults,
ROUND(SUM(loan_status)*100.0/COUNT(*),2) AS default_rate
FROM loan_data
GROUP BY age_group
ORDER BY default_rate DESC;

-- Identify high risk customer profiles

SELECT
person_age,
person_income,
credit_score,
loan_amnt,
loan_percent_income,
loan_intent,
loan_status
FROM loan_data
WHERE 
credit_score < 600
AND loan_percent_income > 0.5
AND previous_loan_defaults_on_file = 'Yes'
ORDER BY loan_percent_income DESC;

