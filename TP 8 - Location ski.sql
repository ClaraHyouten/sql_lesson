-- Partie 1
-- Créer la base de données location_ski
DROP DATABASE IF EXISTS location_ski;

CREATE DATABASE location_ski CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

USE location_ski;

DROP TABLE IF EXISTS clients;
DROP TABLE IF EXISTS fiches;
DROP TABLE IF EXISTS tarifs;
DROP TABLE IF EXISTS gammes;
DROP TABLE IF EXISTS categories;
DROP TABLE IF EXISTS grilleTarifs;
DROP TABLE IF EXISTS articles;
DROP TABLE IF EXISTS lignesFic;

CREATE TABLE clients(
    noCli INT NOT NULL AUTO_INCREMENT,
    nom VARCHAR(30) NOT NULL,
    prenom VARCHAR(30),
    adresse VARCHAR(120),
    cpo VARCHAR(5) NOT NULL,
    ville VARCHAR(80) NOT NULL,
    CONSTRAINT pk_clients PRIMARY KEY (noCli)
) ENGINE=InnoDB;

CREATE TABLE fiches(
    noFic INT NOT NULL AUTO_INCREMENT,
    noCli INT NOT NULL,
    dateCrea DATE NOT NULL,
    datePaiement DATE,
    etat ENUM('SO', 'EC', 'RE') NOT NULL,
    CONSTRAINT pk_fiches PRIMARY KEY (noFic)
) ENGINE=InnoDB;

CREATE TABLE tarifs(
    codeTarif CHAR(5) NOT NULL,
    libelle CHAR(30) NOT NULL,
    prixJour DECIMAL(5, 0) NOT NULL,
    CONSTRAINT pk_tarifs PRIMARY KEY (codeTarif)
) ENGINE=InnoDB;

CREATE TABLE gammes(
    codeGam CHAR(5) NOT NULL,
    libelle CHAR(45) NOT NULL,
    CONSTRAINT pk_gammes PRIMARY KEY (codeGam)
) ENGINE=InnoDB;

CREATE TABLE categories(
    codeCate CHAR(5) NOT NULL,
    libelle CHAR(30) NOT NULL,
    CONSTRAINT pk_categories PRIMARY KEY (codeCate)
) ENGINE=InnoDB;

CREATE TABLE grilleTarifs(
    codeGam CHAR(5) NOT NULL,
    codeCate CHAR(5) NOT NULL,
    codeTarif CHAR(5),
    CONSTRAINT pk_grilleTarifs PRIMARY KEY (codeGam, codeCate)
) ENGINE=InnoDB;

CREATE TABLE articles(
    refart CHAR(8) NOT NULL,
    designation VARCHAR(80) NOT NULL,
    codeGam CHAR(5),
    codeCate CHAR(5),
    CONSTRAINT pk_articles PRIMARY KEY (refart)
) ENGINE=InnoDB;

CREATE TABLE lignesFic(
    noLig INT NOT NULL AUTO_INCREMENT,
    noFic INT NOT NULL,
    refart CHAR(8) NOT NULL,
    depart DATE NOT NULL,
    retour DATE,
    CONSTRAINT pk_lignesFic PRIMARY KEY (noLig, noFic)
) ENGINE=InnoDB;


ALTER TABLE fiches ADD
    CONSTRAINT fk_fiches_clients FOREIGN KEY (noCli) REFERENCES clients (noCli);
ALTER TABLE grilleTarifs ADD
    CONSTRAINT fk_grilleTarifs_gammes FOREIGN KEY (codeGam) REFERENCES gammes (codeGam);
ALTER TABLE grilleTarifs ADD
CONSTRAINT fk_grilleTarifs_categories FOREIGN KEY (codeCate) REFERENCES categories (codeCate);
ALTER TABLE grilleTarifs ADD
    CONSTRAINT fk_grilleTarifs_tarifs FOREIGN KEY (codeTarif) REFERENCES tarifs (codeTarif);
ALTER TABLE articles ADD
    CONSTRAINT fk_articles_gammes FOREIGN KEY (codeGam) REFERENCES gammes (codeGam);
