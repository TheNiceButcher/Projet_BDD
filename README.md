# Projet_BDD
##Binôme
* Notre groupe est constitué de :
 	* HAMDANI Harris, numéro d'étudiant 22014430
	* DJELLOUL ABBOU Mohammed Adel, numéro d'étudiant 22018734 

**attention l’exécution du fichier de la création de la base de donnée va supprimé
un schema "pr" s'il en existe un puis le recrée en ajoutant nos tables**


notre base de donnée contient 18 tables
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

chaque table a des contrainte ON DELETE CASCADE ON UPDATE CASCADE nécessaire ainsi que des champs NOT NULL, UNIQUE ou des contrainte de type CHECK


**création de la base de donnée et peuplement:**
 sur le fichier  **projet.sql** on trouve le code sql pour la creation de la base de donée et le peuplement des tables aussi, les fichier csv sont dans le dossier **CsvFiles**

 **les requetes:**
 les requetes on les trouvent sur le fichier **REQ/rqt.sql**, il y a en tout 20 requetes, il y a:
*   une requete récursive
*   une requete avec le WITH
*   une requete avec une jointure externe "LEFT JOIN"
*   une ou plusieur requetes qui porte sur au moins trois ou plusieur tables
*   une requete avec ’auto jointure’
*   une sous-requete corrélée
*   une ou plusieur sous-requete dans le FROM
*   une ou plusieurs sous-requete dans le WHERE
*   deux agregats necessitant GROUP BY et HAVING
*   une requéte impliquant le calcul de deux agrégats
*   deux requetes équivalentes exprimant une condition de totalité, l’une avec des sous requetes corrélées et l’autre avec de l’agrégation
*   deux requˆetes qui renverraient le meme résultat si les tables de contenaient pas de nulls, mais qui renvoient des résultats différents ici
