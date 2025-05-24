


CREATE TABLE rangers (
    ranger_id SERIAL PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    region VARCHAR(100) NOT NULL
)


INSERT INTO rangers (name, region) VALUES ('Rahim Uddin', 'Rangpur Region') , ('Mohammad Ali', 'Sundarban'), ('Nahid Hasan', 'Chittagong Hills');


CREATE TABLE species (
    species_id SERIAL PRIMARY KEY,
    common_name VARCHAR(100) NOT NULL,
    scientific_name VARCHAR(150) NOT NULL,
    discovery_date DATE NOT NULL,
    conservation_status VARCHAR(50) NOT NULL
)


INSERT INTO species (common_name, scientific_name,discovery_date,conservation_status)
VALUES ('Bengal Tiger', 'Panthera tigris' , '1758-01-01', 'Endangered'),
('Red Panda', 'Ailurus fulgens' , '1825-02-05', 'Vulnerable'),
('Asiatic Elephant' , 'Elephas maximus indicus' , '1740-03-06' , 'Vulnerable'),
('Haney Bee' , 'Apis cerana', '1910-07-28' , 'Endangered')


CREATE TABLE sightings (
    sightings_id SERIAL PRIMARY KEY,
    ranger_id INT REFERENCES rangers(ranger_id),
    species_id INT REFERENCES species(species_id),
    sighting_time TIMESTAMP NOT NULL,
    location VARCHAR(100) NOT NULL,
    notes TEXT
)


INSERT INTO sightings (ranger_id,species_id,sighting_time,location,notes)
VALUES(1 , 1, '2024-05-10 07:45:00', 'Rangpur Forest' , 'Camera trap image captured'),
(2 , 2, '2002-05-12 16:20:00', 'Chittagong hills' , NULL),
  (3 , 3, '2020-05-15 09:10:00', 'Snowfall Pass', 'Feeding observed'),  
  (2 , 1, '2004-05-18 18:30:00', 'Sundarban', 'Tiger footprints found');






--- Problem 1

INSERT INTO rangers (name,region) VALUES('Derek Fox', 'Coastal Plains');

----- Problem 2

SELECT COUNT (DISTINCT species_id) AS unique_species_count FROM sightings;


----- Problem 3

SELECT * FROM sightings WHERE location LIKE '%Pass%';


-----------Problem 4 

SELECT r.name, COUNT(s.species_id) as total_sightings from rangers r LEFT join sightings s on r.ranger_id = s.ranger_id GROUP BY r.name;


----Problem 5

SELECT common_name FROM species WHERE species_id NOT IN (SELECT DISTINCT species_id FROM sightings);


------ Problem 6

SELECT sp.common_name, s.sighting_time, r.name FROM sightings s JOIN species sp ON s.species_id = sp.species_id JOIN rangers r ON s.ranger_id = r.ranger_id ORDER BY s.sighting_time DESC LIMIT 2;



------Problem 7 

UPDATE species SET conservation_status = 'Historic' WHERE discovery_date < '1800-01-01';




----------Problem 8



SELECT species_id, 
CASE 
WHEN extract (HOUR FROM sighting_time) < 12 THEN '  Morning'
WHEN extract (HOUR FROM sighting_time) BETWEEN 12 and 17 THEN 'Afternoon'
END AS time_of_day 
FROM sightings;



----------Problem 9

DELETE FROM rangers WHERE ranger_id NOT IN (SELECT DISTINCT ranger_id from sightings);

