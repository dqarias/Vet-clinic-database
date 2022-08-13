/* Populate database with sample data. */

/*Milestone 1*/
INSERT INTO animals (name, date_of_birth, escape_attempts, neutered, weight_kg) 
VALUES ('Agumon', '2020-02-03', 0 , true , 10.23);
INSERT INTO animals (name, date_of_birth, escape_attempts, neutered, weight_kg) 
VALUES ('Gabumon', '2018-11-15', 2 , true , 8);
INSERT INTO animals (name, date_of_birth, escape_attempts, neutered, weight_kg) 
VALUES ('Pikachu', '2021-01-07', 1 , false , 15.04);
INSERT INTO animals (name, date_of_birth, escape_attempts, neutered, weight_kg) 
VALUES ('Devimon', '2017-05-12', 5 , true , 11);

/*Milestone 2*/
INSERT INTO animals (name, date_of_birth, escape_attempts, neutered, weight_kg)
VALUES ('Charmander', '2020-02-08', 0, false, -11),
('Plantmon', '2021-11-15', 2, true, -5.7),
('Squirtle', '1993-04-02', 3, false, -12.13),
('Angemon', '2005-06-12', 1, true, -45),
('Boarmon', '2005-06-07', 7, true, 20.4),
('Blossom', '1998-10-13', 3, true, 17),
('Ditto', '2022-05-14', 4, true, 22);


/*Milestone 3*/
INSERT INTO owners (full_name, age) 
VALUES ('Sam Smith', 34),
('Jennifer Orwell', 19),
('Bob', 45),
('Melody Pond', 77),
('Dean Winchester', 14),
('Jodie Whittaker', 38);

INSERT INTO species (name) VALUES
('digimon'),
('pokemon');

UPDATE animals 
SET species_id=(SELECT id FROM species WHERE name = 'digimon') 
WHERE name LIKE '%mon';

UPDATE animals 
SET species_id=(SELECT id FROM species WHERE name = 'pokemon') 
WHERE species_id IS NULL;

UPDATE animals 
SET owners_id=(SELECT id FROM owners WHERE full_name = 'Sam Smith') 
WHERE name IN ('Agumon');

UPDATE animals
SET owners_id=(SELECT id FROM owners WHERE full_name= 'Jennifer Orwell')
WHERE name IN ('Gabumon', 'Pikachu');

UPDATE animals
SET owners_id=(SELECT id FROM owners WHERE full_name= 'Bob')
WHERE name IN ('Plantmon');

UPDATE animals
SET owners_id=(SELECT id FROM owners WHERE full_name = 'Melody Pond')
WHERE name IN ('Charmander', 'Squirtle' , 'Blossom');

UPDATE animals
SET owners_id=(SELECT id FROM owners WHERE full_name = 'Dean Winchester')
WHERE name IN ('Angemon', 'Boarmon');

/*Milestone 4*/
--Insert data for vets
INSERT INTO vets (name, age, date_of_graduation)
VALUES ('William Tatcher', 45, '2000-04-23'),
('Maisy Smith', 26, '2019-01-17'),
('Stephanie Mendez', 64, '1981-05-04'),
('Jack Harkness', 38, '2008-06-08');

--Insert data for specializations
INSERT INTO specializations (species_id, vets_id) 
VALUES ((SELECT id FROM species WHERE name IN ('pokemon')), 
(SELECT id FROM vets WHERE name IN ('William Tatcher')));
INSERT INTO specializations (species_id, vets_id)
SELECT species.id, vets.id FROM species 
INNER JOIN vets 
ON species.name IN ('pokemon','digimon')
AND vets.name = 'Stephanie Mendez';
INSERT INTO specializations (species_id, vets_id)
VALUES ((SELECT id FROM species WHERE name IN ('digimon')),
(SELECT id FROM vets WHERE name IN ('Jack Harkness')));

--Insert data for visits
INSERT INTO visits (animals_id, vets_id, date_of_visit)
VALUES ((SELECT id FROM animals WHERE name IN ('Agumon')),
(SELECT id FROM vets WHERE name IN ('William Tatcher')),
'2020-05-24'),
((SELECT id FROM animals WHERE name IN ('Agumon')),
(SELECT id FROM vets WHERE name IN ('Stephanie Mendez')),
'2020-07-22'),
((SELECT id FROM animals WHERE name IN ('Gabumon')),
(SELECT id FROM vets WHERE name IN ('Jack Harkness')),
'2021-02-02'),
 ((SELECT id FROM animals WHERE name IN ('Pikachu')),
(SELECT id FROM vets WHERE name IN ('Maisy Smith')),
'2020-01-05'),
((SELECT id FROM animals WHERE name IN ('Pikachu')),
(SELECT id FROM vets WHERE name IN ('Maisy Smith')),
'2020-04-08'),
((SELECT id FROM animals WHERE name IN ('Pikachu')),
(SELECT id FROM vets WHERE name IN ('Maisy Smith')),
'2020-05-14'),
((SELECT id FROM animals WHERE name IN ('Devimon')),
(SELECT id FROM vets WHERE name IN ('Stephanie Mendez')),
'2021-05-04'),
((SELECT id FROM animals WHERE name IN ('Charmander')),
(SELECT id FROM vets WHERE name IN ('Jack Harkness')),
'2021-02-24'),
((SELECT id FROM animals WHERE name IN ('Plantmon')),
(SELECT id FROM vets WHERE name IN ('Maisy Smith')),
'2019-12-21'),
((SELECT id FROM animals WHERE name IN ('Plantmon')),
(SELECT id FROM vets WHERE name IN ('William Tatcher')),
'2020-08-10'),
((SELECT id FROM animals WHERE name IN ('Plantmon')),
(SELECT id FROM vets WHERE name IN ('Maisy Smith')),
'2021-04-07'),
((SELECT id FROM animals WHERE name IN ('Squirtle')),
(SELECT id FROM vets WHERE name IN ('Stephanie Mendez')),
'2019-09-29'),
((SELECT id FROM animals WHERE name IN ('Angemon')),
(SELECT id FROM vets WHERE name IN ('Jack Harkness')),
'2020-10-03'),
((SELECT id FROM animals WHERE name IN ('Angemon')),
(SELECT id FROM vets WHERE name IN ('Jack Harkness')),
'2020-11-04'),
((SELECT id FROM animals WHERE name IN ('Boarmon')),
(SELECT id FROM vets WHERE name IN ('Maisy Smith')),
'2019-01-24'),
((SELECT id FROM animals WHERE name IN ('Boarmon')),
(SELECT id FROM vets WHERE name IN ('Maisy Smith')),
'2019-05-15'),
((SELECT id FROM animals WHERE name IN ('Boarmon')),
(SELECT id FROM vets WHERE name IN ('Maisy Smith')),
'2020-02-27'),
((SELECT id FROM animals WHERE name IN ('Boarmon')),
(SELECT id FROM vets WHERE name IN ('Maisy Smith')),
'2019-08-03'),
((SELECT id FROM animals WHERE name IN ('Blossom')),
(SELECT id FROM vets WHERE name IN ('Stephanie Mendez')),
'2020-05-24'),
((SELECT id FROM animals WHERE name IN ('Blossom')),
(SELECT id FROM vets WHERE name IN ('William Tatcher')),
'2021-01-11');

