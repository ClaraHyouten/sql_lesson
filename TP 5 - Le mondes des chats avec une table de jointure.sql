-- 1️⃣ Création de la base de données spa
DROP DATABASE IF EXISTS spa;

CREATE DATABASE spa CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

USE spa;

DROP TABLE IF EXISTS chat;

DROP TABLE IF EXISTS couleur;


-- 2️⃣ Création de la table chat
CREATE TABLE chat(
    id INT NOT NULL AUTO_INCREMENT,
    nom VARCHAR(100) NOT NULL,
    age INT NOT NULL,
    yeux_id INT,
    CONSTRAINT pk_chat PRIMARY KEY (id)
) ENGINE=InnoDB;

-- 3️⃣ Creation de la table couleur
CREATE TABLE couleur(
    id INT NOT NULL AUTO_INCREMENT,
    nom VARCHAR(100) NOT NULL,
    CONSTRAINT pk_couleur PRIMARY KEY (id)
) ENGINE=InnoDB;

-- 4️⃣ Insérer les données
ALTER TABLE chat ADD
    CONSTRAINT fk_chat_couleur FOREIGN KEY (yeux_id) REFERENCES couleur (id);

INSERT INTO couleur (nom) VALUES
    ('Marron'),
    ('Bleu'),
    ('Vert');

INSERT INTO chat(nom, age, yeux_id) VALUES
    ('Maine coon', 20, 1),
    ('Siamois', 15, 2),
    ('Bengal', 18, 1),
    ('Scottish Fold', 10, 1),
    ('domestique', 21, null);

-- vérif que jointure fonctionne bien avec une requête simple
SELECT chat.nom AS chat, chat.age AS age, couleur.nom AS couleur FROM chat INNER JOIN couleur ON chat.yeux_id = couleur.id;