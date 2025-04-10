-- TP04 - Requêtes SQL avancées
-- Utilisation de la base de données
USE compta2;

-- a. Listez les articles dans l'ordre alphabétique des désignations
SELECT * 
FROM ARTICLE
ORDER BY DESIGNATION ASC;

-- b. Listez les articles dans l'ordre des prix du plus élevé au moins élevé
SELECT *
FROM ARTICLE
ORDER BY PRIX DESC;

-- c. Listez tous les articles qui sont des « boulons » et triez les résultats par ordre de prix ascendant
SELECT *
FROM ARTICLE
WHERE DESIGNATION LIKE '%boulon%'
ORDER BY PRIX ASC;

-- d. Listez tous les articles dont la désignation contient le mot « sachet ».
SELECT *
FROM ARTICLE
WHERE DESIGNATION LIKE '%sachet%';

-- e. Listez tous les articles dont la désignation contient le mot « sachet » indépendamment de la casse !
SELECT *
FROM ARTICLE
WHERE LOWER(DESIGNATION) LIKE '%sachet%';

-- f. Listez les articles avec les informations fournisseur correspondantes. Les résultats
-- doivent être triées dans l'ordre alphabétique des fournisseurs et par article du prix le
-- plus élevé au moins élevé.
SELECT A.*, F.NOM AS NOM_FOURNISSEUR
FROM ARTICLE A
JOIN FOURNISSEUR F ON A.ID_FOU = F.ID
ORDER BY F.NOM ASC, A.PRIX DESC;

-- g. Listez les articles de la société « Dubois & Fils »
SELECT A.*
FROM ARTICLE A
JOIN FOURNISSEUR F ON A.ID_FOU = F.ID
WHERE F.NOM = 'Dubois et Fils';

-- h. Calculez la moyenne des prix des articles de la société « Dubois & Fils »
SELECT AVG(A.PRIX) AS PRIX_MOYEN
FROM ARTICLE A
JOIN FOURNISSEUR F ON A.ID_FOU = F.ID
WHERE F.NOM = 'Dubois et Fils';

-- i. Calculez la moyenne des prix des articles de chaque fournisseur
SELECT F.NOM AS NOM_FOURNISSEUR, AVG(A.PRIX) AS PRIX_MOYEN
FROM ARTICLE A
JOIN FOURNISSEUR F ON A.ID_FOU = F.ID
GROUP BY F.ID, F.NOM;

-- j. Sélectionnez tous les bons de commandes émis entre le 01/03/2019 et le 05/04/2019 à 12h00.
SELECT *
FROM BON
WHERE DATE_CMDE BETWEEN '2019-03-01' AND '2019-04-05 12:00:00';

-- k. Sélectionnez les divers bons de commande qui contiennent des boulons
SELECT DISTINCT B.*
FROM BON B
JOIN COMPO C ON B.ID = C.ID_BON
JOIN ARTICLE A ON C.ID_ART = A.ID
WHERE A.DESIGNATION LIKE '%boulon%';

-- l. Sélectionnez les divers bons de commande qui contiennent des boulons avec le nom du fournisseur associé.
SELECT DISTINCT B.*, F.NOM AS NOM_FOURNISSEUR
FROM BON B
JOIN FOURNISSEUR F ON B.ID_FOU = F.ID
JOIN COMPO C ON B.ID = C.ID_BON
JOIN ARTICLE A ON C.ID_ART = A.ID
WHERE A.DESIGNATION LIKE '%boulon%';

-- m. Calculez le prix total de chaque bon de commande
SELECT B.ID, B.NUMERO, SUM(A.PRIX * C.QTE) AS PRIX_TOTAL
FROM BON B
JOIN COMPO C ON B.ID = C.ID_BON
JOIN ARTICLE A ON C.ID_ART = A.ID
GROUP BY B.ID, B.NUMERO;

-- n. Comptez le nombre d'articles de chaque bon de commande
SELECT B.ID, B.NUMERO, SUM(C.QTE) AS NOMBRE_ARTICLES
FROM BON B
JOIN COMPO C ON B.ID = C.ID_BON
GROUP BY B.ID, B.NUMERO;

-- o. Affichez les numéros de bons de commande qui contiennent plus de 25 articles et
-- affichez le nombre d'articles de chacun de ces bons de commande
SELECT B.ID, B.NUMERO, SUM(C.QTE) AS NOMBRE_ARTICLES
FROM BON B
JOIN COMPO C ON B.ID = C.ID_BON
GROUP BY B.ID, B.NUMERO
HAVING SUM(C.QTE) > 25;

-- p. Calculez le coût total des commandes effectuées sur le mois d'avril
SELECT SUM(A.PRIX * C.QTE) AS COUT_TOTAL_AVRIL
FROM BON B
JOIN COMPO C ON B.ID = C.ID_BON
JOIN ARTICLE A ON C.ID_ART = A.ID
WHERE MONTH(B.DATE_CMDE) = 4 AND YEAR(B.DATE_CMDE) = 2019;