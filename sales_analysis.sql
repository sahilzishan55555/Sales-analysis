show databases;
create database sales_analysis;
use sales_analysis; 

-- inspecting data for our analysis
select * from sales_data;

-- Checking distinct values
select distinct status from sales_data;
select distinct year_id from sales_data;
select distinct productline from sales_data;
select distinct country from sales_data;
select distinct dealsize from sales_data;
select distinct territory from sales_data;

 -- Analysis 
 -- Grouping sales by product line                     #classic car and vintage car has the highest revnue 
 select productline, sum(sales) as Revnue
 from sales_data
 group by productline
 order by  2 desc;
 
 
 -- Grouping sales by year
 select year_id, sum(sales) as Total_revnue           #2004 has the highest revnue year 
 from sales_data
 group by year_id
 order by 2 desc;
 
 -- Grouping sales by deal sizes 
 select  dealsize, sum(sales) as Revnue_dealsize
 from sales_data                                     # medium size is the highest and we should also focus on small 
 group by dealsize
 order by 2 desc;
 
 -- Best month for sales in specific area and how much it is ? 
 
 select month_id, sum(sales) as Revnue_month,count(ordernumber) as frequency
 from sales_data
 where year_id = 2003  -- change year to check for specific year           # November month has the highest sales and frequency 
 group by month_id
 order by 2 desc;
 
 -- What product is sold most in November month? 
 
 select month_id, productline, sum(sales) as revnue_product, count(ordernumber)  # Classic car and vintage car is in top 2
 from sales_data
 where year_id = 2003 and month_id = 11  -- change year to check for specific year
 group by productline, month_id
 order by 3 desc;  
 
 -- Who could be our best customers (RMF analysis) ? 
 
  -- R - Recency ( How long their last purchase)  last order data 
  -- F - Frequency ( How they often they purchase) count of total order
  -- M - Monetry ( How much money they spent)  Total money spent 
  
  select customername, 
  sum(sales) as total_purchase,
  avg(sales) as average_purchase, 
  count(ordernumber) as frequency, 
  max(orderdate) as last_orderdate
  from sales_data
  group by customername
  order by 2 desc;
  
  -- What product are most often sold together? 
  
  
  select productcode, productline
  from sales_data where ordernumber in (
  
  select ordernumber from (
  select ordernumber, count(*) rn
  from sales_data
  where status= "shipped"
  group by ordernumber
  ) m where rn = 2
  );
  
  -- Which country is giving highest revnue? 
   select country, territory, sum(sales) 
   from sales_data                                      # USA is giving highest revnue
   group by country, territory
   order by 3 desc;
  
  
  -- Which product sold more and giving more revnue in USA? 
  
  select productline,  country, sum(sales) 
  from sales_data
group by productline,country                            #classic cars in usa is giving highest revnue
  having country = "USA"
  order by 3 desc;
  
  
  
  -- 5 Lowest revnue country?
  
  select country, sum(sales) as lowest_revnue          # Ireland,Philippines,Belgium,Switzerland,Japan
  from sales_data
  group by country 
  order by 2 asc
  limit 5;
  
  -- which city has the highest quantity ordered? 
  
  select city, country, sum(quantityordered)             # madrid from spain has the highest number of quantity ordered. 
  from sales_data                                          
  group by city, country 
  order by 3 desc;
  
  
 -- which country has the highest order cancellination? 
 
 select status, country, count(*) 
 from sales_data                                                    # Sweden has the highest order cancellation. 
 where status = "cancelled"
 group by status, country 
 order by 3 desc;
 
 

 -- Which product line has maximum disputes
 
 select productline, status , count(*) as dispute_count
 from sales_data                                        #motercycle has the highest number of dispute in delevery
 where status = "Disputed"
 group by productline, status 
 order by 3 desc;
 
-- How has the number of shipments varied over the years for each product line?

SELECT YEAR_ID, PRODUCTLINE, COUNT(*) AS ShipmentCount
FROM sales_data
WHERE STATUS = 'Shipped'
GROUP BY YEAR_ID, PRODUCTLINE
ORDER BY YEAR_ID, PRODUCTLINE;

--  Which customer has placed the highest number of orders?

select customername, count(*) as total_order
from sales_data
group by customername
order by 2 desc
limit 1;

--  Which contact person has achived maximum number of large deal size? 

select contactfirstname, count(*) as total_deal
from sales_data
where dealsize = "large"
group by contactfirstname 
order by 2 desc;












 
 
 
 
 
 
 
 
 
 
 
 
 
 