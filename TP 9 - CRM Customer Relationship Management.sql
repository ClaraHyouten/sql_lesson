-- Partie 1
-- Créer la base de données avec 4 tables

DROP DATABASE IF EXISTS crm;
CREATE DATABASE crm CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

USE crm;

DROP TABLE IF EXISTS clients;
DROP TABLE IF EXISTS projets;
DROP TABLE IF EXISTS devis;
DROP TABLE IF EXISTS factures;

CREATE TABLE clients (
    id INT NOT NULL AUTO_INCREMENT,
    nom VARCHAR(255) NOT NULL,
    CONSTRAINT pk_clients PRIMARY KEY (id)
) ENGINE=InnoDB;

CREATE TABLE projets (
    id INT NOT NULL AUTO_INCREMENT,
    nom VARCHAR(255) NOT NULL,
    version INT NOT NULL,
    clients_id INT NOT NULL,
    CONSTRAINT pk_projets PRIMARY KEY (id)
) ENGINE=InnoDB;

CREATE TABLE devis(
    ref VARCHAR(20) NOT NULL,
    projets_id INT NOT NULL,
    montant FLOAT NOT NULL,
    CONSTRAINT pk_devis PRIMARY KEY (ref)
) ENGINE=InnoDB;

CREATE TABLE factures(
    ref VARCHAR(20) NOT NULL,
    devis_ref VARCHAR(20) NOT NULL,
    info VARCHAR(255) NOT NULL,
    total FLOAT NOT NULL,
    date_emission DATE NOT NULL,
    date_paiement DATE,
    CONSTRAINT pk_factures PRIMARY KEY (ref)
) ENGINE=InnoDB;

ALTER TABLE projets ADD 
    CONSTRAINT fk_projets_clients FOREIGN KEY (clients_id) REFERENCES clients (id);

ALTER TABLE devis ADD 
    CONSTRAINT fk_devis_projets FOREIGN KEY (projets_id) REFERENCES projets (id);

ALTER TABLE factures ADD 
    CONSTRAINT fk_factures_devis FOREIGN KEY (devis_ref) REFERENCES devis (ref);


-- Ajouter les données
INSERT INTO clients (id, nom) VALUES
    (1, 'Mairie de Rennes'),
    (2, 'Neo Soft'),
    (3, 'Sopra'),
    (4, 'Accenture'),
    (5, 'Amazon');

INSERT INTO projets (id, nom, version, clients_id) VALUES
    (1, 'Création de site internet', 1, 1),
    (2, 'Création de site internet', 2, 1),
    (3, 'Logiciel CRM', 1, 2),
    (4, 'Logiciel de devis', 1, 3),
    (5, 'Site internet ecommerce', 1, 4),
    (6, 'logiciel ERP', 1, 2),
    (7, 'logiciel Gestion de Stock', 1, 5);

INSERT INTO devis (ref, projets_id, montant) VALUES
    ('DEV2100A', 1, 3000),
    ('DEV2100B', 2, 5000),
    ('DEV2100C', 3, 5000),
    ('DEV2100D', 4, 3000),
    ('DEV2100E', 5, 5000),
    ('DEV2100F', 6, 2000),
    ('DEV2100G', 7, 1000);

INSERT INTO factures (ref, devis_ref, info, total, date_emission, date_paiement) VALUES
    ('FA001', 'DEV2100A', 'Site internet partie 1', 1500, '2023-09-01','2023-10-01'),
    ('FA002', 'DEV2100A', 'Site internet partie 2', 1500, '2023-09-20', NULL),
    ('FA003', 'DEV2100C', 'Logiciel CRM', 5000, '2024-02-01', NULL),
    ('FA004', 'DEV2100D', 'Logiciel devis', 3000, '2024-03-03', '2024-04-03'),
    ('FA005', 'DEV2100E', 'Site internet ecommerce', 5000, '2023-03-01', NULL),
    ('FA006', 'DEV2100F', 'logiciel ERP', 2000, '2023-03-01', NULL);


-- Partie 2
-- 1️⃣ Afficher toutes les factures avec le nom des clients
SELECT f.ref, clients.nom, f.info, f.total, f.date_emission, f.date_paiement
FROM factures AS f
INNER JOIN devis ON devis.ref = f.devis_ref
INNER JOIN projets ON projets.id = devis.projets_id
INNER JOIN clients ON clients.id = projets.clients_id;

-- 2️⃣ Afficher le nombre de factures par client
SELECT c.nom AS client, COUNT(factures.ref) AS nb_factures
FROM clients AS c
INNER JOIN projets ON projets.clients_id = c.id
INNER JOIN devis ON devis.projets_id = projets.id
LEFT JOIN factures ON factures.devis_ref = devis.ref
GROUP BY c.nom;

-- 3️⃣ Afficher le chiffre d'affaire par client
SELECT c.nom AS client, IFNULL(SUM(factures.total), 0) AS chiffre_d_affaire
FROM clients AS c
INNER JOIN projets ON projets.clients_id = c.id
INNER JOIN devis ON devis.projets_id = projets.id
LEFT JOIN factures ON factures.devis_ref = devis.ref
GROUP BY c.nom;

-- 4️⃣ Afficher le CA total
SELECT SUM(factures.total) AS total_factures
FROM factures;

-- 5️⃣ Afficher la somme du montant des factures en attente de paiement
SELECT SUM(factures.total) AS total_factures
FROM factures
WHERE factures.date_paiement IS NULL;

-- 6️⃣ Afficher les factures en retard de paiment
SELECT factures.ref AS facture, DATEDIFF(CURDATE(), factures.date_emission) AS nb_jours
FROM factures
WHERE factures.date_paiement IS NULL
AND DATEDIFF(CURDATE(), factures.date_emission) > 30;

-- 7️⃣ Ajouter une pénalité de 2 euros par jours de retard
SELECT ref, DATEDIFF(CURDATE(), date_emission) AS nb_jours , (DATEDIFF(CURDATE(), date_emission) - 30 * 2) AS penalite
FROM factures 
WHERE date_paiement IS NULL
AND DATEDIFF(CURDATE(), date_emission)  > 30;

-- Partie 3 réaliser un modèle relationnel
-- [OPTIONEL]
-- Réaliser le modèle relationnel sur db diagram et fournir le prompt
Table clients {
  id integer [primary key, not null, increment]
  nom varchar [not null]
}

Table projets {
  id integer [primary key, not null, increment]
  nom varchar [not null]
  version int [not null]
  clients_id integer [not null]
  }

Table devis {
  ref varchar [primary key, not null]
  projets_id integer [not null]
  montant float [not null]
}

Table factures {
  ref varchar [primary key, not null]
  devis_ref varchar [not null]
  info varchar [not null]
  total float [not null]
  date_emission timestamp [not null]
  date_paiement timestamp
}


Ref: "clients"."id" < "projets"."clients_id"

Ref: "projets"."id" < "devis"."projets_id"

Ref: "devis"."ref" < "factures"."devis_ref"