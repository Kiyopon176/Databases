select lastname from employees;

select distinct lastname from employees;

select * from employees where lastname = 'Smith';

select * from employees where lastname = 'Smith' or lastname = 'Doe';

select * from employees where department = 14;

select * from employees where department = 37 or department = 77;

select sum(budget) from departments;

SELECT department, COUNT(*) FROM employees GROUP BY department;

SELECT department, count(*) FROM employees INNER JOIN departments
    ON department = code GROUP BY department HAVING COUNT(*) > 2;

select max(budget) from departments
where budget not in (select max(budget) from departments);

select name, lastname from employees where department in
(select departments.code from departments where budget in
(select min(budget) from departments));

select customers.name, lastname from customers
where city = 'Almaty'
union
select employees.name, lastname from employees
where city = 'Almaty';
/* names were overlapping so i took lastnames too */

select * from departments
where budget > 60000
order by budget, code desc;

update departments
set budget = budget * 0.9
where budget = (select min(budget)
                from departments);

update employees
set department = 14
where department = 77;

delete from employees
where department = 14;

delete from employees;