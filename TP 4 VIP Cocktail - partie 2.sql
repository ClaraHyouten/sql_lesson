DROP DATABASE IF EXISTS invitation;

CREATE DATABASE invitation CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

USE invitation;

DROP TABLE IF EXISTS personne;

CREATE TABLE personne(
    id INT NOT NULL AUTO_INCREMENT,
    prenom VARCHAR(255) NOT NULL,
    nom VARCHAR(255) NOT NULL,
    age INT NOT NULL,
    inscription DATE NOT NULL,
    etat BOOLEAN NOT NULL DEFAULT 1,
    statut ENUM('membre', 'non membre') NOT NULL DEFAULT "non membre",
    cv TEXT,
    salaire INT NOT NULL,
    CONSTRAINT pk_personne PRIMARY KEY (id)
) ENGINE=InnoDB;

ALTER TABLE personne RENAME TO inv_personne;

ALTER TABLE inv_personne ALTER etat SET DEFAULT 1;

-- 1️⃣ - Ajouter les données
INSERT INTO inv_personne(id, prenom, nom, age, inscription, etat, statut, cv, salaire) VALUES
    (1, 'Brad', 'PITT', 60, '1970-01-01', 1, 'non membre', 'lorem ipsum', 2000000),
    (2, 'George', 'CLOONEY', 62, '1999-01-01', 1, 'membre', 'juste beau', 4000000),
    (3, 'Jean', 'DUJARDIN', 51, '1994-01-01', 0, 'membre', 'brice de nice', 1000000);

-- 2️⃣ - Afficher le plus gros salaire (avec MAX)
SELECT MAX(salaire) AS "plus_gros_salaire" FROM inv_personne;

-- 3️⃣ - Afficher le plus petit salaire (avec MIN)
 SELECT MIN(salaire) AS "plus_petit_salaire" FROM inv_personne;

--  4️⃣ - Afficher le nom de l'acteur (et son salaire) qui a le plus petit salaire avec LIMIT & ORDER BY
SELECT prenom, nom, salaire FROM inv_personne
ORDER BY salaire ASC
LIMIT 1;

-- 5️⃣ - Afficher le nom de l'acteur (et son salaire) qui a le plus gros salaire avec LIMIT & ORDER BY
SELECT prenom, nom, salaire FROM inv_personne
ORDER BY salaire DESC
LIMIT 1;

6️⃣ - Afficher le salaire moyen
SELECT AVG(salaire) AS 'salaire_moyen' FROM inv_personne;
SELECT ROUND(AVG(salaire)) AS 'salaire_moyen' FROM inv_personne;
SELECT CAST(AVG(salaire) AS DECIMAL(10, 1)) AS 'salaire_moyen' FROM inv_personne;

-- 7️⃣ - Afficher le nombre de personnes
SELECT COUNT(*) AS 'nb_personnes' FROM inv_personne;

-- 8️⃣ - Afficher les acteurs avec un salaire entre 1 000 000 et 4 000 000 avec BETWEEN
SELECT id, prenom, nom, salaire FROM inv_personne
WHERE salaire BETWEEN 1000001 AND 3999999;
-- plus pertinent avec :
SELECT  id, prenom, nom, salaire FROM inv_personne
WHERE salaire > 1000000 AND salaire < 4000000;

-- 9️⃣ Proposer une requete avec UPPER() & LOWER()
SELECT id,
       prenom,
       LOWER(nom) AS 'nom'
FROM inv_personne
WHERE id=1;

SELECT id,
       UPPER(prenom) AS 'prenom',
       LOWER(nom) AS 'nom'
FROM inv_personne
WHERE id=1;

-- 10 - Afficher les personnes dont le prenom contient 'bra'
SELECT id, prenom, nom, salaire FROM inv_personne
WHERE prenom LIKE '%bra%';

-- 12 - Trier par age les membres
SELECT prenom, nom, age FROM inv_personne
WHERE id > 1
ORDER BY age ASC;

-- 13 - Afficher le nombre d'acteurs "membre"
SELECT COUNT(id) AS 'nb_membres' FROM inv_personne
WHERE statut='membre';

-- 14 - Afficher le nombre des membres et d'acteur "non membre"
SELECT statut AS 'membre', COUNT(id) AS 'nb_membres' FROM inv_personne
GROUP BY statut
ORDER BY nb_membres DESC;

SELECT 
    CASE 
        WHEN statut = 'membre' THEN 'Membres'
        WHEN statut = 'non membre' THEN 'Non Membres'
    END AS statut,
    COUNT(*) AS nombre
FROM inv_personne
GROUP BY statut;
