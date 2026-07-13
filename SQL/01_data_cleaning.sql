CREATE DATABASE bank_loan_analysis;
USE bank_loan_analysis;

SELECT *
FROM loan_data
LIMIT 10;

SELECT COUNT(*)
FROM loan_data;

DESCRIBE loan_data;

-- Check total records
SELECT COUNT(*) AS total_records
FROM loan_data;

-- Check missing values
SELECT *
FROM loan_data
WHERE 
person_age IS NULL
OR person_gender IS NULL
OR person_education IS NULL
OR person_income IS NULL
OR person_emp_exp IS NULL
OR person_home_ownership IS NULL
OR loan_amnt IS NULL
OR loan_intent IS NULL
OR loan_int_rate IS NULL
OR loan_percent_income IS NULL
OR cb_person_cred_hist_length IS NULL
OR credit_score IS NULL
OR previous_loan_defaults_on_file IS NULL
OR loan_status IS NULL;
-- Result: No missing values found.

-- Check duplicate records
SELECT 
COUNT(*) AS total_records,
COUNT(DISTINCT CONCAT(
person_age,
person_gender,
person_income,
loan_amnt,
loan_status
)) AS unique_records
FROM loan_data;

-- Check possible duplicate records

SELECT 
person_age,
person_gender,
person_income,
loan_amnt,
loan_status,
COUNT(*) AS count_rows
FROM loan_data
GROUP BY 
person_age,
person_gender,
person_income,
loan_amnt,
loan_status
HAVING COUNT(*) > 1;

-- Check exact duplicate records

SELECT 
COUNT(*) AS total_rows,
COUNT(DISTINCT CONCAT_WS('|',
person_age,
person_gender,
person_education,
person_income,
person_emp_exp,
person_home_ownership,
loan_amnt,
loan_intent,
loan_int_rate,
loan_percent_income,
cb_person_cred_hist_length,
credit_score,
previous_loan_defaults_on_file,
loan_status
)) AS unique_rows
FROM loan_data;
-- Observation: No exact duplicate records found.

-- Check gender categories
SELECT DISTINCT person_gender
FROM loan_data;

-- Check education categories
SELECT DISTINCT person_education
FROM loan_data;

-- Check home ownership categories
SELECT DISTINCT person_home_ownership
FROM loan_data;

-- Check loan intent categories
SELECT DISTINCT loan_intent
FROM loan_data;

-- Check previous defaults
SELECT DISTINCT previous_loan_defaults_on_file
FROM loan_data;

-- Check loan status values
SELECT DISTINCT loan_status
FROM loan_data;

-- Check age range
SELECT 
MIN(person_age) AS minimum_age,
MAX(person_age) AS maximum_age
FROM loan_data;

-- Check income range
SELECT 
MIN(person_income) AS minimum_income,
MAX(person_income) AS maximum_income
FROM loan_data;

-- Check loan amount range
SELECT 
MIN(loan_amnt) AS minimum_loan,
MAX(loan_amnt) AS maximum_loan
FROM loan_data;

-- Check interest rate range
SELECT 
MIN(loan_int_rate) AS minimum_interest_rate,
MAX(loan_int_rate) AS maximum_interest_rate
FROM loan_data;

-- Check credit score range
SELECT 
MIN(credit_score) AS minimum_credit_score,
MAX(credit_score) AS maximum_credit_score
FROM loan_data;

-- Check loan burden range
SELECT 
MIN(loan_percent_income) AS minimum_percentage,
MAX(loan_percent_income) AS maximum_percentage
FROM loan_data;

-- Check negative income
SELECT *
FROM loan_data
WHERE person_income < 0;

-- Check invalid loan amount
SELECT *
FROM loan_data
WHERE loan_amnt <= 0;

-- Check credit score
SELECT *
FROM loan_data
WHERE credit_score <= 0;





