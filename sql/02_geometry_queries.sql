-- Part 2: Geometry Queries

-- Exercise 1: What is the area of the 'New Brighton' neighborhood?
-- Expected output: one row with the area of New Brighton in square meters
-- new_brighton_area_sq_m
-- 9273006.48915705

-- Hint: Use ST_Area() on the geom column
-- Hint: Use new_brighton_area_sq_m as the output alias
-- Hint: Use the nyc_neighborhoods table
-- Hint: Filter rows where name = 'New Brighton'
-- Note: Units will be in square meters (CRS is UTM Zone 18N, EPSG:26918)

-- TODO: Write your query below
SELECT 
    ST_Area(geom) AS new_brighton_area_sq_m
FROM 
    nyc_neighborhoods
WHERE 
    name = 'New Brighton';

-- Exercise 2: What is the area of the Bronx in acres?
-- Expected output: one row with the total area of the Bronx in acres
-- bronx_area_acres
-- 25861.8413576662

-- Hint: Use ST_Union() to combine all neighborhoods in Bronx, then ST_Area()
-- Hint: 1 Acre = 4046.86 square meters
-- Hint: Use bronx_area_acres as the output alias
-- Hint: Use the nyc_neighborhoods table
-- Hint: Filter rows where boroname = 'The Bronx'

-- TODO: Write your query below
SELECT 
    ST_Area(ST_Union(geom)) / 4046.86 AS bronx_area_acres
FROM 
    nyc_neighborhoods
WHERE 
    boroname = 'The Bronx';

-- Exercise 3: How many census blocks in New York City DO NOT have a hole in them?
-- Expected output: one row with the count of census blocks without holes
-- no_hole_polygons
-- 0

-- Hint: Use COUNT(*)
-- Hint: Use no_hole_polygons as the output alias
-- Hint: Use the nyc_census_blocks table
-- Hint: Filter where ST_NumInteriorRings(geom) = 0
-- Hint: ST_NumInteriorRings(geom) = 0 means no holes (interior rings)

-- TODO: Write your query below
SELECT 
    COUNT(*) AS no_hole_polygons
FROM 
    nyc_census_blocks
WHERE 
    ST_NumInteriorRings(geom) = 0;

-- Exercise 4: What is the total length of streets (in miles) in New York City?
-- Expected output: one row with total street length in miles
-- total_length_miles
-- 6474.023337020143

-- Hint: Use ST_Length() on the geom column 
-- Hint: Use SUM() to total the length
-- Hint: 1 mile = 1609.34 meters
-- Hint: Use total_length_miles as the output alias
-- Hint: Use the nyc_streets table

-- TODO: Write your query below
SELECT 
    SUM(ST_Length(geom)) / 1609.34 AS total_length_miles
FROM 
    nyc_streets;

-- Exercise 5: How long is '5th Ave' in meters?
-- Expected output: one row with the length of 5th Ave
-- fifth_ave_length
-- 21797.515432910186

-- Hint: Use ST_Length() on the geom column 
-- Hint: Use SUM() to total the length
-- Hint: Use fifth_ave_length as the output alias
-- Hint: Use the nyc_streets table
-- Hint: Filter rows where name = '5th Ave'

-- TODO: Write your query below
SELECT 
    SUM(ST_Length(geom)) AS fifth_ave_length
FROM 
    nyc_streets
WHERE 
    name = '5th Ave';

-- Exercise 6: What is the JSON representation of the boundary of 'Soho'?
-- Expected output: one row with GeoJSON representation
-- soho_geojson
-- {"type":"MultiPolygon","crs":{"type":"name","properties":{"name":"EPSG:26918"}},"…

-- Hint: Use ST_AsGeoJSON() on the geom column 
-- Hint: Use soho_geojson as the output alias
-- Hint: Use the nyc_neighborhoods table
-- Hint: Filter rows where name = 'Soho'

-- TODO: Write your query below
SELECT 
    ST_AsGeoJSON(geom) AS soho_geojson
FROM 
    nyc_neighborhoods
WHERE 
    name = 'Soho';

-- Exercise 7: How many polygons are in the 'Coney Island' multipolygon?
-- Expected output: one row with the number of polygons
-- num_coney_island_polygons
-- 4

-- TODO: Write a SELECT statement to count geometries in 'Coney Island'
-- Hint: Use ST_NumGeometries() on the geom column 
-- Hint: Use num_coney_island_polygons as the output alias
-- Hint: Use the nyc_neighborhoods table
-- Hint: Filter rows where name = 'Coney Island'
SELECT 
    ST_NumGeometries(geom) AS num_coney_island_polygons
FROM 
    nyc_neighborhoods
WHERE 
    name = 'Coney Island';

-- Exercise 8: What are the 5 longest roads in NYC?
-- Expected output: five rows with road names and lengths in meters
--    name               length_meters
-- 1	Leif Ericson Dr	   14918.122617388475
-- 2	Hylan Blvd	       14010.05123693547
-- 3	Grand Central Pky	 14004.747129767076
-- 4	Nostrand Ave	     12916.485763265595
-- 5	Ocean Ave	         12342.720041053057


-- Hint: Use ST_Length() on the geom column
-- Hint: Use length_meters as the output alias
-- Hint: Use the nyc_streets table
-- Hint: ORDER BY ST_Length(geom) DESC OR use the alias length_meters
-- Hint: Use LIMIT 5
SELECT 
    name,
    SUM(ST_Length(geom)) AS length_meters
FROM 
    nyc_streets
GROUP BY 
    name
ORDER BY 
    length_meters DESC
LIMIT 5;