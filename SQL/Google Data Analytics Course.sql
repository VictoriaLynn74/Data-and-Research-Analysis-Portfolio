-- customer data table
-- insterting data into table 

 INSERT INTO `vaulted-circle-437604-e2.customer_data.customer_address`
  (customer_id, name, address,city, state, zipcode, country)
 VALUES 
 (2645, 'Rachel Desantos', '333 SQL Rd', 'Jackson', 'MI', 49202 , 'US') 

-- checking lenth of text strings in country codes 
 SELECT
LENGTH (country) as letters_in_country
FROM `vaulted-circle-437604-e2.customer_data.customer_address`

-- filtering country codes
SELECT
 country
FROM `vaulted-circle-437604-e2.customer_data.customer_address`
WHERE
LENGTH (country) > 2
 --  correcting miswritten country codes using substring when fetching data
SELECT
 DISTINCT customer_id
FROM
 `vaulted-circle-437604-e2.customer_data.customer_address`
WHERE
  SUBSTR( country , 1, 2) ='US'

--filtering for states with more than two letters
   
SELECT
 state
FROM
 `vaulted-circle-437604-e2.customer_data.customer_address`
WHERE
  LENGTH(state) > 2

--trimmimg excess spaces in OH state name
SELECT
 DISTINCT customer_id
FROM
 `vaulted-circle-437604-e2.customer_data.customer_address`
WHERE
  TRIM(state) = 'OH'

-- Practical Test
--Cars Dataset
--Querying fuel types
  
SELECT 
DISTINCT fuel_type
 FROM `vaulted-circle-437604-e2.cars.car_info` LIMIT 1000
 -- inspecting lenth column
SELECT
  MIN(length) AS min_length,
  MAX(length) AS max_length
FROM
  `vaulted-circle-437604-e2.cars.car_info`
--checking for nulls
SELECT
  *
FROM
  `vaulted-circle-437604-e2.cars.car_info`
WHERE 
 num_of_doors IS NULL

--updating null values
UPDATE
  `vaulted-circle-437604-e2.cars.car_info`
SET num_of_doors = 'four'
WHERE 
  make = "dodge"
  AND fuel_type = "gas"
  AND body_style = "sedan";

--for the Mazda
UPDATE
  `vaulted-circle-437604-e2.cars.car_info`
SET num_of_doors = 'four'
WHERE 
  make = "mazda"
  AND fuel_type = "diesel"
  AND body_style = "sedan";

-- correcting misspelt field
UPDATE
  `vaulted-circle-437604-e2.cars.car_info`
SET
  num_of_cylinders = "two"
WHERE
  num_of_cylinders = "tow";

-- Deleting a row with wrong data
DELETE 
`vaulted-circle-437604-e2.cars.car_info`
WHERE 
compression_ratio = 70;
--finding car with highest prices 
SELECT 
 make, price
FROM `vaulted-circle-437604-e2.cars.car_info`
ORDER BY price DESC;

--NEW EXERCISE
--Sorting customer purchase data

SELECT 
purchase_price
 FROM `vaulted-circle-437604-e2.customer_data.customer_purchase` 
 ORDER BY
   purchase_price DESC

-- converting purchase_price to sfloat from string
SELECT 
CAST(purchase_price AS FLOAT64)
 FROM `vaulted-circle-437604-e2.customer_data.customer_purchase` 
 
 ORDER BY
 CAST(purchase_price AS FLOAT64) DESC

--ADVANCED DATA CLEANING FUNCTIONS

--purchases in the month of December
SELECT 
CAST(date AS date) AS date_only,
purchase_price
 FROM `vaulted-circle-437604-e2.customer_data.customer_purchase` 
  WHERE
   date BETWEEN '2020-12-01' AND '2020-12-31'

--using CONCAT function
SELECT 
CONCAT(product_code, product_color) AS new_product_code
 FROM `vaulted-circle-437604-e2.customer_data.customer_purchase` 
  WHERE
   product = 'couch'

--Using COALESCE Function 
SELECT 
COALESCE(product, product_code) AS product_info
 FROM `vaulted-circle-437604-e2.customer_data.customer_purchase` 

--FILTERING MOVIE DATA
 SELECT *
 FROM `striking-gadget-215217.movie_dat.movies` 
 WHERE Genre = 'Comedy';

--SORTING DATA
SELECT *
 FROM `striking-gadget-215217.movie_dat.movies` 
 ORDER BY 
 Release_Date DESC;

--multiple conditions
SELECT *
 FROM `striking-gadget-215217.movie_dat.movies` 
 WHERE 
 Genre = "Comedy"
AND Revenue > 300000000
ORDER BY 
 Release_Date DESC;
--using public datasets
SELECT *
 FROM
  `bigquery-public-data.sdoh_cdc_wonder_natality.county_natality` 
  ORDER BY
  Births ASC
  LIMIT 10
