SELECT first_name, last_name, 'Old Gentelman' AS Label
FROM employee_demographics
WHERE age > 40 AND gender = 'male'
UNION
SELECT first_name, last_name, 'Old Lady' AS Label
FROM employee_demographics
WHERE age > 40 AND gender = 'female'
UNION
SELECT first_name, last_name, 'Highly Paid Employee' AS Label
FROM employee_salary
WHERE salary > 70000
ORDER BY first_name, last_name
;

-- string

SELECT LENGTH ('skyfall');

SELECT first_name, LENGTH(first_name)
FROM employee_demographics
ORDER BY 2
;

SELECT UPPER('Bochum');
SELECT LOWER('BOCHUM');

SELECT first_name, UPPER(first_name)
FROM employee_demographics;

SELECT RTRIM('          sky         ');

SELECT first_name,
LEFT(first_name, 4),
RIGHT(first_name,4),
SUBSTRING(first_name,3,2),
SUBSTRING(birth_date,6,2) as birth_month
FROM employee_demographics;

SELECT first_name, last_name,
CONCAT(first_name,' ',last_name) as Full_name
FROM employee_demographics;



