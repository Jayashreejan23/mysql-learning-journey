/*
==================================================
Project      : Employee Management System
Version      : 1.0
Day : 02
Author       : Jayashree S
Database     : MySQL
Description  : A beginner SQL project demonstrating
               database creation, CRUD operations,
               filtering, sorting, aggregation,
               updates, and table modifications.
Topics Covered:
- SELECT
- WHERE
- ORDER BY
- GROUP BY
- HAVING
- INNER JOIN
- LEFT JOIN
- RIGHT JOIN
- Aggregate + JOIN
- UPDATE
- DELETE
- Basic Subqueries
- Correlated Subqueries
Created On   : July 2026
==================================================
*/
create database employee_management; -- create a database
use employee_management; -- use the current database
-- create department table 
create table department(
department_id int primary key,
department_name varchar(20),
location varchar(20)
); 
-- insert values
insert into department values
(101, 'HR', 'Chennai'),
(102, 'IT', 'Bangalore'),
(103, 'Finance', 'Mumbai'),
(104, 'Marketing', 'Delhi'); 
-- create employees table 
create table employees(
employee_id int primary key,
first_name varchar(20),
last_name varchar(20),
salary int,
department_id int, 
experience int); 
-- insert values
insert into employees values 
(1, 'Asha','Iyer', 45000, 101, 2),
(2, 'Rahul','Verma', 75000, 102, 5),
(3, 'Sneha','Nair', 68000, 102, 4),
(4, 'Kiran','Reddy', 52000, 103, 3),
(5, 'Priya','Rao', 47000, 101, 2),
(6, 'Arjun','Patel', 80000, 102, 6),
(7, 'Meera','Singh', 60000, 104, 4),
(8, 'Rohit','Das', 55000, 103, 3),
(9, 'Anu','Sharma', 72000, 104, 5),
(10, 'Jay','Kumar', 50000, 101, 1);

select * from employees; -- Display all employees.
select * from department; -- Display all departments.
select first_name, last_name, salary from employees; -- Display employee names and salaries.
select first_name, last_name, salary from employees where salary > 60000; -- Find employees earning more than 60,000.
select first_name, last_name, experience from employees where experience > 3; -- Find employees with more than 3 years of experience.
select * from employees order by salary Desc; -- Sort employees by salary (highest first).
select * from employees where first_name like 'A%';-- Find employees whose first name starts with 'A'.

-- Group By
select department_id, count(*) count from employees group by department_id;  -- Count employees in each department.
select department_id, avg(salary) avg_salary from employees group by department_id;-- Find the average salary of each department.
select department_id, max(salary) highest_salary from employees group by department_id; -- Find the highest salary in each department.
select department_id, min(salary) lowest_salary from employees group by department_id; -- Find the lowest salary in each department.
select department_id, sum(salary) total_salary from employees group by department_id; -- Find the total salary paid in each department.

-- Having
select department_id, count(*) count from employees group by department_id having count(*) > 2; -- Show departments having more than 2 employees.
select department_id, avg(salary) as Avg_salary from employees group by department_id having avg(salary) > 60000; -- Show departments where the average salary is above 60,000.
select department_id, sum(salary) as total_salary from employees group by department_id having sum(salary) > 150000; -- Show departments whose total salary exceeds 150,000.

-- inner join 
Select first_name, department_name from employees inner join department on employees.department_id = department.department_id; -- Display employee name with department name.
Select first_name, department_name, location from employees inner join department on employees.department_id = department.department_id; -- Display employee name, department name and location.
Select first_name, department_name from employees inner join department on employees.department_id = department.department_id where department_name ='IT'; -- Find all employees working in the IT department.
Select * from employees inner join department on employees.department_id = department.department_id where location ='Chennai'; -- Find employees working in Chennai.
Select first_name, location from employees inner join department on employees.department_id = department.department_id; -- Display employee name and department location.

-- left join 
insert into department values (105, 'Legal', 'Hyderabad'); -- Add a new department: 105, Legal, Hyderabad without adding employees.
select department_name, first_name, employee_id from department left join employees on employees.department_id = department.department_id ; -- Display all departments including those without employees.
select d.department_name, e.first_name, e.employee_id from department d left join employees e on e.department_id = d.department_id where e.employee_id is null; -- Show only departments that don't have any employees.

-- right join 
select d.* , e.first_name from employees e right join department d on e.department_id = d.department_id; -- Display all departments even if they don't have employees.

-- Agrregate + Join
select d.department_name, avg(e.salary) Average_salary from employees e inner join department d on e.department_id = d.department_id group by d.department_name; -- Find average salary by department name.
select d.department_name, max(e.salary)as Highest_salary from employees e inner join department d on e.department_id = d.department_id group by d.department_name; -- Find highest paid employee in each department.
select d.department_name, count(e.employee_id) as count from employees e inner join department d on e.department_id = d.department_id group by d.department_name; -- Count employees department-wise.
select d.department_name, sum(e.salary)as Total_salary from employees e inner join department d on e.department_id = d.department_id group by d.department_name; -- Find total salary department-wise.

-- update/Delete 
update employees set salary = salary * 1.10 where department_id = 102; -- Increase IT employees salary by 10%.
update department set location = 'Pune' where department_name = 'Marketing'; -- Change Marketing location to Pune.
delete from employees where experience < 2; -- Delete employees with less than 2 years of experience.

-- challenge qns 
select salary from employees order by salary desc limit 1 offset 1;  -- Find the second highest salary.
select e.first_name, e.salary , e.department_id from employees e where e.salary > (select avg(e2.salary) from employees e2 where e2.department_id=e.department_id); -- Find employees earning above their department's average salary.
select avg(salary) from employees group by salary order by avg(salary) desc limit 1;  -- Find the department with the highest average salary.
select first_name, salary from employees where salary between 50000 and 70000; -- Display employees whose salary is between 50,000 and 70,000.
select salary, count(*) total  from employees group by salary having count(*)  > 1;-- Find duplicate salaries (if any).
