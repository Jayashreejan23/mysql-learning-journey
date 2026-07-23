/* ================================================== 
Project : Library Management System 
Version : 1.0 
Author : Jayashree S 
Database : MySQL 
Description : An intermediate SQL project demonstrating database creation, 
              table relationships, CRUD operations, filtering, sorting, aggregate functions, 
			  GROUP BY, HAVING, JOINs, subqueries, and SQL Views through a Library Management System. 
Created On : July 2026 
================================================== */
create database library_management; -- create a database
use library_management;
show tables; -- To view existing tables
create table authors(
author_id int primary key,
author_name varchar(20),
country varchar(30)
); -- create table authors
insert into authors values
(101, 'Chetan Bhagat', 'India'),
(102, 'J.K.Rowling', 'UK'),
(103, 'James Clear', 'USA'),
(104, 'Robin Sharma', 'Canada'),
(105, 'Sudha Murty', 'India'),
(106, 'Yuval Noah Harari', 'Israel');

create table books(
book_id int primary key,title varchar(50),author_id int,category varchar(20),price int,
published_year int); -- create table books
insert into books values
(1,'The three Mistakes of My Life',101,'Fiction',350,2008),
(2,'Harry Potter and the Philosophers stone',102,'Fantasy',650,1997),
(3,'Harry Potter and the Chambers of Secrets',102, 'Fantasy',700,1998),
(4,'Atomic Habits',103,'Self Help',550, 2018),
(5,'The Monk who sold his ferrari',104,'Self Help',450,1997),
(6,'Wise and Otherwise',105,'Biography',300,2002),
(7,'Sapiens',106,'History',800,2011),
(8,'Homo Deus',106,'History',900,2015),
(9,'Think like a Monk',104,'Self Help',600,2020),
(10,'The Magic of Thinking Big',103,'Self Help',500,1959);

-- Basic Queries
select * from books; -- Display all books
select title, price from books; -- Display book title and price
select title,price from books where price > 500; -- find books costing more than 500
select title, published_year from books where published_year > 2010; -- find books published after 2010
select title, category from books where category = 'Self Help';-- find books in the self help category
select title, author_id from books where author_id=103;-- find books written by author 103
select * from books order by price desc;-- Sort books by price (highest first)
select * from books order by title asc;-- Sort books alphabetically by title
select distinct category from books;-- Display distinct categories 
select * from books where title like "H%";-- find books whose title starts with 'H'

-- Aggreagte Functions
select count(*) as total_book_count from books; -- count total books
select avg(price) as avg_book_price from books;-- Find average book price
select max(price) as highest_book_price from books;-- Find the highest price book
select min(price) as cheapest_book_price from books;-- Find the cheapest book
select sum(price) as total_book_price from books;-- Find the total value of all books

-- Group By
select category, count(title) as books_category_count from books group by category;-- Count books in each category
select category, avg(price) as avg_category_price from books group by category;-- find average price by category
select category, max(price) as highest_category_price from books group by category; -- find highest price in each category
select category, sum(price) as total_category_price from books group by category;-- find total price of books in each category

-- Having
select category from books group by category having count(*)>2;-- show categories having more than 2 books
select category from books group by category having avg(price)>500;-- show categories whose average price greater than 500

-- Inner Join
select title, author_name from books inner join authors on books.author_id=authors.author_id;-- display book title with author name
select title, author_name, country from books inner join authors on books.author_id=authors.author_id;-- display title, author name and country
select title, author_name, country from books inner join authors on books.author_id=authors.author_id where country = 'India'; -- find books written by indian authors
select title, author_name, published_year from books inner join authors on books.author_id=authors.author_id where published_year > 2010; -- display books published after 2010 with author names
select title, category, author_name from books inner join authors on books.author_id=authors.author_id where category='Fantasy';-- display all fantasy books with author names

insert into authors values (107,'Paulo Coelho','Brazil'); -- insert new values
select * from authors;
-- Left Join
select title, author_name from books left join authors on books.author_id=authors.author_id;-- display all authors with thier books
select title, author_name from authors left join books on authors.author_id=books.author_id where books.author_id is null; -- show authors who don't have any books

insert into books values(11,'Unknown Book',999,'Mystery',400,2024);
select * from books;
-- Rigth Join
select title,author_name from authors right join books on books.author_id=authors.author_id; -- display all books even if author detials are missing
select title, author_name from authors right join books on books.author_id=authors.author_id where authors.author_name is null;-- find books whose author detials are unavailable

-- update/Delete
update books set price = price * 1.10 where category = 'Self Help';-- increase the price of all self help books by 10%
update books set category = 'Memoir' where category = 'Biography';-- change the category Biography to Memoir
delete from books where published_year < 2000;-- delete books published before 2000

insert into books values -- add values 
(2,'Harry Potter and the Philosophers stone',102,'Fantasy',650,1997),
(3,'Harry Potter and the Chambers of Secrets',102, 'Fantasy',700,1998);

-- subqueries
select title, price from books where price>(select avg(price) from books);-- find books costing more than the average price
select title, price from books order by price desc limit 1;-- find the most expensive book
select title, author_name from books inner join authors on books.author_id=authors.author_id where books.author_id=102;-- find books written by the author with id 102
select title, price from books where price >(select avg(price) from books) group by category; -- find books priced above thier category's average price -- To be completed after learning Correlated Subqueries

-- View
create view book_details as 
select title, author_name, category, price from books join authors on books.author_id=authors.author_id;
select * from book_details; -- Display all record
select * from book_details where category = 'Self Help';-- display only self help books
select * from book_details where price > 600; -- display books costing more than 600

-- chanllenge
select author_name, count(*) as count_books from authors join books on books.author_id=authors.author_id 
group by author_name order by count_books Desc limit 1; -- Which author has written the highest number of books?