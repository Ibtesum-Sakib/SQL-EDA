Select *
FROM parks_and_recreation.employee_demographics;


Select occupation, salary
FROM parks_and_recreation.employee_salary
GROUP BY occupation, salary
;

Select gender, AVG(age), max(age), min(age), COUNT(age)
FROM parks_and_recreation.employee_demographics
GROUP BY gender
;

Select *
FROM parks_and_recreation.employee_demographics
ORDER BY gender, age
;

-- Having vs where --

Select gender, AVG(age)
FROM parks_and_recreation.employee_demographics
GROUP BY gender
HAVING AVG(age) > 40
;

SELECT occupation, AVG(salary)
FROM parks_and_recreation.employee_salary
where occupation like '%manager%'
GROUP BY occupation
HAVING AVG(salary) > 75000
;

select *
FROM parks_and_recreation.employee_demographics
order by age desc
limit 3
;

Select gender, AVG(age) AS avg_age
FROM parks_and_recreation.employee_demographics
GROUP BY gender
HAVING avg_age > 40
;


Select *
FROM parks_and_recreation.employee_demographics
;

Select *
FROM parks_and_recreation.employee_salary
;


Select dem.employee_id,age,occupation
FROM parks_and_recreation.employee_demographics as dem
INNER JOIN employee_salary as sal
	ON dem.employee_id = sal.employee_id
;

Select *
FROM parks_and_recreation.employee_demographics as dem
RIGHT JOIN employee_salary as sal
	ON dem.employee_id = sal.employee_id
;

-- self join - tie the table with itself

Select emp1.employee_id as emp_santa,
emp1.first_name as first_name_santa,
emp1.last_name as last_name_santa,
emp2.employee_id as emp_name,
emp2.first_name as first_name_emp,
emp2.last_name as last_name_emp
FROM parks_and_recreation.employee_salary emp1
join employee_salary emp2
	ON emp1.employee_id +1 = emp2.employee_id
;

