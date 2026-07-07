/*
==================================================
Project      : Student Management System
Version      : 1.0
Author       : Jayashree S
Database     : MySQL
Description  : A beginner SQL project demonstrating
               database creation, CRUD operations,
               filtering, sorting, aggregation,
               updates, and table modifications.
Created On   : July 2026
==================================================
*/

create database student_management; -- Create Database
use student_management; -- use Database
show tables; -- displayes the tables in the database
create table student(
student_id int primary key,
first_name varchar(20) not null,
last_name varchar(20) not null,
age int,
course varchar(20),
city varchar(20),
marks int); -- Create Table

insert into student values  -- Insert Sample Data
(1, "Jay", "kumar", 22, "MBA", "Chennai", 88),
(2, "Anu", "sharma", 21, "MBA", "Bangalore", 92),
(3, "Rahul", "Verma", 23, "BBA", "Hyderabad", 76),
(4, "Priya", "Rao", 20, "MBA", "Chennai", 81),
(5, "Arjun", "patel", 24, "Bcom", "Mumbai", 69),
(6, "Sneha", "Nair", 22, "MBA", "Kochi", 95),
(7, "Kiran", "Reddy", 23, "BBA", "Hyderabad", 73),
(8, "Meera", "Singh", 23, "MBA", "Delhi", 89),
(9, "Rohit", "Das", 22, "Bcom", "Kolkata", 67),
(10, "Asha", "Iyer", 20, "MBA", "Chennai", 91);

show tables; -- shows the tables in the database

-- easy -- Basic SELECT Queries
select * from student; -- display all students
alter table student rename to student_details; -- Rename the table to student_details.
select first_name, marks from student_details; -- Display only first name and marks
select * from student_details where city="Chennai";  -- Show students from Chennai.
select * from student_details where marks > 85;-- Show students whose marks are above 85.
select * from student_details where course = "MBA"; -- Show MBA students.
select * from student_details where age > 21; -- Show students older than 21.
select * from student_details order by marks desc; -- Sort students by marks (highest first).
select * from student_details order by first_name asc; -- Sort students alphabetically by first name.

-- medium
select count(*) from student_details;  -- Count total students.
select avg(marks) from student_details; -- Find average marks.
select max(marks) from student_details; -- Find highest marks.
select min(marks) from student_details; -- Find lowest marks.
select * from student_details where marks between 80 and 90; -- Show students whose marks are between 80 and 90.
select * from student_details where first_name LIKE "A%"; -- Show students whose name starts with "A".
select * from student_details where city = "Chennai" and marks > 85;-- Show students from Chennai who scored above 85.
select * from student_details order by marks desc limit 3; -- Show top 3 scorers.
select course, COUNT(*) as total_students from student_details group by course; -- Find how many students belong to each course.
select course, Avg(marks) as Average_marks from student_details group by course;-- Find average marks for each course.

-- update/delete functions
update student_details set marks = 82 where student_id = 3;-- Change Rahul's marks from 76 to 82.
update student_details set city = "bangalore" where student_id = 4; -- Change Priya's city to Bangalore.
delete from student_details where student_id = 9; -- Delete the student whose ID is 9.
insert into student_details values (11, "rebacca" , "shaw", 23, "Bcom", "Chennai", 73); -- Add a new student of your choice.

-- Advanced Beginner
alter table student_details add phone_number varchar(15);-- Add a new column called phone_number.
update student_details set phone_number = "9003034041" where student_id = 1;
update student_details set phone_number = "3430905657" where student_id = 5;
update student_details set phone_number = "6760234511" where student_id = 10;
-- Update phone numbers for at least three students.
alter table student_details drop column phone_number; -- Drop the phone_number column (if your SQLite version supports it).
select DISTINCT city from student_details; -- Display only distinct cities.
select * from student_details where marks > ( select avg(marks) from student_details);-- Find students whose marks are greater than the average marks.