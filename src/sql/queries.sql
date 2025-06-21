SELECT * FROM regions;
SELECT * FROM species;
SELECT * FROM climate;
SELECT * FROM observations;


-- MISSION 1: Queremos conocer la biodiversidad de cada región. ¿Qué regiones tienen más especies registradas?
-- Your query here;
SELECT r.name, r.country, COUNT(DISTINCT o.species_id) AS total_species
FROM regions AS r
JOIN observations AS o
    ON r.id = o.region_id
GROUP BY r.name
ORDER BY total_species DESC
LIMIT 10;

-- MISSION 2: ¿Qué meses tienen mayor actividad de observación? Agrupa por mes a partir de las fechas de observación reales. Es útil para detectar estacionalidad.
-- Your query here;
SELECT STRFTIME('%m', observation_date) AS month, COUNT(species_id) AS total_species_observations
FROM observations
GROUP BY month
ORDER BY species_observations DESC
LIMIT 5;

-- MISSION 3: Detecta las especies con pocos individuos registrados (posibles casos raros).
-- Your query here;
SELECT s.scientific_name, s.common_name, COUNT(o.species_id) AS species_observations
FROM species AS s
JOIN observations AS o
    ON s.id = o.species_id
GROUP BY s.scientific_name
HAVING species_observations < 10
ORDER BY species_observations;

-- MISSION 4: ¿Qué región tiene el mayor número de especies distintas observadas?
-- Your query here;
SELECT r.name, r.country, COUNT(DISTINCT o.species_id) AS total_species_observed
FROM regions AS r
JOIN observations AS o
    ON r.id = o.region_id
GROUP BY r.name, r.country
ORDER BY total_species_observed DESC
LIMIT 1;

-- MISSION 5: ¿Qué especies han sido observadas con mayor frecuencia?
-- Your query here;
SELECT s.id, s.scientific_name, s.common_name, COUNT(o.species_id) AS times_observed
FROM species AS s
LEFT JOIN observations AS o
    ON s.id = o.species_id
GROUP BY s.id
ORDER BY times_observed DESC
LIMIT 10;


-- MISSION 6: Queremos identificar a los observadores más activos. ¿Quiénes son las personas que más registros de observación han realizado?
-- Your query here;
SELECT observer, COUNT(observer) AS observations_of_observer
FROM observations
GROUP BY observer
ORDER BY observations_of_observer DESC
LIMIT 10;

-- MISSION 7: ¿Qué especies no han sido observadas nunca? Comprueba si existen especies en la tabla species que no aparecen en observations.
-- Your query here;
SELECT s.scientific_name, s.common_name
FROM species AS s
LEFT JOIN observations AS o
    ON s.id = o.species_id
WHERE o.species_id IS NULL;

-- MISSION 8: ¿En qué fechas se observaron más especies distintas? Esta informacion es ideal para explorar la biodiversidad máxima en días específicos.
-- Your query here;
SELECT observation_date, COUNT(DISTINCT species_id) AS observations
FROM observations
GROUP BY observation_date
ORDER BY observations DESC
LIMIT 10; 