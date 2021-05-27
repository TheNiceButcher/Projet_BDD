\! echo "les commandes qui ont eu plus de un produit refusé"
SELECT distinct(r.id_commande) FROM refus as r, refus as r1 WHERE r.id_commande=r1.id_commande AND (r.exemplaire<>r1.exemplaire);



