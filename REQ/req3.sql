\! echo "les id_produit des 20 produits qui ont etait refusé le plus"
select id_produit ,count("id_produit") from refus group by id_produit order by count desc limit 20;