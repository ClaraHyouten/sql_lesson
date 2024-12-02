DROP DATABASE IF EXISTS zoo;

CREATE DATABASE zoo CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

USE zoo;

DROP TABLE IF EXISTS chat;

CREATE TABLE chat(
    id INT NOT NULL AUTO_INCREMENT,
    nom VARCHAR(100) NOT NULL,
    yeux VARCHAR(100) NOT NULL,
    age INT NOT NULL,
    CONSTRAINT pk_chats PRIMARY KEY (id)
) ENGINE=InnoDB;

-- 1️⃣ - Ajouter les données
INSERT INTO chat(id,nom,yeux,age) VALUES
    (1, 'Maine coon', 'marron', 20),
    (2, 'Siamois', 'bleu', 15),
    (3, 'Bengal', 'marron', 18),
    (4, 'Scottish Fold', 'marron', 10);

-- 2️⃣ - Afficher le chat avec l'id :2
SELECT * FROM chat WHERE id=2;

-- 3️⃣ - Trier les chats par nom et par age
-- par nom :
SELECT * FROM chat
ORDER BY nom ASC;
-- par age :
SELECT * FROM chat
ORDER BY age ASC;

-- 4️⃣ - Afficher les chats qui vive entre 11 et 19 ans
SELECT * FROM chat
WHERE age >= 11
AND age <= 19
ORDER BY age DESC;

-- 5️⃣ - Afficher le ou les chats dont le nom contient 'sia'
SELECT * FROM chat
WHERE nom LIKE '%sia%';

-- 6️⃣ - Afficher le ou les chats dont le nom contient 'a'
SELECT * FROM chat
WHERE nom LIKE '%a%';

-- 7️⃣ - Afficher la moyenne d'age des chats
SELECT SUM(age) / COUNT(age) AS 'age_moyen' FROM chat;
--  OU
SELECT AVG(age) AS 'age_moyen' FROM chat;

-- 8️⃣ - Afficher le nombre de chats dans la table
SELECT COUNT(*) AS 'nb_chat' FROM chat;

-- 9️⃣ - Afficher le nombre de chat avec couleur d'yeux marron
SELECT yeux AS 'couleur', COUNT(*) AS 'nb_chat' FROM chat
WHERE yeux='marron';

-- 10 - Afficher le nombre de chat par couleur d'yeux
SELECT yeux AS 'couleur', COUNT(*) AS 'nb_chat' FROM chat
GROUP BY yeux;