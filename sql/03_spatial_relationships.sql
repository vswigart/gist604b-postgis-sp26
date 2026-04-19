-- Part 3: Spatial Relationships Queries

-- Exercise 1: What is the geometry value for the street named 'Queensboro Brg'?
-- Expected output: one row with the geometry representation
-- queensboro
-- MULTILINESTRING((588998.4638775643 4511869.804080361,589052.2228744245 4511839.352402115,589368.3007369939 4511660.247053391))
-- Hint: Use ST_AsText() on the geom column in the nyc_streets table
-- Hint: Use queensboro as the output alias
-- Hint: Filter rows where name = 'Queensboro Brg'

-- TODO: Write your query below
SELECT 
    ST_AsText(geom) AS queensboro
FROM 
    nyc_streets
WHERE 
    name = 'Queensboro Brg';

-- Exercise 2: What neighborhood and borough is Queensboro Brg in?
-- Expected output: one row with neighborhood name and borough
-- neighborhood              borough
-- Astoria-Long Island City  Queens

-- Hint: Use the name and boroname columns from the nyc_neighborhoods table
-- Hint: Use neighborhood and borough as the output aliases, respectively
-- Hint: Use ST_Intersects(geom, ...) in the WHERE clause
-- Hint: Use the SQL query from Exercise 1 to get the geometry of Queensboro Brg in the WHERE clause

-- TODO: Write your query below
SELECT 
    n.name AS neighborhood,
    n.boroname AS borough
FROM 
    nyc_neighborhoods AS n
WHERE 
    ST_Intersects(
        n.geom,
        (SELECT geom 
         FROM nyc_streets 
         WHERE name = 'Queensboro Brg')
    );

-- Exercise 3: What streets does Queensboro Brg intersect with?
-- Expected output: multiple rows with intersecting street names
--    name
-- 1	21st St
-- 2	23rd St
-- 3	Queensborough Plaza

-- Hint: Use the name column from the nyc_streets table
-- Hint: Use ST_Intersects(geom, ...) in the WHERE clause
-- Hint: Use the SQL query from Exercise 1 to get the geometry of Queensboro Brg in the WHERE clause
-- Hint: Exclude the same street using name != 'Queensboro Brg' in the WHERE clause
-- Hint: Exclude NULL street names using name IS NOT NULL in the WHERE clause

-- TODO: Write your query below
SELECT 
    name
FROM 
    nyc_streets
WHERE 
    ST_Intersects(
        geom,
        (SELECT geom 
         FROM nyc_streets 
         WHERE name = 'Queensboro Brg')
    )
    AND name IS NOT NULL
    AND name != 'Queensboro Brg';

-- Exercise 4: Approximately how many people live within 50 meters of Queensboro Brg?
-- Expected output: one row with total population
-- total_population
-- 1799

-- Hint: Use SUM() on the popn_total column in the nyc_census_blocks table
-- Hint: Use total_population as the output alias
-- Hint: Use ST_DWithin(geom, ..., 50) in the WHERE clause
-- Hint: Use the SQL query from Exercise 1 to get the geometry of Queensboro Brg in the WHERE clause

-- TODO: Write your query below
SELECT 
    SUM(popn_total) AS total_population
FROM 
    nyc_census_blocks
WHERE 
    ST_DWithin(
        geom,
        (SELECT geom 
         FROM nyc_streets 
         WHERE name = 'Queensboro Brg'),
        50
    );