ALTER TABLE articles ADD
CONSTRAINT fk_articles_categories FOREIGN KEY (codeCate) REFERENCES categories (codeCate);
ALTER TABLE lignesFic ADD
CONSTRAINT fk_lignesFic_fiches FOREIGN KEY (noFic) REFERENCES fiches (noFic);
ALTER TABLE lignesFic ADD
CONSTRAINT fk_lignesFic_articles FOREIGN KEY (refart) REFERENCES articles (refart);


INSERT INTO clients (noCli, nom, prenom, adresse, cpo, ville) VALUES 
    (1, 'Albert', 'Anatole', 'Rue des accacias', '61000', 'Amiens'),
    (2, 'Bernard', 'Barnabé', 'Rue du bar', '1000', 'Bourg en Bresse'),
    (3, 'Dupond', 'Camille', 'Rue Crébillon', '44000', 'Nantes'),
    (4, 'Desmoulin', 'Daniel', 'Rue descendante', '21000', 'Dijon'),
    (5, 'Ferdinand', 'François', 'Rue de la convention', '44100', 'Nantes'),
    (6, 'Albert', 'Anatole', 'Rue des accacias', '61000', 'Amiens'),
    (9, 'Dupond', 'Jean', 'Rue des mimosas', '75018', 'Paris'),
    (14, 'Boutaud', 'Sabine', 'Rue des platanes', '75002', 'Paris');

INSERT INTO fiches (noFic, noCli, dateCrea, datePaiement, etat) VALUES 
    (1001, 14,  DATE_SUB(NOW(),INTERVAL  15 DAY), DATE_SUB(NOW(),INTERVAL  13 DAY),'SO' ),
    (1002, 4,  DATE_SUB(NOW(),INTERVAL  13 DAY), NULL, 'EC'),
    (1003, 6,  DATE_SUB(NOW(),INTERVAL  12 DAY), DATE_SUB(NOW(),INTERVAL  10 DAY),'SO'),
    (1004, 5,  DATE_SUB(NOW(),INTERVAL  11 DAY), NULL, 'EC'),
    (1005, 3,  DATE_SUB(NOW(),INTERVAL  10 DAY), NULL, 'EC'),
    (1006, 9,  DATE_SUB(NOW(),INTERVAL  10 DAY),NULL ,'RE'),
    (1007, 1,  DATE_SUB(NOW(),INTERVAL  3 DAY), NULL, 'EC'),
    (1008, 2,  DATE_SUB(NOW(),INTERVAL  0 DAY), NULL, 'EC');

INSERT INTO tarifs (codeTarif, libelle, prixJour) VALUES
    ('T1', 'Base', 10),
    ('T2', 'Chocolat', 15),
    ('T3', 'Bronze', 20),
    ('T4', 'Argent', 30),
    ('T5', 'Or', 50),
    ('T6', 'Platine', 90);

INSERT INTO gammes (codeGam, libelle) VALUES
    ('PR', 'Matériel Professionnel'),
    ('HG', 'Haut de gamme'),
    ('MG', 'Moyenne gamme'),
    ('EG', 'Entrée de gamme');

INSERT INTO categories (codeCate, libelle) VALUES
    ('MONO', 'Monoski'),
    ('SURF', 'Surf'),
    ('PA', 'Patinette'),
    ('FOA', 'Ski de fond alternatif'),
    ('FOP', 'Ski de fond patineur'),
    ('SA', 'Ski alpin');

INSERT INTO grilleTarifs (codeGam, codeCate, codeTarif) VALUES
    ('EG', 'MONO', 'T1'),
    ('MG', 'MONO', 'T2'),
    ('EG', 'SURF', 'T1'),
    ('MG', 'SURF', 'T2'),
    ('HG', 'SURF', 'T3'),
    ('PR', 'SURF', 'T5'),
    ('EG', 'PA', 'T1'),
    ('MG', 'PA', 'T2'),
    ('EG', 'FOA', 'T1'),
    ('MG', 'FOA', 'T2'),
    ('HG', 'FOA', 'T4'),
    ('PR', 'FOA', 'T6'),
    ('EG', 'FOP', 'T2'),
    ('MG', 'FOP', 'T3'),
    ('HG', 'FOP', 'T4'),
    ('PR', 'FOP', 'T6'),
    ('EG', 'SA', 'T1'),
    ('MG', 'SA', 'T2'),
    ('HG', 'SA', 'T4'),
    ('PR', 'SA', 'T6');

