/*

*******************************************************************************
*******************************************************************************

SQL TUTORIAL 7: CASE

*******************************************************************************
*******************************************************************************


*/


USE music_beginner;


-- CASEs allow you to create new columns, with the values dependent on conditions that you set

-- When SELECTed, the CASE needs to be separated from other columns by a comma ,
-- Categorize songs by their duration (short, medium, long)
-- Short: less than 210 seconds
-- Medium: 210 - 300 seconds
-- Long: more than 300 seconds

SELECT
    song_name,
    CASE
        WHEN duration < 210 THEN 'Short'
        WHEN duration BETWEEN 210 AND 300 THEN 'Medium'
        ELSE 'Long'
    END AS duration_category
FROM
    songs;

-- Conditions are checked sequentially, and the first match is taken. Here, the second condition overlaps the first
-- but any row meeting the first condition will be labelled such
SELECT
    song_name,
    CASE
        WHEN duration < 210 THEN 'Short'
        WHEN duration <= 300 THEN 'Medium'
        ELSE 'Long'
    END AS duration_category
FROM
    songs;


-- CASEs are quite flexible. Here, a CASE makes use of a value aggregated in a GROUPing.

-- Rate song popularity based on number of ratings received
-- 3 or more ratings: "Popular"
-- Less than 3 ratings: "Not popular"
SELECT
    songs.song_name,
    COUNT(ratings.song_id) AS total_ratings,
    CASE
        WHEN COUNT(ratings.song_id) > 3 THEN 'Popular'
        ELSE 'Not Popular'
    END AS popularity
FROM
    songs
        LEFT JOIN 
    ratings ON songs.id = ratings.song_id
GROUP BY 
    songs.id
ORDER BY 
    total_ratings DESC;



-- A CASE's label value can even be based on another column's value in the row.
-- Classify songs based on their genre (Pop, Rock, Other)
SELECT
    song_name,
    genre,
    CASE
        WHEN genre IN ('Pop', 'Rock') THEN genre
        ELSE 'Other'
    END AS genre_category
FROM
    songs;
    
    
    
-- A CASE doesn't require an ELSE, but then the new column could have NULL values if the CASEs aren't exhaustive
SELECT 
	artist_name,
    debut_year,
    CASE
		WHEN debut_year < 1975 THEN 'Classic'
        WHEN debut_year >= 2010 THEN 'New'
	END AS song_age
FROM 
	artists;



/* When the data has NULL values:
Any time NULL is compared to a value (>, <, =, BETWEEN, etc) the result is NULL
Any ELSE will catch ALL NULL values */

-- Compare the outputs of the two queries below
SELECT
	artist_name,
	birthdate,
    CASE
        WHEN YEAR(birthdate) >= 2000 THEN '21st Century'
        WHEN YEAR(birthdate) < 2000 THEN '20th Century'
	END birth_century
FROM 
	artists;
    
SELECT
	artist_name,
	birthdate,
    CASE
        WHEN YEAR(birthdate) >= 2000 THEN '21st Century'
        ELSE '20th Century'
	END birth_century
FROM 
	artists;
	