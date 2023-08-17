-- from the terminal run:
-- psql < outer_space.sql

DROP DATABASE IF EXISTS outer_space;

CREATE DATABASE outer_space;

\c outer_space

CREATE TABLE galaxy
(
  id SERIAL PRIMARY KEY,
  name TEXT NOT NULL
);

CREATE TABLE planets
(
  id SERIAL PRIMARY KEY,
  name TEXT NOT NULL,
  orbital_period_in_years FLOAT NOT NULL,
  orbits_around INT,
  galaxy_id INT,
  FOREIGN KEY (galaxy_id) REFERENCES galaxy(id),
  FOREIGN KEY (orbits_around) REFERENCES planets(id)
);

CREATE TABLE planet_moons
(
  planet_id INT,
  moon_id INT,
  PRIMARY KEY (planet_id, moon_id),
  FOREIGN KEY (planet_id) REFERENCES planets(id),
  FOREIGN KEY (moon_id) REFERENCES planets(id)
);




-- INSERT INTO planets
--   (name, orbital_period_in_years, orbits_around, galaxy, moons)
-- VALUES
--   ('Earth', 1.00, 'The Sun', 'Milky Way', '{"The Moon"}'),
--   ('Mars', 1.88, 'The Sun', 'Milky Way', '{"Phobos", "Deimos"}'),
--   ('Venus', 0.62, 'The Sun', 'Milky Way', '{}'),
--   ('Neptune', 164.8, 'The Sun', 'Milky Way', '{"Naiad", "Thalassa", "Despina", "Galatea", "Larissa", "S/2004 N 1", "Proteus", "Triton", "Nereid", "Halimede", "Sao", "Laomedeia", "Psamathe", "Neso"}'),
--   ('Proxima Centauri b', 0.03, 'Proxima Centauri', 'Milky Way', '{}'),
--   ('Gliese 876 b', 0.23, 'Gliese 876', 'Milky Way', '{}');

INSERT INTO galaxy (name)
VALUES ('Milky Way');


INSERT INTO planets
  (name, orbital_period_in_years, orbits_around, galaxy_id)
VALUES
  ('The Sun', 0.00, NULL, 1),
  ('Proxima Centauri', 0.00, NULL, 1),
  ('Earth', 1.00, 1, 1),
  ('The Moon', 0.08, 3, 1),
  ('Mars', 1.88, 1, 1),
  ('Venus', 0.62, 1, 1),
  ('Neptune', 1.64, 1, 1);



SELECT p.id, p.name, p.orbital_period_in_years, p2.name as orbits_around, g.name as galaxy FROM planets p
LEFT JOIN planets p2 ON (p.orbits_around=p2.id)
LEFT JOIN galaxy g ON (g.id = p.galaxy_id);
