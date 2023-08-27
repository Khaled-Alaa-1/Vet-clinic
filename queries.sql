SELECT *
FROM ANIMALS
WHERE NAME LIKE '%mon';


SELECT NAME
FROM ANIMALS
WHERE DATE_OF_BIRTH BETWEEN '2016-01-01' AND '2019-12-31';


SELECT NAME
FROM ANIMALS
WHERE NEUTERED = TRUE
	AND ESCAPE_ATTEMPTS < 3;


SELECT DATE_OF_BIRTH
FROM ANIMALS
WHERE NAME IN ('Agumon',
																'Pikachu');


SELECT NAME,
	ESCAPE_ATTEMPTS
FROM ANIMALS
WHERE WEIGHT_KG > 10.5;


SELECT *
FROM ANIMALS
WHERE NEUTERED = TRUE;


SELECT *
FROM ANIMALS
WHERE NAME != 'Gabumon';


SELECT *
FROM ANIMALS
WHERE WEIGHT_KG BETWEEN 10.4 AND 17.3;

BEGIN;


UPDATE ANIMALS
SET SPECIES = 'unspecified';


SELECT *
FROM ANIMALS;


ROLLBACK;


SELECT *
FROM ANIMALS;

BEGIN;


UPDATE ANIMALS
SET SPECIES = 'digimon'
WHERE NAME LIKE '%mon';


UPDATE ANIMALS
SET SPECIES = 'pokemon'
WHERE SPECIES = 'unspecified';


SELECT *
FROM ANIMALS;


COMMIT;


SELECT *
FROM ANIMALS;

BEGIN;


DELETE
FROM ANIMALS;


ROLLBACK;


SELECT *
FROM ANIMALS;

BEGIN;


DELETE
FROM ANIMALS
WHERE DATE_OF_BIRTH > '2022-01-01';

SAVEPOINT MY_SAVEPOINT;


UPDATE ANIMALS
SET WEIGHT_KG = WEIGHT_KG * -1;


ROLLBACK TO MY_SAVEPOINT;


UPDATE ANIMALS
SET WEIGHT_KG = WEIGHT_KG * -1
WHERE WEIGHT_KG < 0;


COMMIT;


SELECT *
FROM ANIMALS;


SELECT COUNT(*)
FROM ANIMALS;


SELECT COUNT(*)
FROM ANIMALS
WHERE ESCAPE_ATTEMPTS = 0;


SELECT AVG(WEIGHT_KG)
FROM ANIMALS;


SELECT NEUTERED,
	AVG(ESCAPE_ATTEMPTS)
FROM ANIMALS
GROUP BY NEUTERED;


SELECT SPECIES,
	MIN(WEIGHT_KG),
	MAX(WEIGHT_KG)
FROM ANIMALS
GROUP BY SPECIES;


SELECT SPECIES,
	AVG(ESCAPE_ATTEMPTS)
FROM ANIMALS
WHERE DATE_OF_BIRTH BETWEEN '1990-01-01' AND '2000-12-31'
GROUP BY SPECIES;

-- What animals belong to Melody Pond?

SELECT ANIMALS.NAME
FROM ANIMALS
JOIN OWNERS ON ANIMALS.OWNER_ID = OWNERS.ID
WHERE OWNERS.FULL_NAME = 'Melody Pond';

-- List of all animals that are pokemon (their type is Pokemon)

SELECT ANIMALS.NAME
FROM ANIMALS
JOIN SPECIES ON ANIMALS.SPECIES_ID = SPECIES.ID
WHERE SPECIES.NAME = 'Pokemon';

-- List all owners and their animals, remember to include those that don't own any animal

SELECT OWNERS.FULL_NAME,
	ANIMALS.NAME
FROM OWNERS
LEFT JOIN ANIMALS ON OWNERS.ID = ANIMALS.OWNER_ID;

-- How many animals are there per species?

SELECT SPECIES.NAME,
	COUNT(*) AS COUNT
FROM ANIMALS
JOIN SPECIES ON ANIMALS.SPECIES_ID = SPECIES.ID
GROUP BY SPECIES.NAME;

