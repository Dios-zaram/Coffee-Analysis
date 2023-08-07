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
COPY coffee_store FROM 'coffee_csv1.csv'
DELIMITER ',' CSV HEADER;

SELECT * FROM coffee_store;

-- Check if values match the description
SELECT 
    CASE 
        WHEN region IN ('A', 'B', 'C', 'D', 'E', 'F', 'G', 'H', 'I', 'J') THEN 'Match'
        ELSE 'Does not match'
    END AS region_description_match,
    CASE 
        WHEN place_name IS NOT NULL THEN 'Match'
        ELSE 'Does not match'
    END AS place_name_description_match,
    CASE 
        WHEN place_type IN ('Coffee shop', 'Cafe', 'Espresso bar', 'Others') THEN 'Match'
        ELSE 'Does not match'
    END AS place_type_description_match,
    CASE 
        WHEN rating BETWEEN 3 AND 5 THEN 'Match'
        ELSE 'Does not match'
    END AS rating_description_match,
    CASE 
        WHEN reviews IS NOT NULL THEN 'Match'
        ELSE 'Does not match'
    END AS review_description_match
FROM coffee_store;

--Count the number of missing values
SELECT 
    COUNT(*) AS region_missing_count,
    COUNT(*) AS place_name_missing_count,
    COUNT(*) AS place_type_missing_count,
    COUNT(*) AS rating_missing_count,
    COUNT(*) AS review_missing_count
FROM coffee_store
WHERE region IS NULL OR place_name IS NULL OR place_type IS NULL OR rating IS NULL OR reviews IS NULL;

--Insert missing values that is null
INSERT INTO coffee_store (rating, reviews, dine_in_option, takeout_option)
SELECT 
    COALESCE(rating, 0),
    COALESCE(reviews, 271.5),
    COALESCE(dine_in_option, 'false'),
    COALESCE(takeout_option, 'false')
FROM 
    coffee_store
WHERE 
    rating IS NULL OR reviews IS NULL OR dine_in_option IS NULL OR takeout_option IS NULL;

--Which category of the variable place type have the most observations
SELECT place_type, COUNT(*) AS store_count
FROM coffee_store
GROUP BY place_type
ORDER BY store_count DESC;

--The distribution of all of the number of reviews.
SELECT 
    MIN(reviews) AS min_reviews,
    MAX(reviews) AS max_reviews,
    AVG(reviews) AS avg_reviews,
    MEDIAN(reviews) AS median_reviews,
    STDDEV(reviews) AS stddev_reviews
FROM coffee_store;

--The relationship between type of store and number of reviews
SELECT place_type, AVG(review) AS avg_reviews
FROM coffee_store
GROUP BY place_type;
