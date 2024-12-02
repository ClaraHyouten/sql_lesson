-- 1️⃣ Création de la base de données netflix
DROP DATABASE IF EXISTS netflix;

CREATE DATABASE netflix CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

USE netflix;

DROP TABLE IF EXISTS film;
DROP TABLE IF EXISTS categ;


-- 2️⃣ Création de la table film
CREATE TABLE film(
    id INT NOT NULL AUTO_INCREMENT,
    titre VARCHAR(255) NOT NULL,
    sortie DATE NOT NULL,
    categ_id INT,
    CONSTRAINT pk_film PRIMARY KEY (id)
) ENGINE=InnoDB;

-- 3️⃣ Creation de la table categ
CREATE TABLE categ(
    id INT NOT NULL AUTO_INCREMENT,
    nom VARCHAR(30) NOT NULL,
    CONSTRAINT pk_categ PRIMARY KEY (id)
) ENGINE=InnoDB;

-- 4️⃣ Insérer les données
ALTER TABLE film ADD
    CONSTRAINT fk_film_categ FOREIGN KEY (categ_id) REFERENCES categ (id);

INSERT INTO categ (nom) VALUES
    ('Sciences Fiction'),
    ('Thriller');

INSERT INTO film(titre, sortie, categ_id) VALUES
    ('Star Wars', '1977-05-25', 1),
    ('The Matrix', '1999-06-23', 1),
    ('Pulp Fiction', '1994-10-26', 2);

-- vérif que jointure fonctionne bien avec une requête simple
SELECT film.titre AS film, film.sortie AS sortie, categ.nom AS category FROM film INNER JOIN categ ON film.categ_id = categ.id;