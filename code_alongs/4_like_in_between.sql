/******************************************************************************
*******************************************************************************

SQL TUTORIAL 4: LIKE, IN, BETWEEN

*******************************************************************************
******************************************************************************/

USE music_beginner;

/*******
LIKE
*******/


-- Unlike =, which matches exact text, LIKE can be used to match patterns by using WILDCARD characters
-- When using LIKE a "%" in the string means "any number (including 0) of any character"

-- Find all artists whose name starts with 'A'
SELECT 
    *
FROM
    artists
WHERE     --          1
    artist_name LIKE 'A%';  -- the pattern reads like "A followed by any (or no!) other characters"


-- More than one character can be used to define the pattern
-- Find all songs whose name ends with 'man'
SELECT
    *
FROM
    songs
WHERE
    song_name LIKE '%man';  

-- Multiple characters need not be consecutive!
-- Search for songs whose name starts with 'L' and ends with 'e'

SELECT 
    *
FROM
    songs
WHERE            -- 1
    song_name LIKE 'L%e';

-- More than one WILDCARD can be used in the pattern!
-- List all songs that have 'life' anywhere in the lyrics
SELECT 
    *
FROM
    songs
WHERE
    lyrics LIKE '%life%';


-- When using LIKE a "_" in the string means "exactly 1 of any character". Otherwise, the rules are the same.

-- Find all artists whose name contains exactly seven letters
SELECT 
    *
FROM
    artists
WHERE
--                    1234567
    artist_name LIKE '_______';

-- Find artists whose name starts with 'A' and is five letters long
SELECT 
    *
FROM
    artists
WHERE        --       12345
    artist_name LIKE 'A____';



-- Both WILDCARDS can be combined in one pattern
-- Search for songs whose names have 'a' as the third character and end with 'y'
SELECT 
    *
FROM
    songs
WHERE  			--  123
    song_name LIKE '__a%y';


-- List all artists whose name either starts with 'Bi' or ends with 'e'
SELECT 
    *
FROM
    artists
WHERE
    artist_name LIKE 'Bi%'
        OR 
    artist_name LIKE '%e';



/*******
IN
*******/

-- If one column's values should match ONE of MANY options, the options can be pulled together with IN, rather than using OR many times

-- Find all songs with the genre 'Pop' or 'Rock'
SELECT 
    *
FROM
    songs
WHERE
    genre IN ('Pop' , 'Rock');  -- options are wrapped in parentheses () and separated by commas ,

-- This is the same as 
SELECT 
    *
FROM
    songs
WHERE
    genre = 'Pop' 
        OR
    genre = 'Rock';



-- A few more examples using IN combined with other keywords
-- Find the three shortest songs from genres 'Pop' or 'Alternative'
SELECT 
    *
FROM
    songs
WHERE
    genre IN ('Pop' , 'Alternative')
ORDER BY 
    duration ASC
LIMIT 3;

-- How many songs that are neither Pop or folk are longer than 250 seconds?
SELECT 
    COUNT(*)
FROM
    songs
WHERE
    genre NOT IN ('Pop' , 'Folk')  
    -- here, NOT can either directly negate IN, as shown, or the whole condition by proceeding genre
        AND 
    duration > 250;
        

/* 

The differences between IN, LIKE, and =

IN  :  takes many values to look for, such as a list of values, and does not 
      work with the wildcards (%, _).
      
= :   takes only one value to look for and does not work with wildcards (%, _).

LIKE: takes only one value to look for and works with wildcards (%, _). 
      It is also case insentsitive. 
  
  
      
*/
        
/*******
BETWEEN
*******/

-- It is possible to search for a value BETWEEN some upper AND lower limit
-- Find all songs with duration from 200 to 300 seconds
SELECT 
    *
FROM
    songs
WHERE
    duration BETWEEN 200 AND 300;
    
-- This is equivalent to 
SELECT 
    *
FROM
    songs
WHERE
    duration >= 200   -- notice that BETWEEN is inclusive at both ends
        AND 
    duration <= 300;


-- An example using IN and BETWEEN together
-- List songs from artists with id 3, 4,  5 or 6 (The Beatles, Adele, David Bowie and Bob Dylan) 
-- released between 1965 and 1975, ordered by release year
SELECT 
    *
FROM
    songs
WHERE
    artist_id IN (3, 4, 5, 6)
        AND 
    release_year BETWEEN 1965 AND 1975
ORDER BY 
    release_year;

    