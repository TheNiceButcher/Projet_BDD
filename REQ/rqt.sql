SELECT nom, date, prix FROM evolution_prix AS ev ,produits as pr where pr.id_produit=ev.id_produit and date=(select max("date") from evolution_prix as evo  where pr.id_produit=evo.id_produit);

SELECT nom, date, prix FROM evolution_prix AS ev ,(select * from produits where dispo='f') as pr where pr.id_produit=ev.id_produit and date=(select max("date") from evolution_prix as evo  where pr.id_produit=evo.id_produit);

select id_produit ,count("id_produit") from refus group by id_produit order by count desc limit 10;

select count(id_commande) ,nom , l.id_client from commandes as c , clients as l where l.id_client=c.id_client group by l.id_client order by count desc limit 10

select nom ,taille ,poids ,matiere,couleur from produits as p , equipements as e ,produit_categories as pc where p.id_produit=pc.id_produit and e.id_categorie=pc.id_categorie and p.id_produit=1101;

select c.nom,c.id_client, p.nom,r.motif from clients as c , commandes as co ,produits as p, retours as r where c.id_client=co.id_client and r.id_commande=co.id_commande and p.id_produit=r.id_produit group by c.id_client, p.nom, r.motif;


