Select * from pizza_sales

-- Total Revenue
SELECT SUM(total_price) as Total_Revenue FROM pizza_sales 

-- AVG Order Value
SELECT SUM(total_price) /COUNT(DISTINCT order_id) as avg_order_value from pizza_sales

-- Total pizza sold
SELECT SUM(quantity) as Total_pizza_sold From pizza_sales

-- Total Ordes
SELECT COUNT(DISTINCT order_id) AS Total_Orders FROM pizza_sales

-- Average pizzas per order
SELECT CAST(CAST(SUM(quantity) AS DECIMAL(10,2)) /
	CAST(COUNT(DISTINCT order_id) AS DECIMAL(10,2)) AS DECIMAL(10,2))
	AS AVG_Pizzas_per_Order
	FROM pizza_sales

	--Total orders per day
	Select DATENAME(DW, order_date) as order_day,COUNT(DISTINCT order_id) as Total_orders
	from pizza_sales
	GROUP BY DATENAME(DW, order_date)

	-- Total orders per month
	SELECT DATENAME(MONTH, order_date) as Month_name, count(distinct order_id) as Total_orders
	from pizza_sales
	Group by Datename(Month,order_date)
	order by Total_orders desc

	
--percentage of each category's pizza sales
select pizza_category, sum(total_price) as Total_Sales, sum(total_price) *100 /
	(select sum(total_price) from pizza_sales where Month(order_date) = 1) as PCT_Pizza_Category
	from pizza_sales
	where MONTH(order_date) = 1     -- 1 for Jan 2 for feb ......
	group by pizza_category
	order by Total_Sales desc

	-- Percentage of size pizza sold
	select pizza_size, sum(total_price) as Total_Sales, sum(total_price) *100 /
	(select sum(total_price) from pizza_sales where datepart(quarter, order_date) = 1 ) as PCT_Pizza_Size
	from pizza_sales
	where datepart(quarter, order_date) = 1
	group by pizza_size
	order by Total_Sales desc

	-- Total Sales broken down by pizza type
	SELECT top 5 pizza_name, sum(total_price) as Sales_pizza_name
	from pizza_sales
	group by pizza_name
	order by Sales_pizza_name desc
	
	-- best seller in quantity
	select top 5 pizza_name, sum(quantity) as Total_Quantity from pizza_sales
	group by pizza_name
	order by Total_Quantity desc

