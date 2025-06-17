use sql_project_p1;

create table retail_sales (
transactions_id	int primary key,
sale_date date ,
sale_time time,
customer_id	int,
gender	varchar(50),
age	int not null,
category	varchar(50),
quantiy int,
price_per_unit	float,
cogs	float,
total_sale float 
);
-- data cleaning --
select * from retail_sales
where 
transactions_id is null
or
sale_date is null
or 
sale_time is null
or 
customer_id is null
or	
gender is null 
or	
category is null
or 	
quantiy is null 
or
price_per_unit is null 
or
cogs is null
or
total_sale is null ;

-- how many sales we have--
select count(*) from retail_sales;

-- how many unique customers we have--
select count(distinct customer_id) from retail_sales;

-- how many unique categries we have--
select distinct category  from retail_sales;

-- write a query to retrieve all columns for sales amde on 2022-11-05--
select * from retail_sales
where sale_date = "2022-11-05";

-- write a query to retriev all trasanctions where the category is 'clothing' and the quantity sold is more than 2 in the month of november 2022--
select * from retail_sales
where category = 'clothing' and quantiy>2 and  sale_date between '2022-11-01' and '2022-11-30';

select * from retail_sales;

-- waq to calculate the total sales  for each category--
select sum(total_sale), category from retail_sales group by category;

-- waq to find the average age of customers who purchased items from the beauty category--
select avg(age) from retail_sales where category = "beauty";

-- waq to find the all transactions where the total sale is greater than 1000--
select * from retail_sales where total_sale >1000;

-- waq to find total number of transactions (transactions_id) made by each gender in each category--
select 
category,
gender ,
count(*) from retail_sales
group by 
category,
gender; 

-- waq to calculate the average sale foreach month and find out the best selling month in each year --
select * from 
(
select year(sale_date) as year,
month(sale_date) as month,
avg(total_sale) as avg_sale,
RANK() OVER (
PARTITION BY year(sale_date) 
ORDER BY avg(total_sale) DESC
) as rank_in_year
from retail_sales
group by month,year
order by year,avg_sale desc) as t1
where rank_in_year = 1;

-- waq to find the top 5 customers based on the highest total sales --
select customer_id,
sum(total_sale) as total_sale
from retail_sales
group by customer_id
order by total_sale desc limit 5;

-- waq to find the number of unique customers who purchased items from each category --
select category,
count(distinct customer_id) as unique_cust
from retail_sales
group by category;

-- waq to create each shift and number of orders (example morning <=12, Afternoon between 12 and 17, evening >17) --
SELECT 
  CASE
    WHEN HOUR(sale_time) < 12 THEN 'Morning'
    WHEN HOUR(sale_time) >= 12 AND HOUR(sale_time) < 17 THEN 'Afternoon'
    ELSE 'Evening'
  END AS shift,
  COUNT(*) AS total_orders
FROM retail_sales
GROUP BY shift
ORDER BY FIELD(shift, 'Morning', 'Afternoon', 'Evening');

-- end of project -- 


