\! echo "les 10 produits qui on été evaluer le plus deux requetes qui donnent la meme chose si la table ne contient pas des null et le contarire si la table contient des null"

\! echo "avec count(etoile) et etoile est un attribut nullable"
select id_produit ,count(etoile) from avis group by id_produit order by count desc limit 10;