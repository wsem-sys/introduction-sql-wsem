-- Création de la base de données
CREATE DATABASE IF NOT EXISTS compta2;

-- Utilisation de la base de données
USE compta2;

-- Création de la table FOURNISSEUR
CREATE TABLE IF NOT EXISTS FOURNISSEUR (
    ID INT PRIMARY KEY,
    NOM VARCHAR(50) NOT NULL
);

-- Création de la table ARTICLE
CREATE TABLE IF NOT EXISTS ARTICLE (
    ID INT PRIMARY KEY,
    REF VARCHAR(10) NOT NULL,
    DESIGNATION VARCHAR(100) NOT NULL,
    PRIX DECIMAL(10,2) NOT NULL,
    ID_FOU INT,
    FOREIGN KEY (ID_FOU) REFERENCES FOURNISSEUR(ID)
);

-- Création de la table BON (bon de commande)
CREATE TABLE IF NOT EXISTS BON (
    ID INT PRIMARY KEY,
    NUMERO VARCHAR(20) NOT NULL,
    DATE_CMDE DATE NOT NULL,
    DELAI INT,
    ID_FOU INT,
    FOREIGN KEY (ID_FOU) REFERENCES FOURNISSEUR(ID)
);

-- Création de la table COMPO (composition du bon de commande)
CREATE TABLE IF NOT EXISTS COMPO (
    ID INT PRIMARY KEY AUTO_INCREMENT,
    QTE INT NOT NULL,
    ID_ART INT,
    ID_BON INT,
    FOREIGN KEY (ID_ART) REFERENCES ARTICLE(ID),
    FOREIGN KEY (ID_BON) REFERENCES BON(ID)
);

-- Insertion de données dans la table FOURNISSEUR
INSERT INTO FOURNISSEUR (ID, NOM) VALUES
(1, 'Française d\'Imports'),
(2, 'Dubois et Fils'),
(3, 'All Business');

-- Insertion de données dans la table ARTICLE
INSERT INTO ARTICLE (ID, REF, DESIGNATION, PRIX, ID_FOU) VALUES
(1, 'A001', 'Crayon HB', 1.50, 1),
(2, 'A002', 'Gomme blanche', 0.80, 1),
(3, 'A003', 'Cahier 100 pages', 2.50, 2),
(4, 'A004', 'Stylo bleu', 3.20, 2),
(5, 'A005', 'Classeur A4', 4.15, 1),
(6, 'A006', 'Feuilles A4 (100)', 5.30, 3),
(7, 'A007', 'Surligneur jaune', 2.10, 2),
(8, 'A008', 'Règle 30cm', 1.95, 1),
(9, 'A009', 'Trombones (50)', 3.80, 3),
(10, 'A010', 'Agrafeuse', 8.50, 2);

-- Insertion de données dans la table BON
INSERT INTO BON (ID, NUMERO, DATE_CMDE, DELAI, ID_FOU) VALUES
(1, 'BC001', '2019-01-15', 5, 1),
(2, 'BC002', '2019-02-20', 3, 2),
(3, 'BC003', '2019-03-10', 7, 3),
(4, 'BC004', '2019-04-05', 4, 1);

-- Insertion de données dans la table COMPO
INSERT INTO COMPO (ID, QTE, ID_ART, ID_BON) VALUES
(1, 10, 1, 1),
(2, 5, 2, 1),
(3, 8, 3, 2),
(4, 12, 4, 2),
(5, 3, 5, 3),
(6, 6, 6, 3),
(7, 15, 7, 4),
(8, 9, 8, 4);