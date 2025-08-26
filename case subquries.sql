-- case
SELECT first_name,
last_name,
age,
CASE
	WHEN age <= 30 THEN 'Young'
    WHEN age BETWEEN 31 AND 50 THEN 'Old'
    WHEN age >= 50 THEN 'One leg inside soil'
END AS LIFEISSHORT
FROM employee_demographics
;

-- pay Increase and Bonus
-- <50000 = 5
-- >50000 = 7
-- Fin = 10% bonus

SELECT first_name, last_name, salary,
CASE
	WHEN salary < 50000 THEN salary * 1.05
    WHEN salary > 50000 THEN salary * 1.07
END AS New_Salary,
CASE
	WHEN dept_id = 6 THEN salary * 1.10
END as Incentive
FROM employee_salary
; 
SELECT *
FROM employee_salary;
-- subqueries

SELECT *
FROM employee_demographics
WHERE employee_id IN
				( select employee_id
					FROM employee_salary
                    WHERE dept_id = 1
)
;

SELECT first_name, salary,
(SELECT AVG(salary)
FROM employee_salary
)
FROM employee_salary;

Select AVG(max_age)
FROM
(select gender,
AVG(age) as avg_age, 
MAX(age) as max_age, 
MIN(age) as min_age, 
COUNT(age) as count_age
from employee_demographics
GROUP BY gender) as Agg_table
;
