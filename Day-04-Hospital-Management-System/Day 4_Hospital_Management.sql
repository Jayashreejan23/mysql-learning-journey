/*
==================================================
Project      : Hospital Management System
Version      : 1.0
Author       : Jayashree S
Database     : MySQL
Description  : An intermediate SQL project
               demonstrating database creation,
               CRUD operations, filtering,
               sorting, aggregate functions,
               GROUP BY, HAVING, JOINs,
               subqueries, SQL Views,
               and Indexes through a Hospital
               Management System.
Created On   : July 2026
==================================================
*/
create database hospital_management;
use hospital_management;
drop table doctors;
create table doctors(
doctor_id int primary key,
doctor_name varchar(50),
specialization varchar(50),
city varchar(50));
insert into doctors values
(101,'Dr.Mehta','Cardiologist','Chennai'),
(102,'Dr.Priya','Neurologist','Bangalore'),
(103,'Dr.Khan','Orthopedic','Hydrabad'),
(104,'Dr.John','Pediatrician','Chennai'),
(105,'Dr.Sharma','Dermatologist','Delhi'),
(106,'Dr.Anjali','General Physician','Pune'); 
create table patients(
patient_id int primary key,
patient_name varchar(50),age int,gender varchar(30),
disease varchar(50),doctor_id int,bill_amount int); 
insert into patients values
(1,'Arjun',35,'Male','Heart Disease',101,65000),
(2,'Meera',24,'Female','Migraine',102,18000),
(3,'Ravi',42,'Male','Fracture',103,45000),
(4,'Sneha',8,'Female','Fever',104,8000),
(5,'Karan',31,'Male','Skin Allergy',105,12000),
(6,'Divya',28,'Female','Diabetes',106,22000),
(7,'Mohan',50,'Male','Heart Disease',101,70000),
(8,'Asha',16,'Female','Fever',104,9000),
(9,'Vikram',38,'Male','Migraine',102,20000),
(10,'Nisha',46,'Female','Arthritis',103,55000);

-- Basics
select * from patients; -- Display all patients.
select patient_name, age from patients where age > 30;-- Find patients older than 30.
select patient_name, gender from patients where gender='Female';-- Find female patients.
select patient_name, disease from patients where disease='Heart Disease';-- Find Heart Disease patients.
select patient_name, bill_amount from patients order by bill_amount desc; -- Sort patients by bill amount (highest first).
select distinct disease from patients; -- Display distinct diseases.
select patient_name from patients where patient_name like 'A%';-- Find patient names starting with "A".

-- Aggregate Functions
select count(*) as total_count from patients; -- Count total patients.
select avg(bill_amount) as avg_bill_amount from patients; -- Average bill amount.
select max(bill_amount) as highest_bill_amount from patients; -- Highest bill.
select min(bill_amount) as lowest_bill_amount from patients; -- Lowest bill.
select sum(bill_amount) as sum_of_bill_amount from patients; -- Total hospital revenue.

-- GROUP BY
select disease, count(*) as no_of_patients from patients group by disease; -- Count patients by disease.
select disease, avg(bill_amount) as avg_bill_amount_of_disease from patients group by disease; -- Average bill by disease.
select disease, sum(bill_amount) as sum_amount_of_disease from patients group by disease; -- Total revenue by disease.

-- HAVING
select disease, count(*) as no_of_patients_greater_than_one from patients group by disease having no_of_patients_greater_than_one >1;-- Diseases having more than one patient.
select disease, avg(bill_amount) as avg_bill_amount_above_30k from patients group by disease having avg_bill_amount_above_30k > 30000;-- Diseases with average bill above ₹30,000.

-- INNER JOIN
select patient_name, doctor_name from patients p inner join doctors d on p.doctor_id=d.doctor_id; -- Patient name with doctor name.
select patient_name, city from patients p inner join doctors d on p.doctor_id=d.doctor_id where city='chennai';-- Patients treated in Chennai.
select patient_name as heart_disease_patient, doctor_name from patients p inner join doctors d on p.doctor_id=d.doctor_id where disease='heart disease'; -- Heart Disease patients with doctor names.
select patient_name, disease, city as doctors_city from patients p inner join doctors d on p.doctor_id=d.doctor_id; -- Show doctor city along with patient details.

