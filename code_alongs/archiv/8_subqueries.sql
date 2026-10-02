/*

*******************************************************************************
*******************************************************************************

SQL TUTORIAL 8: Subqueries

*******************************************************************************
*******************************************************************************


*/

USE music_beginner;

-- Subqueries can be used to compare values to a derived value
-- 1. Find the songs with a longer duration than average
SELECT 
    song_name
FROM
    songs
WHERE
    duration > (SELECT AVG(duration) FROM songs);
    
-- Find each song's biggest fans. List all users who have rated that song higher than the song's average.
SELECT 
    song_name, username 
FROM 
    songs AS s 
        JOIN 
    ratings AS r ON r.song_id = s.id
WHERE 
    rating > (  SELECT AVG(rating)
    		    FROM ratings rs
    		    WHERE rs.song_id = r.song_id    )
ORDER BY song_name;


-- Subqueries are quite flexible, and can appear almost anywhere in a query
-- 2. Select the longest song in each genre
SELECT 
    genre, song_name
FROM
    songs
JOIN
    (   SELECT genre, MAX(duration) AS longest
        FROM songs GROUP BY genre           ) AS genre_longest  -- subqueries in FROM or JOIN clauses must have an alias
	USING (genre)
WHERE
    duration = longest;


-- Sometimes, subqueries can offer performance gains over queries performed with joins. Compare the run times of these two queries.
-- 3. List the names of all songs performed by artists who debuted before 1970.            
SELECT *
FROM songs
JOIN artists ON songs.artist_id = artists.id
WHERE debut_year < 1970;

SELECT song_name 
FROM songs 
WHERE artist_id IN (SELECT id 
                    FROM artists 
                    WHERE debut_year < 1970);


-- Subqueries can be easier to read or write, though they may take some time to get used to. These two queries return the same results.
-- 4. Find the average rating for each song and display it alongside the song name.
SELECT 
    song_name, AVG(rating)
FROM
    songs s
        LEFT JOIN
    ratings ON s.id = ratings.song_id
GROUP BY s.id;

SELECT song_name, 
       (SELECT AVG(rating) 
        FROM ratings r 
        WHERE r.song_id = s.id) AS avg_rating
FROM songs s;

