select *
from parks_and_recreation.employee_salary
where first_name= 'Leslie' ;

select *
from parks_and_recreation.employee_salary
where salary >= 45000+5000;

select *
from parks_and_recreation.employee_salary
where salary <= 45000+5000;

select *
from parks_and_recreation.employee_demographics
where birth_date >'1985-01-01'
;
select *
from parks_and_recreation.employee_demographics
where birth_date >'1985-01-01'
OR gender = 'male'
;
select *
from parks_and_recreation.employee_demographics
where (first_name = 'Leslie' AND age = 44) OR age > 60
;
-- % = anything _ = any value --
select *
from parks_and_recreation.employee_demographics
where birth_date LIKE '1989%'
;
