# Assignment 4: PostGIS Database Orchestration
- **Student:** Victoria Swigart
- **Course:** GIST 604B – Open Source GIS
- **Module:** Module 4 – PostGIS Database Orchestration
- **University of Arizona**

## Project Description

This project develops foundational and applied skills in spatial database management using PostgreSQL and PostGIS. The assignment includes setting up a PostGIS-enabled database using Docker, importing real-world NYC spatial datasets, and writing SQL queries to perform geometry operations, spatial relationships, and spatial joins. The work emphasizes database orchestration, spatial analysis, and reproducible SQL workflows inside a containerized environment.

## Tools and Technologies

- PostgreSQL + PostGIS
- Docker / Docker Compose
- VS Code PostgreSQL Explorer
- shp2pgsql + psql command-line tools

## What I Did

- Forked the assignment repository and launched a PostGIS-enabled Codespace
- Started a PostgreSQL/PostGIS Docker container and created a working database
- Downloaded and extracted NYC spatial datasets into the repository
- Imported shapefiles into PostGIS using shp2pgsql and psql
- Completed SQL exercises covering basic queries, geometry operations, spatial relationships, and spatial joins

## How to View / Run
- Start the PostGIS container:  
docker compose up -d
- Connect to the database:  
Use PostgreSQL Explorer → Add Connection → connect to localhost:5432
- Run SQL queries:  
Open any .sql file in the sql/ folder → highlight lines → right‑click → Run Query
- View imported tables:  
Expand the nyc database in PostgreSQL Explorer to browse schemas and tables

## Repository Structure

```
/
├── sql/
│   ├── 01_basic_sql_queries.sql
│   ├── 02_geometry_queries.sql
│   ├── 03_spatial_relationships.sql
│   └── 04_spatial_joins.sql
├── demos/
│   ├── demo_aggregation_queries.sql
│   ├── demo_basic_queries.sql
│   ├── demo_filtering_queries.sql
│   └── demos_postgis_queries.sql
├── .devcontainer/
│   ├── devcontainer.json
│   └── Dockerfile
├── .gitignore
├── docker-compose.yml
└── README.md
```
