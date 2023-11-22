--Create the coffee_store
CREATE TABLE coffee_store(
region VARCHAR,
place_name VARCHAR,
place_type VARCHAR,
rating FLOAT,
reviews INT,
price VARCHAR,
delivery_option BOOL,
dine_in_option BOOL,
takeout_option BOOL);

--insert values
COPY coffee_store FROM 'C:\Program Files\PostgreSQL\15\data\data_copy\coffee_csv1.csv'
DELIMITER ',' CSV HEADER;

-- The entire dataset
SELECT 
	*
FROM coffee_store;

-- Update dataset
UPDATE
	coffee_store SET 
dine_in_option =
	CASE WHEN dine_in_option IS null THEN false ELSE true END,
takeout_option =
	CASE WHEN takeout_option IS null THEN false ELSE true END;

-- Delete null from rating column
DELETE 
	FROM coffee_store 
WHERE rating IS null;

/*Rating analysis*/
-- Find cummulative frequency of rating
SELECT 
    rating,
    SUM(CASE WHEN place_type = 'Cafe' AND rating BETWEEN 3.9 AND 5.0 THEN 1 ELSE 0 END) AS cafe_cumulative_frequency,
    SUM(CASE WHEN place_type = 'Coffee shop' AND rating BETWEEN 3.9 AND 5.0 THEN 1 ELSE 0 END) AS coffee_shop_cumulative_frequency,
    SUM(CASE WHEN place_type = 'Espresso bar' AND rating BETWEEN 3.9 AND 5.0 THEN 1 ELSE 0 END) AS espresso_bar_cumulative_frequency,
    SUM(CASE WHEN place_type = 'Others' AND rating BETWEEN 3.9 AND 5.0 THEN 1 ELSE 0 END) AS others_cumulative_frequency
FROM 
    coffee_store
GROUP BY 
    rating;

/*Central tendency of rating*/
-- Find the Average
SELECT 
	AVG(rating)
FROM coffee_store;

-- Find Median
SELECT 
	PERCENTILE_CONT(0.5) WITHIN GROUP (ORDER BY rating) median
FROM coffee_store;

-- Find Mode
SELECT
  MODE() WITHIN GROUP (ORDER BY rating)
FROM
  coffee_store;

-- Find Variance
SELECT 
	VAR_SAMP(rating)
FROM coffee_store;

-- Find Standard Deviation
SELECT 
	STDDEV_SAMP(rating)
FROM coffee_store;

-- Number of rating
SELECT 
	COUNT(rating)
FROM coffee_store;

-- Find Standard error
SELECT
  ROUND((STDDEV_SAMP(rating) / SQRT(COUNT(rating)))::numeric,2)
FROM coffee_store;

-- Find the upper and lower confidence interval
SELECT
  AVG(rating) - 1.96 * (STDDEV_SAMP(rating) / SQRT(COUNT(rating))) AS lower_limit,
  AVG(rating) + 1.96 * (STDDEV_SAMP(rating) / SQRT(COUNT(rating))) AS upper_limit
FROM
  coffee_store;

/*      OBSERVATION
The mean rating for the dataset is 4.66, and the calculated 95% confidence interval
for the mean is approximately [4.6327,4.6945]. This interval suggests that, with 
95% confidence, the true population mean rating is likely to fall within this 
range.*/


/*Frequency*/
-- Frequency for delivery_option
SELECT 
    delivery_option,
    SUM(CASE WHEN place_type = 'Cafe' AND delivery_option= TRUE THEN 1 ELSE 0 END) AS cafe_cumulative_frequency,
    SUM(CASE WHEN place_type = 'Coffee shop' AND delivery_option =TRUE THEN 1 ELSE 0 END) AS coffee_shop_cumulative_frequency,
    SUM(CASE WHEN place_type = 'Espresso bar' AND delivery_option =TRUE THEN 1 ELSE 0 END) AS espresso_bar_cumulative_frequency,
    SUM(CASE WHEN place_type = 'Others' AND delivery_option =TRUE THEN 1 ELSE 0 END) AS others_cumulative_frequency
FROM 
    coffee_store
GROUP BY 
	delivery_option
ORDER BY
	delivery_option desc;


SELECT 
    dine_in_option,
    SUM(CASE WHEN place_type = 'Cafe' AND dine_in_option= TRUE THEN 1 ELSE 0 END) AS cafe_cumulative_frequency,
    SUM(CASE WHEN place_type = 'Coffee shop' AND dine_in_option =TRUE THEN 1 ELSE 0 END) AS coffee_shop_cumulative_frequency,
    SUM(CASE WHEN place_type = 'Espresso bar' AND dine_in_option =TRUE THEN 1 ELSE 0 END) AS espresso_bar_cumulative_frequency,
    SUM(CASE WHEN place_type = 'Others' AND dine_in_option =TRUE THEN 1 ELSE 0 END) AS others_cumulative_frequency
FROM 
    coffee_store
GROUP BY 
	dine_in_option;
	
SELECT 
    takeout_option,
    SUM(CASE WHEN place_type = 'Cafe' AND takeout_option= TRUE THEN 1 ELSE 0 END) AS cafe_cumulative_frequency,
    SUM(CASE WHEN place_type = 'Coffee shop' AND takeout_option =TRUE THEN 1 ELSE 0 END) AS coffee_shop_cumulative_frequency,
    SUM(CASE WHEN place_type = 'Espresso bar' AND takeout_option =TRUE THEN 1 ELSE 0 END) AS espresso_bar_cumulative_frequency,
    SUM(CASE WHEN place_type = 'Others' AND takeout_option =TRUE THEN 1 ELSE 0 END) AS others_cumulative_frequency
FROM 
    coffee_store
GROUP BY 
	takeout_option
ORDER BY
	takeout_option desc;
	
/*		OBSERVATION
1. The data suggests that the "Coffee shop" category tends to have a high 
frequency of  establishments offering both dine-in and take-out options.
2. "Cafe" shows a higher frequency in offering delivery.
3. The "Others" category seems to have varied offerings in terms of delivery, 
dine-in, and take-out.
*/

/*Review Central Tendency*/
  
SELECT 
    region,
    MAX(reviews) AS max_reviews,
    MIN(reviews) AS min_reviews,
	MAX(rating) AS max_rating,
    MIN(rating) AS min_rating
FROM
    coffee_store
GROUP BY
    region;


/* OBSERVATIONS 

1. The region with the highest maximum reviews is E, achieving a perfect rating
of 5. In contrast, region C has the lowest maximum reviews (806), but it also 
maintains a perfect rating of 5. Notably, region I is the only one with a maximum
rating lower than 5.

2. Recognizing the challenge of distinguishing between good and bad reviews, 
less emphasis is placed on reviews in the analysis.

3. Across regions, there is a consistent trend of a maximum rating of 5. To 
capture subtle variations, the minimum rating for each region is considered, as 
it offers greater accuracy.

4. Region G stands out with the highest minimum rating of 4.6, while both 
regions I and H share the lowest minimum rating.*/

