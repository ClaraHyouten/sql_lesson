DROP DATABASE IF EXISTS invitation;

CREATE DATABASE invitation CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

USE invitation;

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

INSERT INTO personne(id, prenom, nom, age, inscription, etat, statut, cv, salaire) VALUES
    (1, 'Brad', 'PITT', 60, '01/01/1970', 1, 'non membre', 'lorem ipsum', 2000000),
    (2, 'George', 'CLOONEY', 62, '01/01/1999', 1, 'membre', 'juste beau', 4000000),
    (3, 'Jean', 'DUJARDIN', 51, '01/01/1994', 0, 'membre', 'brice de nice', 1000000);