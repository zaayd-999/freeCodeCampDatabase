CREATE TABLE galaxy (
    galaxy_id SERIAL PRIMARY KEY,
    name VARCHAR(255) UNIQUE NOT NULL,
    description TEXT,
    has_life BOOLEAN NOT NULL,
    is_spherical BOOLEAN NOT NULL,
    age_in_millions_of_years NUMERIC NOT NULL
);

CREATE TABLE star (
    star_id SERIAL PRIMARY KEY,
    name VARCHAR(255) UNIQUE NOT NULL,
    galaxy_id INT NOT NULL REFERENCES galaxy(galaxy_id),
    temperature_kelvin INT NOT NULL,
    is_main_sequence BOOLEAN NOT NULL,
    mass_relative_to_sun NUMERIC NOT NULL
);

CREATE TABLE planet (
    planet_id SERIAL PRIMARY KEY,
    name VARCHAR(255) UNIQUE NOT NULL,
    star_id INT NOT NULL REFERENCES star(star_id),
    has_life BOOLEAN NOT NULL,
    is_rocky BOOLEAN NOT NULL,
    diameter_km INT NOT NULL,
    distance_from_star_au NUMERIC NOT NULL
);

CREATE TABLE moon (
    moon_id SERIAL PRIMARY KEY,
    name VARCHAR(255) UNIQUE NOT NULL,
    planet_id INT NOT NULL REFERENCES planet(planet_id),
    has_atmosphere BOOLEAN NOT NULL,
    is_tidally_locked BOOLEAN NOT NULL,
    orbital_period_days NUMERIC NOT NULL
);

INSERT INTO galaxy (name, description, has_life, is_spherical, age_in_millions_of_years) VALUES
('Milky Way', 'Our home galaxy', true, true, 13600),
('Andromeda', 'Nearest spiral galaxy to Milky Way', false, true, 10000),
('Triangulum', 'Third-largest galaxy in Local Group', false, true, 5000),
('Whirlpool', 'Classic spiral galaxy', false, true, 4000),
('Sombrero', 'Spiral galaxy with bright nucleus', false, true, 8800),
('Pinwheel', 'Face-on spiral galaxy', false, true, 21000);

INSERT INTO star (name, galaxy_id, temperature_kelvin, is_main_sequence, mass_relative_to_sun) VALUES
('Sun', 1, 5778, true, 1.0),
('Sirius', 1, 9940, true, 2.02),
('Alpha Centauri A', 1, 5790, true, 1.1),
('Betelgeuse', 1, 3500, false, 11.6),
('Vega', 1, 9602, true, 2.135),
('Proxima Centauri', 1, 3042, true, 0.122);

INSERT INTO planet (name, star_id, has_life, is_rocky, diameter_km, distance_from_star_au) VALUES
('Mercury', 1, false, true, 4879, 0.39),
('Venus', 1, false, true, 12104, 0.72),
('Earth', 1, true, true, 12742, 1.0),
('Mars', 1, false, true, 6779, 1.52),
('Jupiter', 1, false, false, 139820, 5.20),
('Saturn', 1, false, false, 116460, 9.58),
('Uranus', 1, false, false, 50724, 19.22),
('Neptune', 1, false, false, 49244, 30.05),
('Proxima Centauri b', 6, false, true, 14800, 0.0485),
('Kepler-186f', 1, true, true, 14400, 0.432),
('Gliese 581c', 1, false, true, 18000, 0.073),
('TRAPPIST-1e', 1, true, true, 9100, 0.029);

INSERT INTO moon (name, planet_id, has_atmosphere, is_tidally_locked, orbital_period_days) VALUES
('Moon', 3, false, true, 27.3),
('Phobos', 4, false, true, 0.32),
('Deimos', 4, false, true, 1.26),
('Io', 5, false, true, 1.77),
('Europa', 5, false, true, 3.55),
('Ganymede', 5, true, true, 7.15),
('Callisto', 5, false, true, 16.69),
('Mimas', 6, false, true, 0.94),
('Enceladus', 6, true, true, 1.37),
('Tethys', 6, false, true, 1.89),
('Dione', 6, false, true, 2.74),
('Rhea', 6, false, true, 4.52),
('Titan', 6, true, true, 15.95),
('Iapetus', 6, false, true, 79.33),
('Miranda', 7, false, true, 1.41),
('Ariel', 7, false, true, 2.52),
('Umbriel', 7, false, true, 4.14),
('Titania', 7, false, true, 8.71),
('Oberon', 7, false, true, 13.46),
('Triton', 8, true, true, 5.88);