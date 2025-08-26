-- window function

select gender, AVG(salary) as avg_salary
from employee_demographics as dem
JOIN employee_salary as sal
	ON dem.employee_id = sal.employee_id
GROUP BY gender;



select dem.first_name, dem.last_name, gender, AVG(salary) OVER(partition by gender) 
from employee_demographics as dem
JOIN employee_salary as sal
	ON dem.employee_id = sal.employee_id;
    
    
select dem.first_name, dem.last_name, gender,salary, 
SUM(salary) OVER(partition by gender order by dem.employee_id) as Rolling_Total
from employee_demographics as dem
JOIN employee_salary as sal
	ON dem.employee_id = sal.employee_id;
-- CTES

WITH CTE_Example AS
(
select gender, AVG(salary) avg_sal, MAX(salary) max_sal, MIN(salary) min_sal, COUNT(salary) count_sal
from employee_demographics as dem
JOIN employee_salary as sal
	ON dem.employee_id = sal.employee_id
GROUP BY gender
)

SELECT AVG(avg_sal)
FROM CTE_Example;


