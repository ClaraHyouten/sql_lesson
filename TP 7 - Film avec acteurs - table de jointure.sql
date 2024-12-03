-- 1️⃣ Création de la base de données netflix
DROP DATABASE IF EXISTS netflix;

CREATE DATABASE netflix CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

USE netflix;

DROP TABLE IF EXISTS film;
DROP TABLE IF EXISTS categ;
DROP TABLE IF EXISTS acteur;
DROP TABLE IF EXISTS film_has_acteur;

CREATE TABLE film(
    id INT NOT NULL AUTO_INCREMENT,
    nom VARCHAR(100) NOT NULL,
    CONSTRAINT pk_film PRIMARY KEY (id)
) ENGINE=InnoDB;

CREATE TABLE acteur(
    id INT NOT NULL AUTO_INCREMENT,
    prenom VARCHAR(100) NOT NULL,
    nom VARCHAR(100) NOT NULL,
    CONSTRAINT pk_acteur PRIMARY KEY (id)
) ENGINE=InnoDB;

CREATE TABLE film_has_acteur(
    film_id INT NOT NULL AUTO_INCREMENT,
    acteur_id INT NOT NULL,
    CONSTRAINT pk_film_has_acteur PRIMARY KEY (film_id, acteur_id)
) ENGINE=InnoDB;

-- 4️⃣ Insérer les données
ALTER TABLE film_has_acteur ADD
    CONSTRAINT fk_acteur FOREIGN KEY (acteur_id) REFERENCES acteur (id);
ALTER TABLE film_has_acteur ADD
    CONSTRAINT fk_film FOREIGN KEY (film_id) REFERENCES film (id);

INSERT INTO acteur (prenom, nom) VALUES
    ('Brad', 'PITT'),
    ('Leonardo', 'DICAPRIO');

INSERT INTO film(nom) VALUES
    ('Fight Club'),
    ('Once upon a time in Hollywood');

INSERT INTO film_has_acteur (film_id, acteur_id) VALUES
    (1, 1),
    (2, 1),
    (2, 2);

-- vérif que jointure fonctionne bien avec une requête simple
SELECT film.nom AS film, acteur.prenom, acteur.nom
FROM film
INNER JOIN film_has_acteur ON film.id = film_has_acteur.film_id
INNER JOIN acteur ON acteur.id = film_has_acteur.acteur_id;

-- 1️⃣ Afficher tous les films de Léonardo DI CAPRIO
SELECT film.nom AS film, acteur.prenom AS acteur_prenom, acteur.nom AS acteur_nom
FROM film
INNER JOIN film_has_acteur ON film.id = film_has_acteur.film_id
INNER JOIN acteur ON acteur.id = film_has_acteur.acteur_id
WHERE acteur.nom='DICAPRIO' AND acteur.prenom='Leonardo';

-- 2️⃣ Afficher le nombre de films par acteur
SELECT acteur.prenom AS acteur_prenom, acteur.nom AS acteur_nom, COUNT(film.id) AS nb_films
FROM FILM
INNER JOIN film_has_acteur ON film.id = film_has_acteur.film_id
INNER JOIN acteur ON acteur.id = film_has_acteur.acteur_id
GROUP BY acteur.id
ORDER BY acteur.nom ASC;

-- 3️⃣ Ajouter un film :TITANIC
INSERT INTO film (film.nom) VALUES
    ('TITANIC');

-- 4️⃣ Trouver le film qui n'a pas d'acteur
SELECT film.nom AS film_sans_acteur
FROM film
LEFT JOIN film_has_acteur ON film.id = film_has_acteur.film_id
WHERE film_has_acteur.acteur_id IS NULL;
