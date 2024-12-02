DROP DATABASE IF EXISTS invitation;

CREATE DATABASE invitation SET CHARACTER utf8mb4 COLLATE utf8mb4_unicode_ci;

USE invitation;

CREATE TABLE personne(
    id INT NOT NULL AUTO_INCREMENT,
    prenom VARCHAR(255) NOT NULL,
    nom VARCHAR(255) NOT NULL,
    age INT NOT NULL,
    inscription DATE NOT NULL,
    etat BOOLEAN NOT NULL,
    statut ENUM('membre', 'non membre') NOT NULL,
    cv VARCHAR(255) NOT NULL,
    salaire INT NOT NULL,
    CONSTRAINT pk_chats PRIMARY KEY (id)
) ENGINE=InnoDB;

INSERT INTO personne(id, prenom, nom, age, inscription, etat, statut, cv, salaire) VALUES
    (1, 'Brad', 'PITT', 60, '01/01/1970', 1, 'non membre', 'lorem ipsum', 2000000),
    (2, 'George', 'CLOONEY', 62, '01/01/1999', 1, 'membre', 'juste beau', 4000000),
    (3, 'Jean', 'DUJARDIN', 51, '01/01/1994', 0, 'membre', 'brice de nice', 1000000);