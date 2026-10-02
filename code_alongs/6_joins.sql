/*

*******************************************************************************
*******************************************************************************

SQL TUTORIAL 6: JOINS AND OTHER CLAUSES

*******************************************************************************
*******************************************************************************



*/

USE music_beginner;

-- Before getting started, we will expand our database a bit
-- Just run these lines, you don't need to understand them for now
CREATE TABLE users (first_name VARCHAR(80),last_name VARCHAR(80),email VARCHAR(80) NOT NULL,username VARCHAR(80),PRIMARY KEY (username));
INSERT INTO users (username, first_name, last_name, email) VALUES ('musicFan123','Alex','Johnson','alex.johnson@example.com'),('songLover89','Emily','Davis','emily.davis@example.com'),('melodyMaster', 'Grace', 'Miller', 'grace.miller@example.com'),('melodyCritic','Michael','Brown','michael.brown@example.com'),('tuneTracker', 'Henry', 'Moore', 'henry.moore@example.com'),('beatEnthusiast','Sarah','Wilson','sarah.wilson@example.com'),('rhythmRover','David','Martinez','david.martinez@example.com'),('soundSavant', 'Lily', 'Clark', 'lily.clark@example.com'),('classicFan','Laura','Taylor','laura.taylor@example.com'),('deepListener','James','Anderson','james.anderson@example.com'),('noteNinja', 'Jack', 'Wright', 'jack.wright@example.com'),('lyricLover','Olivia','Thomas','olivia.thomas@example.com'),('musicAficionado','Daniel','White','daniel.white@example.com'),('historyBuff','Sophia','Harris','sophia.harris@example.com'),('popFanatic','Christopher','Clark','christopher.clark@example.com'),('harmonySeeker','Isabella','Lewis','isabella.lewis@example.com'),('beatBoss', 'Ava', 'Scott', 'ava.scott@example.com'),('indieExplorer','Matthew','Robinson','matthew.robinson@example.com'),('rockRevolution','Emma','Walker','emma.walker@example.com'),('electroEagle','Joshua','Hall','joshua.hall@example.com'),('folkFollower','Mia','Young','mia.young@example.com'),('user24','Ethan','King','ethan.king@example.com');
ALTER TABLE ratings ADD CONSTRAINT FOREIGN KEY (username) REFERENCES users(username);
SET FOREIGN_KEY_CHECKS = 0;
DELETE FROM users WHERE username IN ('beatEnthusiast','popFanatic','folkFollower');
SET FOREIGN_KEY_CHECKS = 1;


-- JOINs allow you to pull tables together, so RELATIONAL, DISTRIBUTED data can be reviewed by the user in a reader-friendly fashion
-- Find all songs by the artist 'Elton John'
SELECT 
    a.artist_name, s.song_name
FROM
    songs AS s     -- tables can recieve an alias
        LEFT JOIN
	artists AS a   ON a.id = s.artist_id   -- so that column-names appearing in two tables (like id) can be uniquely identified
WHERE
    a.artist_name = 'Elton John';


-- List all UK artists and any songs they might have

SELECT 
	a.artist_name,   -- these columns don't have to be identified by table
    s.song_name,      -- but it does make things easy to read if someone reviews your code
	a.country
FROM
    artists AS a
        LEFT JOIN
    songs AS s ON a.id = s.artist_id
WHERE
    a.country = 'UK';


-- Display each song along with the reviews it has received, if any
SELECT 
    #s.id AS song_id,
    s.song_name,
    #r.id AS review_id,
    #r.song_id AS review_song_id,
    r.review
FROM
    songs s
        LEFT JOIN
    ratings r ON s.id = r.song_id;



-- List artists who have more than 3 songs
SELECT 
    a.artist_name,
    COUNT(s.id) AS total_songs
FROM
    artists AS a
        INNER JOIN
    songs AS s ON a.id = s.artist_id  
GROUP BY 
    a.artist_name
HAVING 
    COUNT(s.id) > 3;



/********
LEFT, RIGHT, INNER JOINS
*********/
-- Explore the different returns from using the three join types on this same query.
-- Notice where NULL values appear or not for each type of join

-- LEFT JOINs keep all entries from the LEFT (first) table

SELECT 
    *
FROM
	users;

SELECT 
    *
FROM
    ratings AS r
        INNER JOIN
    users AS u ON r.username = u.username;
    
-- RIGHT JOINs keep all entries from the RIGHT (second) table
SELECT 
    *
FROM
    ratings AS r
        RIGHT JOIN
    users AS u ON r.username = u.username;
    
-- INNER JOINs drop any rows that don't align to the other table
SELECT 
    *
FROM
    ratings AS r
        INNER JOIN
    users AS u ON r.username = u.username;



/********
MULTIPLE JOINS
*********/

-- You can JOIN any number of tables. The process is sequential, so the first combined tables become the "new left" table in the next JOIN. 
-- Try changing some of the JOIN types below to explore how they affect the result sets!

-- List all ratings and reviews together with their song and artists names
SELECT 
    
    r.rating, r.review, s.song_name, a.artist_name
FROM
    ratings AS r
        RIGHT JOIN
    songs AS s ON s.id = r.song_id
        RIGHT JOIN
    artists AS a ON a.id = s.artist_id;


-- Display each artist and the average rating of their songs
SELECT 
    a.artist_name, COUNT(s.id) AS num_songs, AVG(r.rating) AS average_rating
FROM
    artists AS a
        LEFT JOIN
    songs AS s ON a.id = s.artist_id
        LEFT JOIN
    ratings AS r ON s.id = r.song_id
GROUP BY 
    a.id;

 

-- List artists whose average song rating is above 9, ordered by average rating
SELECT 
    a.artist_name, AVG(r.rating) AS average_rating
FROM
    artists AS a
        INNER JOIN
    songs AS s ON a.id = s.artist_id
        INNER JOIN
    ratings AS r ON s.id = r.song_id
GROUP BY 
    a.id 
HAVING 
    AVG(r.rating) > 9
ORDER BY 
    average_rating DESC;