INSERT INTO articles (refart, designation, codeGam, codeCate) VALUES 
    ('F01', 'Fischer Cruiser', 'EG', 'FOA'),
    ('F02', 'Fischer Cruiser', 'EG', 'FOA'),
    ('F03', 'Fischer Cruiser', 'EG', 'FOA'),
    ('F04', 'Fischer Cruiser', 'EG', 'FOA'),
    ('F05', 'Fischer Cruiser', 'EG', 'FOA'),
    ('F10', 'Fischer Sporty Crown', 'MG', 'FOA'),
    ('F20', 'Fischer RCS Classic GOLD', 'PR', 'FOA'),
    ('F21', 'Fischer RCS Classic GOLD', 'PR', 'FOA'),
    ('F22', 'Fischer RCS Classic GOLD', 'PR', 'FOA'),
    ('F23', 'Fischer RCS Classic GOLD', 'PR', 'FOA'),
    ('F50', 'Fischer SOSSkating VASA', 'HG', 'FOP'),
    ('F60', 'Fischer RCS CARBOLITE Skating', 'PR', 'FOP'),
    ('F61', 'Fischer RCS CARBOLITE Skating', 'PR', 'FOP'),
    ('F62', 'Fischer RCS CARBOLITE Skating', 'PR', 'FOP'),
    ('F63', 'Fischer RCS CARBOLITE Skating', 'PR', 'FOP'),
    ('F64', 'Fischer RCS CARBOLITE Skating', 'PR', 'FOP'),
    ('P01', 'Décathlon Allegre junior 150', 'EG', 'PA'),
    ('P10', 'Fischer mini ski patinette', 'MG', 'PA'),
    ('P11', 'Fischer mini ski patinette', 'MG', 'PA'),
    ('S01', 'Décathlon Apparition', 'EG', 'SURF'),
    ('S02', 'Décathlon Apparition', 'EG', 'SURF'),
    ('S03', 'Décathlon Apparition', 'EG', 'SURF'),
    ('A01', 'Salomon 24X+Z12', 'EG', 'SA'),
    ('A02', 'Salomon 24X+Z12', 'EG', 'SA'),
    ('A03', 'Salomon 24X+Z12', 'EG', 'SA'),
    ('A04', 'Salomon 24X+Z12', 'EG', 'SA'),
    ('A05', 'Salomon 24X+Z12', 'EG', 'SA'),
    ('A10', 'Salomon Pro Link Equipe 4S', 'PR', 'SA'),
    ('A11', 'Salomon Pro Link Equipe 4S', 'PR', 'SA'),
    ('A21', 'Salomon 3V RACE JR+L10', 'PR', 'SA');

