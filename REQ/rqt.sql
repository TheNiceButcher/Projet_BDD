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

\! echo "10 retours avec  id et le nom du client qui a fait le retour aussi le nom du produit et le motif du retour"
select c.nom,c.id_client, p.nom,r.motif from clients as c , commandes as co ,produits as p, retours as r where c.id_client=co.id_client and r.id_commande=co.id_commande and p.id_produit=r.id_produit group by c.id_client, p.nom, r.motif limit 10;

\! echo "pour chaque client qui a donné des avis le nombre d etoile classé par étoile"
select c.id_client,c.nom ,c.prenom ,etoile, count(etoile) from clients as c , avis as a where a.id_client=c.id_client  group by c.id_client,etoile;

\! echo "les 10 clients qui on dépensé le plus d argent sur notre magasin son compter les annulations"
select c.nom, sum(prix) from clients as c ,commandes as co, produit_commandé as pc ,evolution_prix as ev 
where c.id_client=co.id_client and co.id_commande=pc.id_commande and pc.annulation='f' and pc.id_produit=ev.id_produit and co.date=(
select max(date) from evolution_prix as ev1 where ev1.id_produit=pc.id_produit and ev1.date<= co.date) 
group by c.id_client order by sum desc limit 10;

\! echo "les 10 clients qui on dépensé le plus d argent sur notre magasin son compter les refus ou les retour et les annulations"
select c.nom, sum(prix) from clients as c ,commandes as co, produit_commandé as pc ,evolution_prix as ev 
where c.id_client=co.id_client and co.id_commande=pc.id_commande and pc.annulation='f' and pc.id_produit=ev.id_produit and co.date=(
select max(date) from evolution_prix as ev1 where ev1.id_produit=pc.id_produit and ev1.date<= co.date) and (pc.id_commande, pc.id_produit,pc.id_colis,pc.exemplaire)
NOT IN ( (select r.id_commande,r.id_produit,r.id_colis,r.exemplaire from retours as r) UNION (select r.id_commande,r.id_produit,r.id_colis,r.exemplaire from refus as r) )    
group by c.id_client order by sum desc limit 10;

\! echo "le chifre d affaire de notre magasin sans compter les retour et les refus"
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

\! echo "les 10 produits les plus commandé par nos clients adolescent "
WITH client_ado AS (select * from clients where datenaiss > (now()- interval '18 year')::date)
SELECT p.nom, count(p.nom) from client_ado as c , produit_commandé as pc,produits as p, commandes as co 
where co.id_client=c.id_client and co.id_commande=pc.id_commande and p.id_produit=pc.id_produit
group by p.id_produit
order by count desc 
limit 10;

\! echo "les differents produits que le client 1 à commandé"
WITH recursive produit_de_x(id_client,id_produit) AS (
VALUES(1,0)
UNION 
select c.id_client,p.id_produit 
from produit_commandé as p , produit_de_x as c, commandes as co
where c.id_client=co.id_client and co.id_commande=p.id_commande)
select * from produit_de_x where id_produit<>0;

\! echo "le produit qui a été commandé sur tous les commandes avec de l agrégation"
SELECT p.id_produit from produit_commandé as p group by id_produit having count(distinct id_commande)=(select count(distinct id_commande) from commandes );

\! echo "le produit qui a été commandé sur tous les commandes avec des sous requetes corrélées attention cette requette peut prendre des minutes pour calculer le resultat vu la taille des deux tables dans le NUTURAL JOIN"
SELECT p.id_produit from produit_commandé as p where NOT EXISTS(
SELECT c.id_commande from commandes as c where c.id_commande NOT IN
(select c2.id_commande from commandes as c2 NATURAL JOIN produit_commandé as p2 
where p2.id_produit=p.id_produit));

\! echo "les 10 produits qui on été evaluer le plus deux requetes qui donnent la meme chose si la table ne contient pas des null et le contarire si la table contient des null"

\! echo "avec count(*)"
select id_produit ,count(*) from avis group by id_produit order by count desc limit 10;

\! echo "avec count(etoile) et etoile est un attribut nullable"
select id_produit ,count(etoile) from avis group by id_produit order by count desc limit 10;

\! echo "les produits et leurs avis avec id du client qui a donnée l avis et NULL pour les produis qui ont jamais eu d avis"
SELECT avis.id_client, produits.id_produit, avis FROM produits LEFT JOIN avis ON avis.id_produit=produits.id_produit ;

\! echo "les commandes qui ont eu plus de un produit refusé"
SELECT distinct(r.id_commande) FROM refus as r, refus as r1 WHERE r.id_commande=r1.id_commande AND (r.exemplaire<>r1.exemplaire);



