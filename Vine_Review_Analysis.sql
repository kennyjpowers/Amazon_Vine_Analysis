-- vine table
CREATE TABLE vine_table (
  review_id TEXT PRIMARY KEY,
  star_rating INTEGER,
  helpful_votes INTEGER,
  total_votes INTEGER,
  vine TEXT,
  verified_purchase TEXT
);

-- create a table with only reviews with more than 20 votes
CREATE TABLE filtered_vine_table AS
SELECT * FROM vine_table WHERE total_votes > 20;

-- create a table with only reviews that were helpful
CREATE TABLE helpful_vine_table AS
SELECT * FROM filtered_vine_table 
WHERE CAST(helpful_votes AS FLOAT)/CAST(total_votes AS FLOAT) >= 0.5;

-- create a table with only the paid reviews
CREATE TABLE paid_vine_table AS
SELECT * from helpful_vine_table WHERE vine = 'Y';

-- create a table with only the unpaid reviews 
CREATE TABLE unpaid_vine_table AS
SELECT * FROM helpful_vine_table WHERE vine = 'N';

-- total number of paid reviews is 231
SELECT COUNT(*) AS "total_paid_reviews" FROM paid_vine_table;

-- total number of unpaid reviews is 16464
SELECT COUNT(*) AS "total_unpaid_reviews" FROM unpaid_vine_table;

-- number of paid 5-star reviews is 93
SELECT COUNT(*) AS "paid_5star_reviews" FROM paid_vine_table
WHERE star_rating = 5;

-- number of unpaid 5-star reviews is 4867
SELECT COUNT(*) AS "unpaid_5star_reviews" FROM unpaid_vine_table
WHERE star_rating = 5;

-- percentage of paid reviews with 5 stars is 40%
SELECT
CAST(COUNT(CASE star_rating WHEN 5 THEN 1 END) AS FLOAT) / COUNT(*) "paid_5star_%"
FROM paid_vine_table;

-- percentage of unpaid reviews with 5 stars is 30%
SELECT
CAST(COUNT(CASE star_rating WHEN 5 THEN 1 END) AS FLOAT) / COUNT(*) "unpaid_5star_%"
from unpaid_vine_table;
