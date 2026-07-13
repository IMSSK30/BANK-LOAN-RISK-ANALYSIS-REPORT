# CUSTOMER RISK VIEW

-- Create customer risk view

CREATE VIEW customer_risk_view AS
SELECT
person_age,
person_gender,
person_income,
credit_score,
loan_amnt,
loan_percent_income,
loan_intent,
previous_loan_defaults_on_file,
loan_status,
CASE
    WHEN credit_score >= 750
    AND previous_loan_defaults_on_file = 'No'
    AND loan_percent_income < 0.3
    THEN 'Low Risk'

    WHEN credit_score BETWEEN 600 AND 750
    AND loan_percent_income BETWEEN 0.3 AND 0.5
    THEN 'Medium Risk'
    ELSE 'High Risk'
END AS risk_category
FROM loan_data;

SELECT *
FROM customer_risk_view;

-- Create loan performance view

CREATE VIEW loan_performance_view AS
SELECT
loan_intent,
COUNT(*) AS total_loans,
SUM(loan_status) AS total_defaults,
ROUND(SUM(loan_status)*100.0/COUNT(*),2) AS default_rate,
AVG(loan_amnt) AS average_loan_amount,
AVG(loan_int_rate) AS average_interest_rate
FROM loan_data
GROUP BY loan_intent;

SELECT *
FROM loan_performance_view;

-- Create customer financial view

CREATE VIEW customer_financial_view AS
SELECT
person_income,
loan_amnt,
loan_percent_income,
credit_score,
loan_status,
CASE
WHEN loan_percent_income < 0.2 THEN 'Low Burden'
WHEN loan_percent_income BETWEEN 0.2 AND 0.5 THEN 'Medium Burden'
ELSE 'High Burden'
END AS loan_burden_category
FROM loan_data;

SELECT *
FROM customer_financial_view;

SHOW FULL TABLES;