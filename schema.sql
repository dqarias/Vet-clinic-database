/* Database schema to keep the structure of entire database. */

/* Milestone 1 */
-- Create animals table
CREATE TABLE animals (
    id INT GENERATED ALWAYS AS IDENTITY,
    name VARCHAR(100) NOT NULL,
    date_of_birth DATE NOT NULL,
    escape_attempts INT NOT NULL,
    neutered BOOLEAN NOT NULL,
    weight_kg DECIMAL NOT NULL,
    PRIMARY KEY(id)
);

/* Milestone 2 */

-- Add a column species on animals table
ALTER TABLE animals 
ADD COLUMN species VARCHAR(50);

/* Milestone 3 */

-- Create a table named owners

CREATE TABLE owners (
    id INT GENERATED ALWAYS AS IDENTITY,
    full_name VARCHAR(100) NOT NULL,
    age INT NOT NULL,
    PRIMARY KEY(id)
);

-- Create a table named species

CREATE TABLE species (
    id INT GENERATED ALWAYS AS IDENTITY,
    name VARCHAR(50) NOT NULL,
    PRIMARY KEY(id)
);

--Modify animals table:
ALTER TABLE animals 
DROP COLUMN species;

ALTER TABLE animals
ADD COLUMN species_id INT;

ALTER TABLE animals
ADD CONSTRAINT fk_species
FOREIGN KEY (species_id)
REFERENCES species (id)
ON DELETE CASCADE;

ALTER TABLE animals
ADD COLUMN owners_id INT;

ALTER TABLE animals
ADD CONSTRAINT fk_owners
FOREIGN KEY (owners_id)
REFERENCES owners (id)
ON DELETE CASCADE;

/*Milestone 4*/

-- Create a table named vets

CREATE TABLE vets (
    id INT GENERATED ALWAYS AS IDENTITY,
    name VARCHAR(50) NOT NULL,
    age INT NOT NULL,
    date_of_graduation DATE,
    PRIMARY KEY (id)
);

-- Create a "join table" called specializations

CREATE TABLE specializations (
    species_id INT,
    vets_id INT,
    CONSTRAINT fk_species
    FOREIGN KEY (species_id)
    REFERENCES species (id)
    ON DELETE CASCADE,
    CONSTRAINT fk_vets
    FOREIGN KEY (vets_id)
    REFERENCES vets (id)
    ON DELETE CASCADE
);

-- Create a "join table" called visits to handle this relationship

CREATE TABLE visits (
    animals_id INT,
    vets_id INT,
    date_of_visit DATE,
    CONSTRAINT fk_animals
    FOREIGN KEY (animals_id)
    REFERENCES animals (id)
    ON DELETE CASCADE,
    CONSTRAINT fk_vets
    FOREIGN KEY (vets_id)
    REFERENCES vets (id)
    ON DELETE CASCADE
);

/*Milestone 4*/

-- Performance audit for: EXPLAIN ANALYZE SELECT COUNT(*) FROM visits where animal_id = 4;
CREATE INDEX animals_asc ON visits(animals_id ASC);


