/******************************************************************************
*******************************************************************************

SQL TUTORIAL 3: ORDER BY, LIMIT, and Aggregates

*******************************************************************************
******************************************************************************/

-- Start by selecting a database
USE music_beginner;

/*******
ORDER BY:
*******/

-- Result sets can be sorted with ORDER BY

-- List all songs by their release year 
SELECT 
    *
FROM
    songs
ORDER BY release_year;
    
-- The order can be reversed using DESC (for descending)
SELECT 
    *
FROM
    songs
ORDER BY 
    release_year DESC;


-- ORDERing BY multiple columns will sort by the first column listed, and resolve any ties in that column by sorting the second

-- List all the songs sorted by their release year, with the most recent one at the top.
-- Songs from the same year should appear alphabetically
SELECT 
    song_name, release_year
FROM
    songs
ORDER BY 
    release_year DESC,  -- columns can be sorted in different orders
    song_name ASC;      -- ASC sorts the same as the default


/*******
LIMIT:
*******/
-- To control the number of rows appearing in a result set, simply set a LIMIT

-- List 5 artists
SELECT 
    *
FROM 
    artists
LIMIT 
    5;

-- LIMITs can be combinded with ORDER BY to find the "most" of some quality
-- Find the 5 shortest songs
SELECT 
    *
FROM
    songs
ORDER BY 
    duration
LIMIT 5;


-- Find the first 3 artists to debut
SELECT 
    artist_name, debut_year
FROM
    artists
ORDER BY 
    debut_year ASC
LIMIT 3;



-- Be careful, because if there's a tie LIMIT only takes into account the number of rows
-- Find the 3 highest ratings and the review left with them
SELECT 
    rating, 
    username, 
    review 
FROM 
    ratings
ORDER BY 
    rating DESC
LIMIT 3;

-- Compare to this result:
SELECT 
    rating, 
    username, 
    review 
FROM 
    ratings
ORDER BY 
    rating DESC
LIMIT 5;  
-- A 9.6 rating was made 3 separate times!
-- Without further ordering, the RDBMS might return different results for the "third best" rating to different users


/*******
Aggregate functions
*******/

-- More than just letting the user see the data, it is possible to use SQL to summarise data

-- COUNT() counts the rows returned
-- Determine the total number of songs in the database

SELECT 
    *
FROM
    songs;
    
SELECT 
    COUNT(*) AS total_number_of_songs
FROM
    songs;

-- In COUNT(), a column can be given as an argument, then it will only count the number of non-null entries in that column
-- Study the artists table first:
SELECT 
    * 
FROM 
    artists;
    
-- Then compare the two counts. Do you understand why they are different?
SELECT 
    COUNT(*) AS num_artists,
    COUNT(birthdate) AS num_birthdays
FROM 
    artists;


-- AVG() calculates the mean of a column's values
-- Calculate the average duration (in seconds) of all songs
SELECT 
    AVG(duration) AS average_duration
FROM
    songs;

SELECT
	*
FROM
	songs;

-- Different aggregates can be calculated in one result set
-- Find the average, minimum, and maximum ratings of all songs
SELECT 
    AVG(rating) AS average_rating,
    MIN(rating) AS min_rating,      -- MIN() finds the minimum value in a column
    MAX(rating) AS max_rating       -- MAX() finds the maximum value in a column
FROM
    ratings;

SELECT
	*
FROM
	ratings;
 
-- Aggregates can be combined with filters using WHERE. Then, only rows meeting the filter condition will be aggregated
-- Find the number of songs released after the year 2000, excluding the genres 'Pop' and 'Rock'

SELECT 
    COUNT(*) AS num_songs_no_pop_rock
FROM
    songs
WHERE
    release_year > 2000
        AND 
    NOT genre = 'Pop' 
        AND
    NOT genre = 'Rock';
-- You can manually scan the full songs table to confirm what is happening!


-- A few more examples:
-- Count the number of songs that have a duration shorter than three and a half minutes 
SELECT 
    COUNT(*) AS songs_shorter_than_average
FROM
    songs
WHERE
    duration < 210;


-- Identify the earliest debut year of an artist who is not from the UK
SELECT 
    MIN(debut_year) AS earliest_debut
FROM
    artists
WHERE
    country != 'UK';
