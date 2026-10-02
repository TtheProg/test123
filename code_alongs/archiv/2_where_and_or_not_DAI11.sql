/*

*******************************************************************************
*******************************************************************************

SQL TUTORIAL 2: WHERE, AND, OR, NOT

*******************************************************************************
*******************************************************************************


*/

-- Don't forget to specify what database you'll be working with at the top of a query sheet!
USE music_beginner;


-- 1. Simple conditions: a WHERE clause allows you to compare the values in a column to some other value and selectively return rows where the condition is TRUE
-- Find songs that are longer than 5 minutes (300 sec)
SELECT 
    *
FROM
    songs
WHERE
    duration > 300;    



-- Find artists from the UK

SELECT
	*
FROM
	artists
WHERE
	country = "UK"
;

-- 

SELECT 
    *
FROM
    artists
WHERE
    country = 'UK';  -- unlike numbers, text needs to be enclosed in single- or double-quotes

-- 2. Dealing with dates in conditions: Although DATE and DATETIME columns contain a special type of number, they can be identified with text
-- Select the names of artists born in 1980 or later
SELECT 
    artist_name, birthdate
FROM
    artists
WHERE
    birthdate >= '1980-01-01';

-- A DATE or DATETIME column can be used with YEAR() to extract the year-part of the date
SELECT 
    artist_name, birthdate
FROM
    artists
WHERE
    YEAR(birthdate) >= 1980;


-- 3. Multiple conditions: Complex conditions can be built by joining simple ones with AND and OR
-- Just make sure each is a FULL CONDITION, even if the same column is compared to multiple values

-- Use AND if BOTH conditions must be true
-- Find Rock songs that are longer than 5 minutes (300 sec)
SELECT 
    *
FROM
    songs
WHERE
    duration > 300 
        AND 
    genre = 'Rock';


-- Use OR if AT LEAST ONE of the conditions must be true
-- Find all Alternative songs and all Indie Pop songs
SELECT 
    *
FROM
    songs
WHERE
    genre = 'Alternative'
        OR 
    genre = 'Indie Pop'; 


-- You aren't limited to just two conditions!
-- Find Rock songs that are longer than 5 minutes and were released after 1970
SELECT 
    *
FROM
    songs
WHERE
    duration > 300 
        AND 
    genre = 'Rock'
        AND 
    release_year > 1970;
    
    
-- Use parentheses () to control the grouping of conditions
-- Without parentheses, any conditons joined by AND will be evaluated together first
-- Find the songs written by Elton John which were released in either 1970 or 1971 
SELECT 
    *
FROM
    songs
WHERE
    (release_year = 1970   -- notice how these statements are grouped together with parentheses
        OR 
	release_year = 1971)
        AND 
	writer = 'Elton John';
	
SELECT 
    *
FROM
    songs
WHERE
    release_year = 1970   -- and compare the results when no parentheses are used
        OR 
	release_year = 1971
        AND 
	writer = 'Elton John';
        
        
-- 4. Negating conditions: Putting NOT in front of a condtion changes true to false and false to true

-- Find songs not written by Madonna
SELECT 
    *
FROM
    songs
WHERE
    NOT writer = 'Madonna';


-- When the conditon is checking equality, it can be inverted with a few special symbols meaning "not equal to"
-- !=
SELECT 
    *
FROM
    songs
WHERE
    writer != 'Madonna';

-- <>
SELECT 
    *
FROM
    songs
WHERE
    writer <> 'Madonna';


-- 5. Combining it all: A few examples mixing everything covered

-- List the name of artists who debuted before 1990 but were not born in the USA
SELECT 
    artist_name, country
FROM
    artists
WHERE
	debut_year < 1990
        AND 
    NOT country = 'USA';





-- Find songs that are:
    -- either Rock or Folk
    -- not written by John Lennon,
    -- and are either shorter than 4 minutes or longer than 6 minutes

SELECT 
    *
FROM
    songs
WHERE
    (genre = 'Rock' OR genre = 'Folk')
        AND 
    NOT writer = 'John Lennon'
        AND 
    (duration < 240 OR duration > 360);
    
    
    
    
    
    
    
    