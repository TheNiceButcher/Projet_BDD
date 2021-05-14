DROP SCHEMA IF EXISTS pr CASCADE;
CREATE SCHEMA pr;


create table pr.paniers ( 
	id_panier integer primary key);



create table pr.clients( 
	id_client integer primary key, 
	nom varchar(50) NOT NULL, 
	prenom varchar(50) NOT NULL, 
	mail varchar(50) NOT NULL, 
	dateNaiss date NOT NULL, 
	date_inscription timestamp NOT NULL,
	id_panier integer references pr.paniers,
	UNIQUE (mail));


create table pr.produits( 
	id_produit integer primary key,
	nom varchar(50) NOT NULL, 	
 	marque varchar(50) NOT NULL, 
	dispo boolean NOT NULL,
	UNIQUE(marque,nom));


create table pr.commandable(
	id_produit integer references pr.produits primary key,
	delai integer NOT NULL DEFAULT 0, 
	stock integer NOT NULL DEFAULT 0);



create table pr.evolution_prix(
	id_produit integer references pr.produits,
	date timestamp NOT NULL, 
	prix DECIMAL(10,2), 
	primary key(id_produit, date) );


create table pr.categories( 
	id_categorie integer primary key, 
	retour boolean NOT NULL);


create table pr.produit_categories( 
	id_categorie integer references pr.categories,
	id_produit integer references pr.produits,
	primary key(id_categorie, id_produit));


create table pr.textiles(
	id_categorie integer references pr.categories primary key,
	matiere varchar(30) NOT NULL,
	taille varchar(5) NOT NULL, 
	provenance varchar(50) NOT NULL, 
	couleur varchar(10) NOT NULL ,
	temps_max_retour integer  NOT NULL,
	tag_produit varchar (20) NOT NULL );


create table pr.alimentations ( 
	id_categorie integer references pr.categories primary key,
	tag_produit varchar(10) NOT NULL, 
	date_peremption timestamp NOT NULL);


create table pr.equipements ( 
	id_categorie integer references pr.categories primary key,
	taille varchar(11) NOT NULL,
	poids integer NOT NULL , 
	matiere varchar(15) NOT NULL,
	tag_produit varchar(10) NOT NULL, 
	temps_max_retour integer NOT NULL, 
	couleur varchar(10) NOT NULL);


create table pr.paniers_produits ( 
	id_panier integer references pr.paniers, 
	id_produit integer references pr.commandable, 
	primary key(id_panier,id_produit) );


create table pr.commandes( 
	id_commande integer primary key, 
	adresse_livr varchar(50) NOT NULL,
	date date NOT NULL , 
	id_client integer references pr.clients NOT NULL);


create table pr.livraison(  
	id_livraison integer primary key, 
	id_commande integer references pr.commandes,
	date_exp date );


create table pr.colis(  
	id_colis integer primary key, 
	id_livraison integer references pr.livraison NOT NULL, 
	livré boolean NOT NULL);


create table pr.produit_commandé(  
	id_commande integer references pr.commandes NOT NULL, 
	id_produit integer references pr.commandable NOT NULL, 
	en_attente boolean default 't' NOT NULL, 
	date_prev_exp date NOT NULL, 
	annulation boolean default 'f' NOT NULL, 
	id_colis integer references pr.colis NOT NULL, 
	exemplaire integer NOT NULL, 
	primary key(id_produit,id_commande,exemplaire,id_colis),
	CONSTRAINT annulation_enattente CHECK ((en_attente='f' AND annulation='f' )OR(en_attente='t'))
);



create table pr.retours(  
	id_colis integer NOT NULL ,
	id_produit integer NOT NULL, 
	id_commande integer NOT NULL, 
	exemplaire integer NOT NULL, 
	motif varchar(100) NOT NULL, 
	date_retour date NOT NULL,  
	foreign key(id_produit,id_commande,exemplaire,id_colis) references pr.produit_commandé(id_produit,id_commande,exemplaire,id_colis), 
	primary key(id_produit,id_commande,exemplaire,id_colis));


create table pr.refus(
	id_colis integer references pr.colis NOT NULL,
	id_produit integer NOT NULL, 
	id_commande integer NOT NULL, 
	exemplaire integer NOT NULL,
	motif varchar(100) NOT NULL ,  
	foreign key(id_produit,id_commande,exemplaire,id_colis) references pr.produit_commandé(id_produit,id_commande,exemplaire,id_colis), 
	primary key(id_produit,id_commande,exemplaire,id_colis));


create table pr.avis( 
	id_client integer references pr.clients NOT NULL,
	id_commande integer NOT NULL, 
	id_produit integer NOT NULL,
	id_colis integer NOT NULL ,
	exemplaire integer NOT NULL,  
	date_avis date NOT NULL, 
	avis varchar(100) NOT NULL,  
	etoile integer NOT NULL,
	foreign key(id_produit,id_commande,exemplaire,id_colis) references pr.produit_commandé(id_produit,id_commande,exemplaire,id_colis),
        primary key(id_client,id_produit,id_commande,exemplaire,id_colis));

set search_path to pr;
\COPY paniers FROM paniers.csv with (format csv, header);
\COPY clients FROM mycsv.csv  with (format csv, header); 
\COPY produits FROM produit.csv with (format csv, header); 
\COPY evolution_prix FROM prix.csv with (format csv, header); 
\COPY commandable FROM commandable.csv with (format csv, header); 
\COPY categories FROM categories.csv with (format csv, header); 
\COPY produit_categories FROM prodcat.csv with (format csv, header); 
\COPY textiles FROM textile.csv with (format csv, header); 
\COPY alimentations FROM alim.csv with (format csv, header); 
\COPY equipements FROM equipement.csv with (format csv, header); 
\COPY commandes FROM commandes.csv with (format csv, header); 
\COPY livraison FROM livraison.csv with (format csv, header); 
\COPY colis FROM colis.csv with (format csv, header); 
\COPY produit_commandé FROM produit_commande.csv with (format csv, header); 
\COPY refus FROM refus.csv with (format csv, header); 
\COPY retours FROM retour.csv with (format csv, header); 
\COPY evolution_prix FROM prix.csv with (format csv, header);
\COPY avis FROM avis.csv with (format csv, header); 

