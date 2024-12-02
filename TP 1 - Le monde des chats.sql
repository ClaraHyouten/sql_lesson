DROP DATABASE IF EXISTS zoo;

CREATE DATABASE zoo SET CHARACTER utf8mb4 COLLATE utf8mb4_unicode_ci;

CREATE TABLE chat(
    id INT NOT NULL AUTO_INCREMENT,
    nom VARCHAR(100) NOT NULL,
    yeux VARCHAR(100) NOT NULL,
    age INT NOT NULL,
    CONSTRAINT pk_chats PRIMARY KEY (id)
) ENGINE=InnoDB;

INSERT INTO chat(id,nom,yeux,age) VALUES
    (1, 'Maine coon', 'marron', 20),
    (2, 'Siamois', 'bleu', 15),
    (3, 'Bengal', 'marron', 18),
    (4, 'Scottish Fold', 'marron', 10);