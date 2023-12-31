/* Populate database with sample data. */

INSERT INTO animals (id, name, date_of_birth, escape_attempts, neutered, weight_kg) VALUES
  (1, 'Agumon', '2020-02-03', 0, true, 10.23),
  (2, 'Gabumon', '2018-11-15', 2, true, 8),
  (3, 'Pikachu', '2021-01-07', 1, false, 15.04),
  (4, 'Devimon', '2017-05-12', 5, true, 11);

  INSERT INTO animals (id, name, date_of_birth, escape_attempts, neutered, weight_kg) VALUES 
  (5, 'Charmander', '2020-02-08', 0, false, -11),
	(6, 'Plantmon', '2022-11-15', 2, true, -5.7),
	(7, 'Squirtle', '1993-04-02', 3, false, -12.13),
  (8, 'Angemon', '2005-06-12', 1, true, -45),
  (9, 'Boarmon', '2005-06-07', 7, true, 20.4),
  (10, 'Blossom', '1998-08-13', 3, true, 17),
  (11, 'Ditto', '2022-05-14',22, true, 4);

  INSERT INTO owners (full_name, age)
VALUES
('Sam Smith', 34),
('Jennifer Orwell', 19),
('Bob', 45),
('Melody Pond', 77),
('Dean Winchester', 14),
('Jodie Whittaker', 38);

INSERT INTO species (name)
VALUES
('Pokemon'),
('Digimon');

UPDATE animals SET species_id = (
  CASE
    WHEN name LIKE '%mon' THEN 2
    ELSE 1
  END
);

UPDATE animals SET owner_id = (
  CASE
    WHEN name = 'Agumon' THEN 1
    WHEN name IN ('Gabumon', 'Pikachu') THEN 2
    WHEN name IN ('Devimon', 'Plantmon') THEN 3
    WHEN name IN ('Charmander', 'Squirtle', 'Blossom') THEN 4
    WHEN name IN ('Angemon', 'Boarmon') THEN 5
  END
);
