CREATE TABLE ecommerce_data (
    order_id INT PRIMARY KEY,
    customer_id INT,
    product_id INT,
    product_name VARCHAR(100),
    category VARCHAR(50),
    region VARCHAR(50),
    order_date DATE,
    ship_date DATE,
    quantity INT,
    revenue DECIMAL(10,2)
);


SELECT * FROM ecommerce.ecommerce_data;

-- 1. Top 5 customers by total revenue
select customer_id,
       SUM(revenue) AS total_revenue
from ecommerce_data
group by customer_id
order by total_revenue desc
limit 5;


-- 2. Monthly sales trend with year-over-year comparison
select year(order_date) as Year,
		month(order_date) as month,
        round(sum(revenue)) as revenue,
        lag(sum(revenue)) over (partition by month(order_date) order by year(order_date)) as pre_year
from ecommerce_data
group by Year, month
order by Year, month;

-- 3 Category performance ranking by sales
select category, 
		sum(revenue) as revenue,
        rank() over(order by sum(revenue) desc) AS Rnk_Sales
from ecommerce_data
group by category;

-- 4. Average order value by region
select region, 
		count(distinct order_id) as total_orders,
        round(sum(revenue) / count(distinct order_id), 2) as avg_order_value
from ecommerce_data
group by region;

-- 5. Customers who placed more than average number of orders
-- STEP 1
select customer_id, count(1) as Total_orders
from ecommerce_data
group by customer_id;

-- STEP 2
select avg(Total_orders) as avg_orders
from (
	select customer_id, count(1) as Total_orders
	from ecommerce_data
	group by customer_id
) as order_count;

--  STEP 3
select customer_id, count(1) as Total_orders
from ecommerce_data
group by customer_id 
having count(1) > (
	select avg(Total_orders) as avg_orders
	from (
	select customer_id, count(1) as Total_orders
	from ecommerce_data
	group by customer_id
	) as order_count
);

-- 6. Top-selling product in each category
with product_sales as (
		select category, product_name,
		sum(revenue) as Revenue,
        row_number() over(partition by category order by sum(revenue) desc) as Rank_
		from ecommerce_data
group by category, product_name
)
select category, product_name, revenue
from product_sales
where Rank_ = 1;

-- 7. Percentage contribution of each region to total sales
select region,
		sum(revenue) as region_sales,
        round((sum(revenue) / (select sum(revenue) from ecommerce_data) * 100),2) as pct_contribution
from ecommerce_data
group by region;

-- 8. Orders delivered late
select order_id,
       customer_id,
       order_date,
       ship_date,
       DATEDIFF(ship_date, order_date) as shipping_days
from ecommerce_data
where ship_date > order_date + interval 7 day
order by shipping_days desc;

-- 9 Cumulative sales per month
select year(order_date) as year,
       month(order_date) as month,
       sum(revenue) as monthly_sales,
       sum(sum(revenue)) over (order by year(order_date), month(order_date)) as cumulative_sales
from ecommerce_data
group by year, month;

-- 10
select distinct customer_id
from ecommerce_data
where customer_id not in (
    select distinct customer_id
    from ecommerce_data
    where order_date >= date_sub(curdate(), interval 6 month)
);



