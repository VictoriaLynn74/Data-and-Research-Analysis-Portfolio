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
 