-- List all Digimon owned by Jennifer Orwell

SELECT ANIMALS.NAME
FROM ANIMALS
JOIN SPECIES ON ANIMALS.SPECIES_ID = SPECIES.ID
JOIN OWNERS ON ANIMALS.OWNER_ID = OWNERS.ID
WHERE OWNERS.FULL_NAME = 'Jennifer Orwell'
	AND SPECIES.NAME = 'Digimon';

-- List all animals owned by Dean Winchester that haven't tried to escape

SELECT ANIMALS.NAME
FROM ANIMALS
JOIN OWNERS ON ANIMALS.OWNER_ID = OWNERS.ID 
WHERE OWNERS.FULL_NAME = 'Dean Winchester'
	AND ANIMALS.ESCAPE_ATTEMPTS = 0;

-- SELECT owners.full_name, COUNT(*) AS count

SELECT OWNERS.FULL_NAME,
	COUNT(*) AS COUNT
FROM ANIMALS
JOIN OWNERS ON ANIMALS.OWNER_ID = OWNERS.ID
GROUP BY OWNERS.FULL_NAME
ORDER BY COUNT DESC
LIMIT 1;

SELECT animals.name AS animal_name, visits.visit_date, vets.name AS vet_name
FROM animals
JOIN visits
ON animals.id = visits.animal_id
JOIN vets
ON visits.vet_id = vets.id
WHERE vets.name ILIKE 'william tatcher'
ORDER BY visit_date DESC
LIMIT 1

SELECT COUNT(DISTINCT animals.name) AS result
FROM animals
JOIN visits
ON animals.id = visits.animal_id
JOIN vets
ON visits.vet_id = vets.id
WHERE vets.name ILIKE 'stephanie mendez';

SELECT vets.name AS vet_name, species.name AS specialized_in
FROM vets
LEFT JOIN specializations
ON vets.id = specializations.vet_id
LEFT JOIN species
ON specializations.species_id = species.id;

SELECT animals.name AS animal_name, vets.name AS vet_name, visits.visit_date
FROM animals
JOIN visits
ON animals.id = visits.animal_id
JOIN vets
ON visits.vet_id = vets.id
WHERE vets.name ILIKE 'stephanie mendez'
AND visits.visit_date >= '2020-04-01'
AND visits.visit_date <= '2020-08-30';

SELECT animals.name, COUNT(animals.name)
FROM animals
JOIN visits
ON animals.id = visits.animal_id
GROUP BY animals.name
ORDER BY COUNT(animals.name) DESC LIMIT 1;

SELECT animals.name AS animal_name, vets.name AS vet_name, visits.visit_date
FROM animals
JOIN visits
ON animals.id = visits.animal_id
JOIN vets
ON visits.vet_id = vets.id
WHERE vets.name ILIKE 'Maisy Smith'
ORDER BY visits.visit_date LIMIT 1;

SELECT a.name, a.date_of_birth, a.escape_attempts, a.neutered, a.weight_kg, v.name, v.age, v.date_of_graduation, visits.visit_date
FROM animals AS a
JOIN visits ON a.id = visits.animal_id 
JOIN vets AS v ON visits.vet_id = v.id
ORDER BY visits.visit_date DESC LIMIT 1;

SELECT vets.name AS vet_name, species.name AS specialized_in,
       CASE WHEN animals.name ILIKE '%mon' THEN 'Digimon' ELSE 'Pokemon' END AS specie_attended
FROM vets
JOIN specializations AS sp ON vets.id = sp.vet_id
JOIN species ON sp.species_id = species.id
JOIN visits ON vets.id = visits.vet_id
JOIN animals ON visits.animal_id = animals.id
WHERE species.id != animals.species_id;

SELECT vets.name AS vet_name, species.name AS attended_species, COUNT(*) AS total_attended
FROM vets
JOIN visits ON vets.id = visits.vet_id
JOIN animals ON visits.animal_id = animals.id
JOIN species ON animals.species_id = species.id
WHERE vets.name ILIKE 'Maisy Smith'
GROUP BY vets.name, species.name
ORDER BY total_attended DESC LIMIT 1;