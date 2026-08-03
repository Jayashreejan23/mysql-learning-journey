/*
==================================================
Project      : E-Commerce Management System
Version      : 1.0
Author       : Jayashree S
Database     : MySQL
Description  : A beginner-to-intermediate SQL project
               demonstrating customer and order management,
               CRUD operations, filtering, sorting,
               aggregation, joins, subqueries, views,
               indexes, conditional CASE expressions,
               and business reporting.
Created On   : August 2026
==================================================
*/
create database ecommerce_management; -- create database 
use ecommerce_management; -- use database
create table customers( -- create customers
customer_id int primary key,
customer_name varchar(30),
city varchar(50),
membership varchar(20));
insert into customers values -- insert all customers data
(101,'Asha','Chennai','Gold'),
(102,'Rahul','Bangalore','Silver'),
(103,'Sneha','Chennai','Gold'),
(104,'Kiran','Hyderabad','Bronze'),
(105,'Priya','Mumbai','Silver'),
(106,'Arjun','Delhi','Gold'),
(107,'Meera','Chennai','Bronze'),
(108,'Rohit','Pune','Silver');
create table orders( -- create orders
order_id int primary key,
customer_id int,
product varchar(30),
category varchar(30),
amount int,
status varchar(30));
insert into orders values -- insert all orders data
(1,101,'Laptop','Electronics',65000,'Delivered'),
(2,102,'Headphones','Electronics',3500,'Delivered'),
(3,103,'Chair','Furniture',7500,'Shipped'),
(4,104,'Shoe','Fashion',2800,'Cancelled'),
(5,105,'Mobile','Electronics',22000,'Delivered'),
(6,106,'Table','Furniture',5500,'Delivered'),
(7,107,'Dress','Fashion',3200,'Shipped'),
(8,108,'Watch','Fashion',4800,'Delivered'),
(9,101,'Keyboard','Electronics',1800,'Delivered'),
(10,103,'Sofa','Furniture',15000,'Shipped'),
(11,102,'Mouse','Electronics',1200,'Cancelled'),
(12,106,'Monitor','Electronics',12500,'Delivered');
select * from customers; -- display customer table
select * from orders; -- display orders table
-- Basic Queries
select * from orders; -- Display all orders.
select product, amount from orders; -- Display product and amount.
select product, amount from orders where amount > 5000; -- Find orders above ₹5,000.
select product, amount from orders where amount < 3000; -- Find orders below ₹3,000.
select product, status from orders where status='Delivered'; -- Find delivered orders.
select product, status from orders where status ='Cancelled';-- Find cancelled orders.
select product, amount from orders order by amount desc; -- Sort orders by amount, highest first.
select distinct category from orders; -- Display distinct product categories.
select product from orders where product like 'M%'; -- Find products starting with M.
select product, amount from orders where amount between 2000 and 10000; -- Find orders between ₹2,000 and ₹10,000.
-- Aggregate Functions
select count(*) as total_order from orders; -- Count total orders.
select avg(amount) as avg_amount_of_order from orders; -- Find average order amount.
select max(amount) as highest_amount from orders; -- Find highest order amount.
select min(amount) as lowest_amount from orders; -- Find lowest order amount.
select sum(amount) as total_order_value from orders; -- Find total order value.
-- GROUP BY
select category, count(category) as count from orders group by category; -- Count orders by category.
select category, avg(amount) as avg_amount_category from orders group by category; -- Find average order amount by category.
select category, max(amount) as highest_amount_by_cateogry from orders group by category; -- Find highest order amount by category.
select category, sum(amount) as total_amount_by_category from orders group by category; -- Find total revenue by category.
select status, count(*) as no_of_order_by_status from orders group by status; -- Count orders by status.
-- HAVING
select category, count(category) as count from orders group by category having count > 2;-- Categories having more than 2 orders.
select category, avg(amount) as avg_amount from orders group by category having avg_amount > 5000; -- Categories whose average order amount is above ₹5,000.
select status, count(*) as count_status from orders group by status having count_status > 2;-- Statuses having more than 2 orders.
select category, sum(amount) as total_amount from orders group by category having total_amount > 20000; -- Categories whose total revenue exceeds ₹20,000.
-- INNER JOIN
select customer_name, product from customers c inner join orders o on c.customer_id=o.customer_id; -- Display customer name and product.
select customer_name, city, product from customers c inner join orders o on c.customer_id=o.customer_id;-- Display customer name, city and product.
select Distinct customer_name, city from customers c inner join orders o on c.customer_id=o.customer_id where city='chennai'; -- Find orders placed by customers from Chennai.
select Distinct customer_name, membership, product from customers c inner join orders o on c.customer_id=o.customer_id where membership='Gold'; -- Find Gold members and their orders.
select customer_name, product, amount from customers c inner join orders o on c.customer_id=o.customer_id;  -- Display customer name, product and amount.
select customer_name, membership, amount from customers c inner join orders o on c.customer_id=o.customer_id where membership = 'Gold' and amount > 5000; -- Find Gold members whose order amount is above ₹5,000.
-- LEFT JOIN
-- Add a customer who hasn't placed an order:
insert into customers value
(109,'Jay','Coimbatore','Gold');
select * from customers c left join orders o on c.customer_id=o.customer_id; -- Display all customers and their orders.
select * from customers c left join orders o on c.customer_id=o.customer_id where o.order_id is null; -- Find customers who haven't placed any orders.
-- RIGHT JOIN
-- Add an order belonging to a customer who doesn't exist:
insert into orders values
(13, 999, 'Unknown Product', 'Electronics', 4000, 'Delivered');
select * from customers c right join orders o on c.customer_id=o.customer_id; -- Display all orders even if customer details are missing.
select * from customers c right join orders o on c.customer_id=o.customer_id where c.customer_id is null; -- Find orders whose customer details are unavailable.
-- UPDATE / DELETE
update orders set amount=amount*1.05 where category = 'Electronics'; -- Increase all Electronics orders by 5%.
update customers set membership='Silver' where customer_id=104; -- Change customer 104's membership to Silver.
update orders set status = 'Returned' where status='Cancelled';  -- Change all Cancelled orders to Returned.
delete from orders where amount<1500; -- Delete orders below ₹1,500.
-- SUBQUERIES
select * from orders where amount > (select avg(amount) from orders); -- Find orders above the overall average order amount.
select * from orders order by amount desc limit 1; -- Find the highest order amount.
select customer_name from customers c inner join orders o on c.customer_id=o.customer_id where amount>10000;-- Find customers who placed an order above ₹10,000.
select * from orders o where o.amount > (select avg(o2.amount) from orders o2 where o2.category=o.category);-- Find orders above the average order amount of their category.
-- VIEWS 
-- create customer order details
create view customer_order_details as select c.customer_name, c.city, c.membership, o.product, o.category, o.amount, o.status from customers c inner join orders o on c.customer_id=o.customer_id;
select * from customer_order_details; -- Display all records from the view.
select Distinct * from customer_order_details where membership='Gold'; -- Display Gold members from the view.
select * from customer_order_details where amount > 5000; -- Display orders above ₹5,000 from the view.
select * from customer_order_details where category='Electronics'; -- Display Electronics orders from the view.
drop view customer_order_details; -- Drop the view.
-- INDEXES
create index idx_customer_name on customers(customer_name); -- Create an index on customer_name.
show index from customers; -- Display indexes on customers.
create index idx_product on orders(product); -- Create an index on product.
show index from orders; -- Display indexes on orders.
drop index idx_customer_name on customers;  
drop index idx_product on orders; -- Drop the indexes.
-- CASE
select product, amount,
case when amount > 5000 then 'High Value'
when amount between 2000 and 5000 then 'Medium Value'
else 'Low Value'
End as calculated_results from orders;
select product, category,
case when status='Delivered' then 'Completed'
when status='Shipped' then 'In Progress'
else 'Not Completed'
end as order_status_category from orders;
select customer_name, membership,
case when membership='Gold' then 'Premium'
when membership='Silver' then 'Regular'
else 'Basic'
end as customer_membership_category from customers;
select customer_name, product, amount, membership,
case when membership='Gold' then 'Premium'
when membership='Silver' then 'Regular'
else 'Basic'
end as membership_category from customers c inner join orders o on c.customer_id=o.customer_id;
-- Case + Aggregate
-- Count how many High Value, Medium Value and Low Value orders exist.
select case when amount > 5000 then 'High Value'
when amount between 2000 and 5000 then 'Medium Value'
else 'Low Value'
End as order_category, count(*) as order_count from orders group by order_category;

