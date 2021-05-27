\! echo "les 10 clients qui on dépensé le plus d argent sur notre magasin son compter les annulations"

select c.nom, sum(prix) from clients as c ,commandes as co, produit_commandé as pc ,evolution_prix as ev 
where c.id_client=co.id_client and co.id_commande=pc.id_commande and pc.annulation='f' and pc.id_produit=ev.id_produit and co.date=(
select max(date) from evolution_prix as ev1 where ev1.id_produit=pc.id_produit and ev1.date<= co.date) 
group by c.id_client order by sum desc limit 10;