-- LEFT JOIN
-- Add one doctor with no patients
insert into doctors values (107,'Dr. Thomas','ENT','Kochi');
select doctor_name, patient_name from doctors d left join patients p on p.doctor_id=d.doctor_id; -- Show all doctors and their patients.
select doctor_name from doctors d left join patients p on d.doctor_id=p.doctor_id where patient_name is null;-- Show doctors with no patients.

-- RIGHT JOIN
-- Add one patient whose doctor doesn't exist:
insert into patients values (11,'Unknown Patient',29,'Male','Unknown',999,5000);
select patient_name, doctor_name from doctors d right join patients p on p.doctor_id=d.doctor_id; -- Show all patients even if doctor details are missing.
select patient_name, doctor_name from doctors d right join patients p on d.doctor_id=p.doctor_id where doctor_name is null; -- Find patients without doctor details.

-- UPDATE / DELETE
update patients set bill_amount=bill_amount*1.10 where doctor_id in (select doctor_id from doctors where specialization = 'Cardiology'); -- Increase Cardiology patients' bills by 10%.
update doctors set city = 'Mumbai' where doctor_name = 'Dr.Sharma'; -- Change Dr. Sharma's city to Mumbai.
delete from patients where bill_amount < 10000; -- Delete patients with bills below ₹10,000.

-- Subqueries
select patient_name from patients where bill_amount > (select avg(bill_amount) from patients);-- Find patients whose bill is above the average bill.
select patient_name from patients order by bill_amount desc limit 1;-- Find the highest bill.
select patient_name, doctor_name from patients p join doctors d on p.doctor_id=d.doctor_id where doctor_name like 'Dr.Mehta';-- Find patients treated by Dr. Mehta.
select patient_name from patients p where p.bill_amount > (select avg(p2.bill_amount) from patients p2 where p2.disease=p.disease);-- Find patients whose bill is above their disease's average bill.

-- Views
-- Create a view showing:Patient Name, Doctor Name, Specialization, Bill Amount
create view patient_details as select p.patient_name, p.disease, d.doctor_name, d.specialization, p.bill_amount from patients p join doctors d on p.doctor_id=d.doctor_id;
select * from patient_details; -- Display all records from the view.
select * from patient_details where disease = 'heart disease';-- Show only Heart Disease patients using the view.
select patient_name from patient_details where bill_amount > 50000; -- Show patients with bills above ₹50,000 using the view.
drop view patient_details; -- Drop the view.

-- Indexes
create index idx_patient_name ON patients(patient_name); -- create index
show index from patients; -- display index
drop index idx_patient_name on patients; -- drop index

-- Challenge Questions
select doctor_name, count(patient_name) as total_patients from doctors d join patients p on d.doctor_id=p.doctor_id group by doctor_name order by total_patients desc limit 1;-- Which doctor has treated the highest number of patients?
select disease, sum(bill_amount) as highest_total_revenue from patients p group by disease order by highest_total_revenue desc limit 1;  -- Which disease generated the highest total revenue?
select city, count(doctor_name) as no_of_doctors from doctors group by city order by no_of_doctors desc limit 1; -- Which city has the most doctors?
select bill_amount from patients order by bill_amount desc;-- show all the bill amount
select max(bill_amount) as second_highest_total_revenue from patients p where bill_amount < (select max(bill_amount) from patients);  -- Find the second-highest hospital bill.
select d.doctor_name, avg(p.bill_amount) as avg_bill  from doctors d join patients p on d.doctor_id=p.doctor_id group by d.doctor_name having avg(p.bill_amount) > (select avg(bill_amount) from patients); -- Find doctors whose patients' average bill is greater than the overall average bill.