-- CHALLENGE
select customer_name from customers c join orders o on c.customer_id=o.customer_id order by amount desc limit 1; -- Which customer has placed the highest-value order?
select category, sum(amount) as total_revenue_by_category from orders o group by category order by total_revenue_by_category desc limit 1; -- Which category generated the highest revenue?
select city, count(*)  as no_of_customers from customers c group by city order by no_of_customers desc limit 1;  -- Which city has the highest number of customers?
select max(amount) as second_highest from orders o where amount < (select max(amount) from orders); -- Find the second-highest order amount.
select customer_name, sum(amount) as customer_total_value from customers c inner join orders o on c.customer_id=o.customer_id group by customer_name having customer_total_value > 
(select avg(customer_total) from (select customer_id,SUM(amount) as customer_total from orders group by customer_id) as customer_totals); -- Find customers whose total order value is greater than the average customer's total order value.
-- Create a report showing:
-- Customer Name, Total Orders, Total Spending and Spending Category
Select c.customer_name,
case when sum(o.amount) > 30000 then 'High Spender'
when sum(o.amount) between 10000 and 30000 then 'Medium Spender'
else 'Low Spender'
end as spending_category, count(o.product) as total_order, sum(amount) as total_spending
from customers c join orders o on c.customer_id=o.customer_id group by c.customer_id, c.customer_name;