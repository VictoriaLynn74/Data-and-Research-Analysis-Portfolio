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