INSERT INTO lignesFic (noFic, noLig,  refart, depart, retour) VALUES 
    (1001, 1, 'F05', DATE_SUB(NOW(),INTERVAL  15 DAY), DATE_SUB(NOW(),INTERVAL  13 DAY)),
    (1001, 2, 'F50', DATE_SUB(NOW(),INTERVAL  15 DAY), DATE_SUB(NOW(),INTERVAL  14 DAY)),
    (1001, 3, 'F60', DATE_SUB(NOW(),INTERVAL  13 DAY), DATE_SUB(NOW(),INTERVAL  13 DAY)),
    (1002, 1, 'A03', DATE_SUB(NOW(),INTERVAL  13 DAY), DATE_SUB(NOW(),INTERVAL  9 DAY)),
    (1002, 2, 'A04', DATE_SUB(NOW(),INTERVAL  12 DAY), DATE_SUB(NOW(),INTERVAL  7 DAY)),
    (1002, 3, 'S03', DATE_SUB(NOW(),INTERVAL  8 DAY), NULL),
    (1003, 1, 'F50', DATE_SUB(NOW(),INTERVAL  12 DAY), DATE_SUB(NOW(),INTERVAL  10 DAY)),
    (1003, 2, 'F05', DATE_SUB(NOW(),INTERVAL  12 DAY), DATE_SUB(NOW(),INTERVAL  10 DAY)),
    (1004, 1, 'P01', DATE_SUB(NOW(),INTERVAL  6 DAY), NULL),
    (1005, 1, 'F05', DATE_SUB(NOW(),INTERVAL  9 DAY), DATE_SUB(NOW(),INTERVAL  5 DAY)),
    (1005, 2, 'F10', DATE_SUB(NOW(),INTERVAL  4 DAY), NULL),
    (1006, 1, 'S01', DATE_SUB(NOW(),INTERVAL  10 DAY), DATE_SUB(NOW(),INTERVAL  9 DAY)),
    (1006, 2, 'S02', DATE_SUB(NOW(),INTERVAL  10 DAY), DATE_SUB(NOW(),INTERVAL  9 DAY)),
    (1006, 3, 'S03', DATE_SUB(NOW(),INTERVAL  10 DAY), DATE_SUB(NOW(),INTERVAL  9 DAY)),
    (1007, 1, 'F50', DATE_SUB(NOW(),INTERVAL  3 DAY), DATE_SUB(NOW(),INTERVAL  2 DAY)),
    (1007, 3, 'F60', DATE_SUB(NOW(),INTERVAL  1 DAY), NULL),
    (1007, 2, 'F05', DATE_SUB(NOW(),INTERVAL  3 DAY), NULL),
    (1007, 4, 'S02', DATE_SUB(NOW(),INTERVAL  0 DAY), NULL),
    (1008, 1, 'S01', DATE_SUB(NOW(),INTERVAL  0 DAY), NULL);

-- Partie 2
-- 1️⃣ Liste des clients (toutes les informations) dont le nom commence par un D
SELECT noCli, nom, prenom, adresse, cpo, ville FROM clients
WHERE clients.nom LIKE 'D%';

-- 2️⃣ Nom et prénom de tous les clients
SELECT prenom, nom FROM clients;

-- 3️⃣ Liste des fiches (n°, état) pour les clients (nom, prénom) qui habitent en Loire Atlantique (44)
SELECT f.noFic, f.etat, c.nom, c.prenom FROM fiches AS f
    INNER JOIN clients AS c ON c.noCli = f.noCli
    WHERE c.cpo LIKE '44%'
    ORDER BY noFic ASC;

-- 4️⃣ Détail de la fiche n°1002
SELECT f.noFic, 
    c.nom, 
    c.prenom, 
    lf.refart, 
    a.designation, 
    lf.depart, 
    lf.retour, 
    t.prixJour,
    (IFNULL(DATEDIFF(lf.retour, lf.depart), DATEDIFF(CURDATE(), lf.depart))) * t.prixJour AS montant
    FROM fiches AS f
    INNER JOIN clients AS c ON c.noCli = f.noCli
    INNER JOIN lignesFic AS lf ON lf.noFic = f.noFic
    INNER JOIN articles AS a ON a.refart = lf.refart
    INNER JOIN categories AS ca ON ca.codeCate = a.codeCate
    INNER JOIN grilleTarifs AS gt ON gt.codeCate = ca.codeCate
    INNER JOIN tarifs AS t ON t.codeTarif = gt.codeTarif
    WHERE f.noFic = 1002;

-- 5️⃣ Prix journalier moyen de location par gamme
SELECT g.libelle AS 'Gamme', ROUND(AVG(t.prixJour), 2) AS 'Tarif journalier moyen' FROM gammes AS g
    INNER JOIN grilleTarifs AS gt ON gt.codeGam = g.codeGam
    INNER JOIN tarifs AS t ON t.codeTarif = gt.codeTarif
    GROUP BY g.libelle;