--ADDING MULTIPLE CONDITIONS
SELECT *
 FROM
  `bigquery-public-data.sdoh_cdc_wonder_natality.county_natality` 
 WHERE
  County_of_Residence = 'Erie County, NY' 
  OR County_of_Residence = 'Niagara County, NY'
  OR County_of_Residence = 'Chautauqua County, NY'
ORDER BY
  County_of_Residence, 
  Year

--Aggregating temperature
SELECT 
 stn ,
    AVG(temperature) AS average_temperature
 FROM `striking-gadget-215217.demos.nyc_weather` 
 WHERE
 date BETWEEN '2020-06-01' AND '2020-06-30'
 GROUP BY 
    stn;

--OR

SELECT 
    AVG(temperature) AS average_temperature
 FROM `striking-gadget-215217.demos.nyc_weather` 
 WHERE
 date BETWEEN '2020-06-01' AND '2020-06-30'

--concat function
 
SELECT 
usertype,
CONCAT(start_station_name ,"to",end_station_name ) AS route,
COUNT (*) as num_trips,
ROUND(AVG(cast(tripduration as int64)/60),2) AS duration,
 FROM `bigquery-public-data.new_york.citibike_trips` 
 GROUP BY
 start_station_name, end_station_name, usertype
 ORDER BY
 num_trips DESC
 LIMIT 10

--JOINS
--INNER JOIN
SELECT
 employees.name AS employee_name,
 departments.name AS department_name,
FROM `striking-gadget-215217.employee_data.employees` AS  employees
INNER JOIN 
`striking-gadget-215217.employee_data.departments`
AS departments
ON employees.department_id = departments.department_id

 SELECT `bigquery-public-data.world_bank_intl_education.international_education`.country_name,
    `bigquery-public-data.world_bank_intl_education.country_summary`.country_code,
    `bigquery-public-data.world_bank_intl_education.international_education`.value
FROM `bigquery-public-data.world_bank_intl_education.international_education`
INNER JOIN `bigquery-public-data.world_bank_intl_education.country_summary`
ON `bigquery-public-data.world_bank_intl_education.country_summary`.country_code = `bigquery-public-data.world_bank_intl_education.international_education`.country_code


 SELECT
summary.region,
SUM(edu.value) secondary_edu_population
FROM
    `bigquery-public-data.world_bank_intl_education.international_education` AS edu
INNER JOIN
    `bigquery-public-data.world_bank_intl_education.country_summary` AS summary
ON edu.country_code = summary.country_code --country_code is our key
    WHERE summary.region IS NOT NULL
    AND edu.indicator_name = 'Population of the official age for secondary education, both sexes (number)'
    AND edu.year = 2015
GROUP BY summary.region
ORDER BY secondary_edu_population DESC

 SELECT 
state,
	COUNT(DISTINCT order_id) as num_orders
 FROM `striking-gadget-215217.warehouse_orders.orders`AS orders
 JOIN `striking-gadget-215217.warehouse_orders.warehouse`warehouse ON orders.warehouse_id = warehouse.warehouse_id
GROUP BY
	warehouse.state 


 SELECT 
	station_id,
	name,
	number_of_rides AS number_of_rides_starting_at_station
FROM
	(
		SELECT
			CAST(start_station_id AS STRING) AS start_station_id_str, 
			COUNT(*) AS number_of_rides
		FROM 
      		bigquery-public-data.new_york.citibike_trips
		GROUP BY 
			CAST(start_station_id AS STRING) 
	)
	AS station_num_trips
	INNER JOIN 
		bigquery-public-data.new_york.citibike_stations 
	ON 
		station_id = start_station_id_str
	ORDER BY 
		number_of_rides DESC;

 --LEFT JOIN
SELECT
 employees.name AS employee_name,
 employees.role AS employee_role,
 departments.name AS department_name,
FROM `striking-gadget-215217.employee_data.employees` AS  employees
LEFT JOIN 
`striking-gadget-215217.employee_data.departments`
AS departments
ON employees.department_id = departments.department_id
--RIGHT JOIN
SELECT
 employees.name AS employee_name,
 employees.role AS employee_role,
 departments.name AS department_name,
FROM `striking-gadget-215217.employee_data.employees` AS  employees
RIGHT JOIN 
`striking-gadget-215217.employee_data.departments`
AS departments
ON employees.department_id = departments.department_id
--OUTER JOIN
SELECT
 employees.name AS employee_name,
 employees.role AS employee_role,
 departments.name AS department_name,
FROM `striking-gadget-215217.employee_data.employees` AS  employees
FULL OUTER JOIN 
`striking-gadget-215217.employee_data.departments`
AS departments
ON employees.department_id = departments.department_id

--SUBQUERIES
 --Using new_york_citibike public dataset
 
