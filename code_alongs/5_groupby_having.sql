/*

*******************************************************************************
*******************************************************************************

SQL TUTORIAL 5: GROUP BY, HAVING

*******************************************************************************
*******************************************************************************
    
*/

USE music_beginner;

-- In some of the examples below, we'll be ROUNDing some aggregate values to make them more reader-friendly
-- Compare the two values below

SELECT
	*
FROM
	songs;

SELECT 
    AVG(duration), 
    ROUND(AVG(duration), 2) 
FROM 
    songs;
    


/*******
GROUP BY
*******/
-- Use GROUP BY to get aggregate information on rows sharing some value or values
-- When GROUPing, each DISTINCT value takes up one row, so all other SELECTions need to be single values (unique to the group or an aggregate)

-- Count the total number of songs in each genre.
SELECT 
    genre, 
    COUNT(*) AS total_songs
FROM
    songs
GROUP BY 
    genre;


-- For each genre, find:
-- the total number of songs
-- the average duration of songs
-- the longest and shortest song durations
SELECT 
    genre,
    COUNT(*) AS total_songs,
    ROUND(AVG(duration), 2) AS avg_duration, 
    MAX(duration) AS longest_duration,
    MIN(duration) AS shortest_duration
FROM
    songs
GROUP BY genre;



-- A couple of examples using many different keywords. Don't get overwhelmed! Just read one group of words at a time and think about how the effects combine.

-- Identify the 3 song writers with the longest average song durations.
SELECT 
    writer, ROUND(AVG(duration), 2) AS avg_duration_minutes
FROM
    songs
GROUP BY 
    writer
ORDER BY
    -- ROUND(AVG(duration), 2) DESC
    avg_duration_minutes DESC
LIMIT 3;


-- List the average rating by user, sorted in descending order. 
-- The users should all have with a username starting with "m" or "h"
-- Round the ratings to 2 decimal places
SELECT 
    username, ROUND(AVG(rating), 2) AS avg_rating, COUNT(*)
FROM
    ratings
WHERE          --  1
    username LIKE 'm%' 
        OR 
    username LIKE 'h%'
GROUP BY 
    username
ORDER BY 
    avg_rating DESC;



/*******
HAVING
*******/

-- While filtering with WHERE requires scanning a table for values, aggregated values AREN'T stored in the table 
-- They are CALCULATED later (after a GROUP is made) and so get filtered with HAVING

-- To compare, first list the average rating by user, considering only usernames starting with "m" or "h"
SELECT 
    username, 
    ROUND(AVG(rating), 2) AS avg_rating
FROM
    ratings
WHERE
    username LIKE 'm%' 
        OR 
    username LIKE 'h%'
GROUP BY 
    username;

-- Now, list only those rows with an average rating below 9.4
SELECT 
    username, 
    ROUND(AVG(rating), 2) AS avg_rating
FROM
    ratings
WHERE                    -- usernames are stored in the table, and get filtered with WHERE
    username LIKE 'm%' 
        OR 
    username LIKE 'h%'
GROUP BY 
    username
HAVING 
    avg_rating < 9.4     -- average ratings are calculated (according to the GROUPed usernames), so filter with HAVING
ORDER BY 
    avg_rating DESC;



-- List genres that have more than 5 songs.
SELECT 
    genre, 
    COUNT(*) AS total_songs
FROM
    songs
GROUP BY 
    genre
HAVING 
	total_songs > 5;
    -- COUNT(*) > 5;   -- rather than referencing the column by alias, it is possible to write out the aggregate
    
    
-- An aggregate used to filter doesn't even have to be SELECTed!
-- What's the longest duration in each genre? Include only genres with more than 5 songs.
SELECT 
    genre, 
    MAX(duration) AS longest_duration
FROM
    songs
GROUP BY 
    genre
HAVING 
    COUNT(*) > 5;