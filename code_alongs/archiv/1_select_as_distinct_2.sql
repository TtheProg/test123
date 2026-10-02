/*

*******************************************************************************
*******************************************************************************

SQL TUTORIAL 1: SELECT, FROM, USE, AS, DISTINCT

*******************************************************************************
*******************************************************************************


*/

-- The simplest queries SELECT columns FROM a table
-- The columns are separated by commas ,
SELECT 
    song_name, 
    duration
FROM
    music_beginner.songs;


-- This query won't work though, because the database is not specified
SELECT
	artist_name, 
	country
FROM
	artists;


-- You can USE the right database to ensure the RDBMS knows where to look for tables
USE music_beginner;


-- An asterisk * is shorthand to SELECT ALL the columns in a table
SELECT 
    *
FROM
    songs;


-- SELECTed columns can be displayed with a specific name
-- this does not alter how the data is STORED, only how it is DISPLAYED
SELECT 
	song_name AS track,
    genre AS musical_type
FROM
	songs;


-- SELECT DISTINCT can be used to display a column without repeats
-- compare this output
SELECT 
    DISTINCT country
FROM
    artists;
-- to this one
SELECT
    country
FROM artists;


-- Queries can be written to answer questions about the data.
-- Which genres are represented by the songs in the database?
SELECT DISTINCT
    genre
FROM
    songs;
    