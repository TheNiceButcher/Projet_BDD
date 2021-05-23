\! echo "le nom des produis et leur prix actuel"
SELECT nom, date, prix FROM evolution_prix AS ev ,produits as pr where pr.id_produit=ev.id_produit and date=(select max("date") from evolution_prix as evo  where pr.id_produit=evo.id_produit);

\! echo "le nom des produis et leur prix actuel mais qui ne sont plus disponible"
SELECT nom, date, prix FROM evolution_prix AS ev ,(select * from produits where dispo='f') as pr where pr.id_produit=ev.id_produit and date=(select max("date") from evolution_prix as evo  where pr.id_produit=evo.id_produit);

\! echo "les id_produit des 20 produits qui ont etait refusé le plus"
select id_produit ,count("id_produit") from refus group by id_produit order by count desc limit 20;

\! echo "les 10 clients qui on fait le plus de commande"
select count(id_commande) ,nom , l.id_client from commandes as c , clients as l where l.id_client=c.id_client group by l.id_client order by count desc limit 10;

\! echo "le nom le poids la matiere et la couleur des composants du produit numero 1101"
select nom  ,poids ,matiere,couleur from produits as p , equipements as e ,produit_categories as pc where p.id_produit=pc.id_produit and e.id_categorie=pc.id_categorie and p.id_produit=1101;

\! echo "10 retours avec l'id et le nom du client qui a fait le retour aussi le nom du produit et le motif du retour"
select c.nom,c.id_client, p.nom,r.motif from clients as c , commandes as co ,produits as p, retours as r where c.id_client=co.id_client and r.id_commande=co.id_commande and p.id_produit=r.id_produit group by c.id_client, p.nom, r.motif limit 10;

\! echo "pour chaque client qui a donné des avis le nombre d'etoile classé par étoile"
select c.id_client,c.nom ,c.prenom ,etoile, count(etoile) from clients as c , avis as a where a.id_client=c.id_client  group by c.id_client,etoile;

\! echo "les 10 clients qui on dépensé le plus d'argent sur notre magasin son compter les annulations"
select c.nom, sum(prix) from clients as c ,commandes as co, produit_commandé as pc ,evolution_prix as ev 
where c.id_client=co.id_client and co.id_commande=pc.id_commande and pc.annulation='f' and pc.id_produit=ev.id_produit and co.date=(
select max(date) from evolution_prix as ev1 where ev1.id_produit=pc.id_produit and ev1.date<= co.date) 
group by c.id_client order by sum desc limit 10;

\! echo "les 10 clients qui on dépensé le plus d'argent sur notre magasin son compter les refus ou les retour et les annulations"
select c.nom, sum(prix) from clients as c ,commandes as co, produit_commandé as pc ,evolution_prix as ev 
where c.id_client=co.id_client and co.id_commande=pc.id_commande and pc.annulation='f' and pc.id_produit=ev.id_produit and co.date=(
select max(date) from evolution_prix as ev1 where ev1.id_produit=pc.id_produit and ev1.date<= co.date) and (pc.id_commande, pc.id_produit,pc.id_colis,pc.exemplaire)
NOT IN ( (select r.id_commande,r.id_produit,r.id_colis,r.exemplaire from retours as r) UNION (select r.id_commande,r.id_produit,r.id_colis,r.exemplaire from refus as r) )    
group by c.id_client order by sum desc limit 10;

\! echo "le chifre d'affaire de notre magasin sans compter les retour et les refus"
select sum(prix) from clients as c ,commandes as co, produit_commandé as pc ,evolution_prix as ev
where c.id_client=co.id_client and co.id_commande=pc.id_commande and pc.annulation='f' and pc.id_produit=ev.id_produit and co.date=(
select max(date) from evolution_prix as ev1 
where ev1.id_produit=pc.id_produit and ev1.date<= co.date) and
(pc.id_commande, pc.id_produit,pc.id_colis,pc.exemplaire) NOT IN
( (select r.id_commande,r.id_produit,r.id_colis,r.exemplaire from retours as r) UNION (select r.id_commande,r.id_produit,r.id_colis,r.exemplaire from refus as r) );

\! echo "les 10 produits qui ont le plus de 5 étoiles  "
select nom, count(etoile) from produits as p join avis as a on (a.id_produit=p.id_produit) where etoile=5 group by p.id_produit order by count desc limit 10;

\! echo "les 10 produits les mieux noté "
select nom, avg(etoile) from produits as p join avis as a on (a.id_produit=p.id_produit) group by p.id_produit order by avg desc limit 10;

