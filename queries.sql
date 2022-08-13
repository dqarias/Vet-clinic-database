/*Queries that provide answers to the questions from all projects.*/

/* Milestone 1 */
SELECT * FROM animals WHERE name LIKE '%mon';
SELECT name FROM animals WHERE date_of_birth BETWEEN '2016-01-01' AND '2019-12-31';
SELECT name FROM animals WHERE neutered = true AND escape_attempts < 3;
SELECT date_of_birth FROM animals WHERE name IN ('Agumon', 'Pikachu');
SELECT name, escape_attempts FROM animals WHERE weight_kg > 10.5;
SELECT * FROM animals WHERE neutered = true;
SELECT * FROM animals WHERE name NOT IN ('Gabumon');
SELECT * FROM animals WHERE weight_kg >= 10.4 AND weight_kg <=17.3;

/* Milestone 2*/

-- Transaction 1 
BEGIN;
UPDATE animals SET species='unspecified';
SELECT * FROM animals;
ROLLBACK;
SELECT * FROM animals;

-- Transaction 2
BEGIN;
UPDATE animals SET species='digimon' WHERE name LIKE '%mon';
SELECT * FROM animals;
UPDATE animals SET species='pokemon' WHERE species IS NULL;
SELECT * FROM animals;
COMMIT;
SELECT * FROM animals;

-- Transaction 3
BEGIN;
DELETE FROM animals;
SELECT COUNT(*) FROM ANIMALS;
ROLLBACK;
SELECT COUNT(*) FROM ANIMALS;

-- Transaction 4
BEGIN;
DELETE FROM animals WHERE date_of_birth > '2022-01-01';
SAVEPOINT SP1;
SELECT * FROM animals;
UPDATE animals SET weight_kg = weight_kg * -1;
SELECT * FROM animals;
ROLLBACK TO SP1;
SELECT * FROM animals;
UPDATE animals SET weight_kg = weight_kg * -1 WHERE weight_kg < 0;
SELECT * FROM animals;
COMMIT;
SELECT * FROM animals;

-- Queries

-- How many animals are there?
SELECT COUNT(*) FROM animals;
-- How many animals have never tried to escape?
SELECT COUNT(*) FROM animals WHERE escape_attempts = 0;
-- What is the average weight of animals?
SELECT AVG(weight_kg) FROM animals;
-- Who escapes the most, neutered or not neutered animals?
SELECT SUM(escape_attempts), neutered FROM animals GROUP BY neutered;
-- What is the minimum and maximum weight of each type of animal?
SELECT MIN(weight_kg), MAX(weight_kg), species from animals GROUP BY species;
-- What is the average number of escape attempts per animal type of those born between 1990 and 2000?
SELECT species, AVG(escape_attempts) FROM animals WHERE date_of_birth >= '1990/01/01' AND date_of_birth <= '2000/12/31' GROUP BY species;

/*Milestone 3*/

-- What animals belong to Melody Pond?
SELECT animals.name as animal_name, owners.full_name as owner_name 
FROM animals 
INNER JOIN owners 
ON owners_id = owners.id WHERE owners.full_name = 'Melody Pond';

-- List of all animals that are pokemon (their type is Pokemon).
SELECT animals.name as animals_name, species.name as specie
FROM animals
INNER JOIN species
ON species_id = species.id WHERE species.name='pokemon';

-- List all owners and their animals, remember to include those that don't own any animal.
SELECT owners.full_name as owners_name, animals.name as animals_name
FROM animals
RIGHT JOIN owners
ON owners_id = owners.id;

-- How many animals are there per species?
SELECT species.name as specie, count(animals.name)
FROM animals
INNER JOIN species
ON species_id = species.id
GROUP BY species.name;

-- List all Digimon owned by Jennifer Orwell.
SELECT animals.name as animal_name, owners.full_name as owner_name
FROM animals
INNER JOIN owners
ON owners_id = owners.id
WHERE species_id = (SELECT id FROM species WHERE name IN ('digimon')) 
AND owners_id = (SELECT id FROM owners WHERE full_name='Jennifer Orwell');

-- List all animals owned by Dean Winchester that haven't tried to escape.
SELECT animals.name as animal_name, owners.full_name as owner_name 
FROM animals
INNER JOIN owners
ON owners_id = owners.id
WHERE animals.escape_attempts = 0 
AND owners_id = (SELECT id FROM owners WHERE full_name='Dean Winchester');

-- Who owns the most animals?

SELECT owners.full_name as owner_name, count(animals.name)
FROM animals
INNER JOIN owners
ON owners_id = owners.id
GROUP BY owners.full_name
ORDER BY count(animals.name) DESC LIMIT 1;

/*Milestone 4*/
-- Who was the last animal seen by William Tatcher?
SELECT animals.name, vets.name, visits.date_of_visit 
FROM visits 
INNER JOIN animals ON animals_id = animals.id 
INNER JOIN vets ON vets_id = vets.id
WHERE vets.name IN ('William Tatcher')
ORDER BY visits.date_of_visit DESC LIMIT 1;

-- How many different animals did Stephanie Mendez see?
SELECT COUNT(animals.name), vets.name
FROM visits
INNER JOIN animals ON animals_id = animals.id
INNER JOIN vets ON vets_id = vets.id
WHERE vets.name IN ('Stephanie Mendez')
GROUP BY vets.name;

-- List all vets and their specialties, including vets with no specialties.
SELECT vets.name, species.name 
FROM vets
LEFT JOIN specializations ON vets.id = specializations.vets_id
LEFT JOIN species ON specializations.species_id = species.id;

-- List all animals that visited Stephanie Mendez between April 1st and August 30th, 2020.
SELECT vets.name, animals.name
FROM visits
INNER JOIN vets ON vets_id = vets.id
INNER JOIN animals ON animals_id = animals.id
WHERE vets.name IN ('Stephanie Mendez') AND date_of_visit BETWEEN '2020-04-01' AND '2020-08-30';

-- What animal has the most visits to vets?
SELECT animals.name, COUNT(visits.vets_id) 
FROM visits
INNER JOIN vets ON vets_id = vets.id
INNER JOIN animals ON animals_id = animals.id
GROUP BY animals.name
ORDER BY COUNT(visits.vets_id) DESC LIMIT 1;

-- Who was Maisy Smith's first visit?
SELECT vets.name, animals.name, date_of_visit
FROM visits
INNER JOIN vets ON vets_id = vets.id
INNER JOIN animals ON animals_id = animals.id
WHERE vets.name IN ('Maisy Smith')
ORDER BY date_of_visit LIMIT 1;

-- Details for most recent visit: animal information, vet information, and date of visit.
SELECT animals.*, vets.*, date_of_visit
FROM visits
INNER JOIN vets ON vets_id = vets.id
INNER JOIN animals ON animals_id = animals.id
ORDER BY date_of_visit DESC LIMIT 5;

-- How many visits were with a vet that did not specialize in that animal's species?
SELECT count(visits.vets_id)
FROM visits
LEFT JOIN animals ON animals_id = animals.id
LEFT JOIN vets ON vets_id = vets.id
WHERE animals.species_id NOT IN 
(SELECT species_id FROM specializations WHERE vets_id = vets.id);

-- What specialty should Maisy Smith consider getting? Look for the species she gets the most.
SELECT species.name, COUNT(*)
FROM visits
INNER JOIN vets ON vets_id = vets.id
INNER JOIN animals ON animals_id = animals.id
INNER JOIN species ON animals.species_id = species.id
GROUP BY species.name, vets.name HAVING vets.name = 'Maisy Smith'
ORDER BY COUNT(*) DESC LIMIT 1;