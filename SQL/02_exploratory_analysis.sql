# OVERALL LOAN PORTFOLIO OVERVIEW

-- Total loan applications
SELECT COUNT(*) AS total_applications
FROM loan_data;

-- Total loan amount
SELECT 
SUM(loan_amnt) AS total_loan_amount
FROM loan_data;

-- Average loan amount
SELECT 
AVG(loan_amnt) AS average_loan_amount
FROM loan_data;

-- Average customer income
SELECT 
AVG(person_income) AS average_income
FROM loan_data;

# LOAN DEFAULT OVERVIEW

-- Loan status distribution
SELECT 
loan_status,
COUNT(*) AS total_customers
FROM loan_data
GROUP BY loan_status;

-- Overall default rate
SELECT
ROUND(SUM(loan_status) * 100.0 / COUNT(*),2) AS default_rate_percentage
FROM loan_data;

# DEFAULT ANALYSIS BY CUSTOMER DEMOGRAPHICS

-- Default rate by gender

SELECT
person_gender,
COUNT(*) AS total_customers,
SUM(loan_status) AS total_defaults,
ROUND(SUM(loan_status)*100.0/COUNT(*),2) AS default_rate
FROM loan_data
GROUP BY person_gender;

-- Default rate by education

SELECT
person_education,
COUNT(*) AS total_customers,
SUM(loan_status) AS total_defaults,
ROUND(SUM(loan_status)*100.0/COUNT(*),2) AS default_rate
FROM loan_data
GROUP BY person_education
ORDER BY default_rate DESC;

-- Default rate by home ownership

SELECT
person_home_ownership,
COUNT(*) AS total_customers,
SUM(loan_status) AS total_defaults,
ROUND(SUM(loan_status)*100.0/COUNT(*),2) AS default_rate
FROM loan_data
GROUP BY person_home_ownership
ORDER BY default_rate DESC;

-- Default rate by loan purpose

SELECT
loan_intent,
COUNT(*) AS total_loans,
SUM(loan_status) AS defaults,
ROUND(SUM(loan_status)*100.0/COUNT(*),2) AS default_rate
FROM loan_data
GROUP BY loan_intent
ORDER BY default_rate DESC;

# CREDIT RISK ANALYSIS

-- Default rate by credit score

SELECT
credit_score,
COUNT(*) AS total_customers,
SUM(loan_status) AS total_defaults,
ROUND(SUM(loan_status)*100.0/COUNT(*),2) AS default_rate
FROM loan_data
GROUP BY credit_score
ORDER BY credit_score;

-- Default rate by credit score category

SELECT
CASE
    WHEN credit_score < 600 THEN 'Poor'
    WHEN credit_score BETWEEN 600 AND 700 THEN 'Average'
    WHEN credit_score BETWEEN 701 AND 750 THEN 'Good'
    ELSE 'Excellent'
END AS credit_category,
COUNT(*) AS total_customers,
SUM(loan_status) AS total_defaults,
ROUND(SUM(loan_status)*100.0/COUNT(*),2) AS default_rate
FROM loan_data
GROUP BY credit_category
ORDER BY default_rate DESC;

-- Default rate by previous loan defaults

SELECT
previous_loan_defaults_on_file,
COUNT(*) AS total_customers,
SUM(loan_status) AS total_defaults,
ROUND(SUM(loan_status)*100.0/COUNT(*),2) AS default_rate
FROM loan_data
GROUP BY previous_loan_defaults_on_file;

-- Default rate by income group

SELECT
CASE
    WHEN person_income < 50000 THEN 'Low Income'
    WHEN person_income BETWEEN 50000 AND 100000 THEN 'Middle Income'
    ELSE 'High Income'
END AS income_group,
COUNT(*) AS total_customers,
SUM(loan_status) AS total_defaults,
ROUND(SUM(loan_status)*100.0/COUNT(*),2) AS default_rate
FROM loan_data
GROUP BY income_group
ORDER BY default_rate DESC;

# LOAN RISK ANALYSIS

-- Default rate by loan purpose

SELECT
loan_intent,
COUNT(*) AS total_loans,
SUM(loan_status) AS total_defaults,
ROUND(SUM(loan_status)*100.0/COUNT(*),2) AS default_rate
FROM loan_data
GROUP BY loan_intent
ORDER BY default_rate DESC;

-- Default rate by loan amount category

SELECT
CASE
    WHEN loan_amnt < 10000 THEN 'Small Loan'
    WHEN loan_amnt BETWEEN 10000 AND 25000 THEN 'Medium Loan'
    ELSE 'Large Loan'
END AS loan_category,
COUNT(*) AS total_loans,
SUM(loan_status) AS total_defaults,
ROUND(SUM(loan_status)*100.0/COUNT(*),2) AS default_rate
FROM loan_data
GROUP BY loan_category
ORDER BY default_rate DESC;

-- Default rate by interest rate category

SELECT
CASE
    WHEN loan_int_rate < 10 THEN 'Low Interest'
    WHEN loan_int_rate BETWEEN 10 AND 15 THEN 'Medium Interest'
    ELSE 'High Interest'
END AS interest_category,
COUNT(*) AS total_loans,
SUM(loan_status) AS defaults,
ROUND(SUM(loan_status)*100.0/COUNT(*),2) AS default_rate
FROM loan_data
GROUP BY interest_category
ORDER BY default_rate DESC;

-- Default rate by loan burden

SELECT
CASE
    WHEN loan_percent_income < 0.2 THEN 'Low Burden'
    WHEN loan_percent_income BETWEEN 0.2 AND 0.4 THEN 'Medium Burden'
    ELSE 'High Burden'
END AS burden_category,
COUNT(*) AS total_customers,
SUM(loan_status) AS defaults,
ROUND(SUM(loan_status)*100.0/COUNT(*),2) AS default_rate
FROM loan_data
GROUP BY burden_category
ORDER BY default_rate DESC;