SELECT 
    subquery.start_station_id,
    subquery.avg_duration
 FROM
   (
    SELECT
        start_station_id,
        AVG(tripduration) AS avg_duration
FROM bigquery-public-data.new_york_citibike.citibike_trips
GROUP BY start_station_id) as subquery
ORDER BY avg_duration DESC;

--comparing trip duration by station
SELECT
    starttime,
    start_station_id,
    tripduration,
    (
        SELECT ROUND(AVG(tripduration),2)
        FROM bigquery-public-data.new_york_citibike.citibike_trips
        WHERE start_station_id = outer_trips.start_station_id
    ) AS avg_duration_for_station,
    ROUND(tripduration - (
        SELECT AVG(tripduration)
        FROM bigquery-public-data.new_york_citibike.citibike_trips
        WHERE start_station_id = outer_trips.start_station_id), 2) AS difference_from_avg
FROM bigquery-public-data.new_york_citibike.citibike_trips AS outer_trips
ORDER BY difference_from_avg DESC
LIMIT 25;

--5 stations with longest mean trip duration

SELECT
    tripduration,
    start_station_id
FROM bigquery-public-data.new_york_citibike.citibike_trips
WHERE start_station_id IN
    (
        SELECT
            start_station_id
        FROM
        (
            SELECT
                start_station_id,
                AVG(tripduration) AS avg_duration
            FROM bigquery-public-data.new_york_citibike.citibike_trips
            GROUP BY start_station_id
        ) AS top_five
        ORDER BY avg_duration DESC
        LIMIT 5
    );

--Using Subqueries to Aggregate Data
--using uploaded dataset

SELECT
  Warehouse.warehouse_id,
  CONCAT(Warehouse.state, ': ', Warehouse.warehouse_alias) AS warehouse_name,
  COUNT(Orders.order_id) AS number_of_orders,
  (SELECT COUNT(*) FROM striking-gadget-215217.warehouse_orders.orders AS Orders) AS total_orders,
  CASE
    WHEN COUNT(Orders.order_id)/(SELECT COUNT(*) FROM striking-gadget-215217.warehouse_orders.orders AS Orders) <= 0.20
    THEN 'Fulfilled 0-20% of Orders'
    WHEN COUNT(Orders.order_id)/(SELECT COUNT(*) FROM striking-gadget-215217.warehouse_orders.orders AS Orders) > 0.20
    AND COUNT(Orders.order_id)/(SELECT COUNT(*) FROM striking-gadget-215217.warehouse_orders.orders AS Orders) <= 0.60
    THEN 'Fulfilled 21-60% of Orders'
    ELSE 'Fulfilled more than 60% of Orders'
  END AS fulfillment_summary
FROM striking-gadget-215217.warehouse_orders.warehouse AS Warehouse
LEFT JOIN striking-gadget-215217.warehouse_orders.orders AS Orders
ON Orders.warehouse_id = Warehouse.warehouse_id
GROUP BY
  Warehouse.warehouse_id,
  warehouse_name
HAVING
  COUNT(Orders.order_id) > 0

--CALCULATIONS IN SQL
--using uploaded dataset from Kaggle

SELECT 
	Date,
	Region,
	Small_Bags,
	Large_Bags,
	XLarge_Bags,
	Total_Bags,
	Small_Bags + Large_Bags + XLarge_Bags AS Total_Bags_Calc

 FROM `striking-gadget-215217.avocado_data.avocado_prices` 
--Percentages
SELECT 
	Date,
	Region,
	Total_Bags,
	Small_Bags,
	(Small_Bags / Total_Bags)*100 AS Small_Bags_Percent

 FROM `striking-gadget-215217.avocado_data.avocado_prices` 
 
 WHERE Total_Bags <> 0

--citibike public dataset
 SELECT 
EXTRACT (YEAR FROM starttime) AS year,
COUNT(*) AS number_of_rides

 FROM `bigquery-public-data.new_york_citibike.citibike_trips` 
 GROUP BY year
 ORDER BY year DESC

--new_york_subway public dataset
SELECT 

station_name,
ridership_2013,
ridership_2014,
ridership_2014-ridership_2013 AS change_2014_raw
FROM `bigquery-public-data.new_york_subway.subway_ridership_2013_present` 
--Average Calculation 
SELECT 
station_name,
ridership_2013,
ridership_2014,
ridership_2015,
ridership_2016,
(ridership_2013+ridership_2014+ridership_2015+ridership_2016)/4 AS Average

 FROM `bigquery-public-data.new_york_subway.subway_ridership_2013_present` 
--Using Temporary Table WITH clause


WITH trips_over_1_hour AS (
SELECT *
 FROM `bigquery-public-data.new_york_citibike.citibike_trips` 

 WHERE tripduration>=3600
)
## Count how many trips are over 60 minutes

SELECT 
COUNT(*) AS cnt
FROM trips_over_1_hour
 