-- 6️⃣ Détail de la fiche n°1002 avec le total
SELECT f.noFic, 
       c.nom, 
       c.prenom, 
       lf.refart, 
       a.designation, 
       lf.depart, 
       lf.retour, 
       t.prixJour,
       (IFNULL(DATEDIFF(lf.retour, lf.depart), DATEDIFF(CURDATE(), lf.depart))) * t.prixJour AS montant,
       -- Sous-requête pour avoir le total des montants
       (SELECT SUM(IFNULL(DATEDIFF(lf_sub.retour, lf_sub.depart), DATEDIFF(CURDATE(), lf_sub.depart)) * t_sub.prixJour) 
        FROM lignesFic lf_sub
        INNER JOIN articles a_sub ON a_sub.refart = lf_sub.refart
        INNER JOIN grilleTarifs gt_sub ON gt_sub.codeCate = a_sub.codeCate
        INNER JOIN tarifs t_sub ON t_sub.codeTarif = gt_sub.codeTarif
        WHERE lf_sub.noFic = f.noFic) AS total
    FROM fiches f
    INNER JOIN clients c ON c.noCli = f.noCli
    INNER JOIN lignesFic lf ON lf.noFic = f.noFic
    INNER JOIN articles a ON a.refart = lf.refart
    INNER JOIN categories ca ON ca.codeCate = a.codeCate
    INNER JOIN grilleTarifs gt ON gt.codeCate = ca.codeCate
    INNER JOIN tarifs t ON t.codeTarif = gt.codeTarif
    WHERE f.noFic = 1002;

-- 7️⃣ Grille des tarifs
SELECT c.libelle, g.libelle, t.libelle, t.prixJour
    FROM categories AS c
    INNER JOIN grilleTarifs AS gt ON gt.codeCate = c.codeCate
    INNER JOIN tarifs AS t ON t.codeTarif = gt.codeTarif
    INNER JOIN gammes AS g ON g.codeGam = gt.codeGam;

-- 8️⃣ Liste des locations de la catégorie SURF
SELECT a.refart, a.designation, COUNT(lf.refart) AS nbLocation
    FROM articles AS a
    INNER JOIN categories AS ca ON ca.codeCate = a.codeCate
    INNER JOIN lignesFic AS lf ON lf.refart = a.refart
    WHERE a.codeCate = 'SURF'
    GROUP BY a.refart, a.designation;

-- 9️⃣ Calcul du nombre moyen d’articles loués par fiche de location
SELECT 
    AVG(nb_articles) AS nb_lignes_moyen_par_fiche
FROM (
    SELECT COUNT(noFic) AS nb_articles
    FROM lignesFic
    GROUP BY noFic
) AS fiches_articles_count;

-- 🔟 Calcul du nombre de fiches de location établies pour les catégories de location Ski alpin, Surf et Patinette
SELECT 
    ca.libelle AS catégorie,
    COUNT(DISTINCT lf.noFic) AS nombre_de_location
FROM categories AS ca
INNER JOIN articles AS a ON a.codeCate = ca.codeCate
INNER JOIN lignesFic AS lf ON lf.refart = a.refart
INNER JOIN fiches AS f ON f.noFic = lf.noFic
WHERE ca.libelle IN ('Ski alpin', 'Surf', 'Patinette')
GROUP BY ca.libelle;

-- 11 Calcul du montant moyen des fiches de location
SELECT 
    AVG(montant) AS montant_moyen_fiche
FROM (
    SELECT 
        f.noFic,
        SUM(IFNULL(DATEDIFF(lf.retour, lf.depart), DATEDIFF(CURDATE(), lf.depart)) * t.prixJour) AS montant
    FROM fiches AS f
    INNER JOIN lignesFic AS lf ON lf.noFic = f.noFic
    INNER JOIN articles AS a ON a.refart = lf.refart
    INNER JOIN categories AS ca ON ca.codeCate = a.codeCate
    INNER JOIN grilleTarifs AS gt ON gt.codeCate = ca.codeCate
    INNER JOIN tarifs AS t ON t.codeTarif = gt.codeTarif
    GROUP BY f.noFic
) AS montants_fiches;

