# Projet_BDD
## Binôme
* Notre groupe est constitué de :
 	* HAMDANI Harris, numéro d'étudiant 22014430
	* DJELLOUL ABBOU Mohammed Adel, numéro d'étudiant 22018734

**attention l’exécution du fichier de la création de la base de donnée va supprimé
un schéma "pr" s'il en existe un puis le recrée en ajoutant nos tables**

## Composition de la base de données
Notre base de donnée contient 18 tables
*  alimentations
*  avis
*  categories
*  clients
*  colis
*  commandable
*  commandes
*  equipements
*  evolution_prix
*  livraison
*  paniers
*  paniers_produits
*  produit_categories
*  produit_commandé
*  produits
*  refus
*  retours
*  textiles

Chaque table a les contraintes ON DELETE CASCADE ON UPDATE CASCADE nécessaires ainsi que des champs NOT NULL, UNIQUE ou des contrainte de type CHECK.


**création de la base de donnée et peuplement:**
 Dans le fichier  **projet.sql** on trouve le code sql pour la création de la base de donnée et le peuplement des tables aussi, les fichier csv sont dans le dossier **CsvFiles**

 **les requêtes:**
 Les requêtes se trouvent dans le fichier **REQ/rqt.sql**. Elles sont au nombre de 20, avec :
*   une requête récursive
*   une requête avec le WITH
*   une requête avec une jointure externe "LEFT JOIN"
*   une ou plusieurs requêtes qui porte sur au moins trois ou plusieurs tables
*   une requête avec ’auto jointure’
*   une sous-requête corrélée
*   une ou plusieurs sous-requête dans le FROM
*   une ou plusieurs sous-requête dans le WHERE
*   deux agrégats nécessitant GROUP BY et HAVING
*   une requête impliquant le calcul de deux agrégats
*   deux requêtes équivalentes exprimant une condition de totalité, l’une avec des sous requêtes corrélées et l’autre avec de l’agrégation
*   deux requêtes qui renverraient le même résultat si les tables de contenaient pas de NULLs, mais qui renvoient des résultats différents ici
