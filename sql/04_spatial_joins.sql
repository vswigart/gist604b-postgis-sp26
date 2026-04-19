-- Part 4: Spatial Joins Queries
-- NOTE: These queries should complete in less than 30 seconds. If they are slow, check that spatial indexes exist.

-- Example:
-- CREATE INDEX idx_nyc_streets_geom ON nyc_streets USING GIST (geom);

-- Exercise 1: What subway stations are in 'East Village'? What routes are they on?
-- Expected output: multiple rows with station name and routes
--    name      routes
-- 1	1st Ave	  L
-- 2	3rd Ave	  L

-- Hint: Use the name and routes columns from the nyc_subway_stations table
-- Hint: Use aliases ss for nyc_subway_stations and n for nyc_neighborhoods
-- Hint: Use ST_Intersects(ss.geom, n.geom) in the JOIN clause
-- Hint: Filter rows where n.name = 'East Village'

-- TODO: Write your query below
SELECT 
    ss.name AS name,
    ss.routes AS routes
FROM 
    nyc_subway_stations AS ss
JOIN 
    nyc_neighborhoods AS n
ON 
    ST_Intersects(ss.geom, n.geom)
WHERE 
    n.name = 'East Village';

-- Exercise 2: What are all the neighborhoods served by the 7-train?
-- Expected output: multiple rows with unique neighborhood names
--    neighborhood_name
-- 1	Astoria-Long Island City
-- 2	Flushing
-- 3	Garment District
-- 4	Jackson Heights
-- 5	Murray Hill
-- 6	Sunny Side
-- 7	Woodside

-- Hint: Use DISTINCT to return unique neighborhood names
-- Hint: Use the name column from the nyc_neighborhoods table
-- Hint: Use aliases ss for nyc_subway_stations and n for nyc_neighborhoods
-- Hint: Use neighborhood_name as the output alias
-- Hint: Use ST_Intersects(ss.geom, n.geom) in the JOIN clause
-- Hint: Filter rows where ss.routes LIKE '%7%'

-- TODO: Write your query below
SELECT DISTINCT
    n.name AS neighborhood_name
FROM 
    nyc_subway_stations AS ss
JOIN 
    nyc_neighborhoods AS n
ON 
    ST_Intersects(ss.geom, n.geom)
WHERE 
    ss.routes LIKE '%7%';

-- Exercise 3: How many people live in the Financial District?
-- Expected output: one row with total population
-- total_population
-- 34807

-- Hint: Use SUM() on the popn_total column in the nyc_census_blocks table
-- Hint: Use aliases cb for nyc_census_blocks and n for nyc_neighborhoods
-- Hint: Use total_population as the output alias
-- Hint: Use ST_Intersects(cb.geom, n.geom) in the JOIN clause
-- Hint: Filter rows where n.name = 'Financial District'

-- TODO: Write your query below
SELECT 
    SUM(cb.popn_total) AS total_population
FROM 
    nyc_census_blocks AS cb
JOIN 
    nyc_neighborhoods AS n
ON 
    ST_Intersects(cb.geom, n.geom)
WHERE 
    n.name = 'Financial District';

-- Exercise 4: What are the population densities (people / km^2) of the 'East Village' and 'West Village'?
-- Expected output: two rows with neighborhood name and population density per square kilometer
--    name          population_density_per_sqkm
-- 1	East Village	50404.48341332535
-- 2	West Village	25576.898694859083

-- Hint: Use the nyc_neighborhoods and nyc_census_blocks tables
-- Hint: Use aliases cb for nyc_census_blocks and n for nyc_neighborhoods
-- Hint: Population Density = SUM(cb.popn_total) / (ST_Area(n.geom) / 1000000.0)
-- Hint: Use population_density_per_sqkm as the output alias
-- Hint: Use ST_Intersects(cb.geom, n.geom) in the JOIN clause
-- Hint: Filter rows where n.name IN ('East Village', 'West Village')
-- Hint: GROUP BY n.name, n.geom

-- TODO: Write your query below
SELECT
    n.name AS name,
    SUM(cb.popn_total) / (ST_Area(n.geom) / 1000000.0) AS population_density_per_sqkm
FROM 
    nyc_census_blocks AS cb
JOIN 
    nyc_neighborhoods AS n
ON 
    ST_Intersects(cb.geom, n.geom)
WHERE 
    n.name IN ('East Village', 'West Village')
GROUP BY 
    n.name, n.geom;