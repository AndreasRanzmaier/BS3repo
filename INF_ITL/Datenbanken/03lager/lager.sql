use lager;
/*
a) Artikel | Eigenschaft | Verpackungseinheit
*/
-- Lösung mit NATURAL JOIN
select 	art_name as "Artikel", 
		eig_name as "Eigenschaft", 
		concat_ws(' ', arve_einheit, ver_groesse) as "Verpackungseinheit" 
from 	artikel_eigenschaft natural join (artikel, eigenschaft) 
			natural join artikel_verpackung 
			natural join verpackung 
order by 	art_name, eig_name, ver_groesse, arve_einheit;

-- Lösung mit INNER JOIN
select 	art_name as "Artikel", 
		eig_name as "Eigenschaft", 
		concat_ws(' ', arve_einheit, ver_groesse) as "Verpackungseinheit" 
from 	artikel_verpackung inner join (artikel, eigenschaft) using(art_id, eig_id) 
		inner join verpackung using(ver_id)
order by 	art_name, eig_name, ver_groesse, arve_einheit;

-- Lösung mit Equi Join ("der Join mit der Where-Klausel")
select 	art_name as "Artikel", 
		eig_name as "Eigenschaft", 
		concat_ws(' ', arve_einheit, ver_groesse) as "Verpackungseinheit" 
from 	artikel a, eigenschaft e, verpackung v, artikel_verpackung av 
where   a.art_id = av.art_id 
and 	e.eig_id = av.eig_id 
and 	v.ver_id = av.ver_id  
order by 	art_name, eig_name, ver_groesse, arve_einheit;

/*
b) wie a) aber auch Artikelname die noch nicht zugeordnet sind
*/			
select 	art_name as "Artikel", 
		eig_name as "Eigenschaft", 
		concat_ws(' ', arve_einheit, ver_groesse) as "Verpackungseinheit" 
from 	artikel left outer join artikel_eigenschaft using(art_id) 
		left outer join eigenschaft using(eig_id) 
		left outer join artikel_verpackung using(art_id, eig_id) 
		left outer join verpackung using(ver_id) 
order by 	art_name, eig_name, ver_groesse, arve_einheit;

/*
c) alle Artikel die noch keiner Eigenschaft zugeordnet wurden - mit outer join 
*/
select 	art_name "Noch keiner Eigenschaft zugeordnet" 
from 	artikel left outer join artikel_eigenschaft using(art_id) 
where 	eig_id is null;

/*
d) wie c) aber mit Subquery 
*/
select 	art_name "Noch keiner Eigenschaft zugeordnet" 
from 	artikel 
where 	art_id not in (select art_id from artikel_eigenschaft);

/*
e) Artikel Artikelname und Anzahl der Verpackungseinheiten 
*/
-- Lösung mit NATURAL JOIN
select 	art_name, count(ver_id) as "Anzahl_Verpackungseinheiten" 
from 	artikel natural join artikel_verpackung  
group by 	art_name;

-- Lösung mit INNER JOIN
select 	art_name, count(ver_id) as "Anzahl_Verpackungseinheiten" 
from 	artikel a inner join artikel_verpackung av using(art_id) 
group by 	art_name;

-- Lösung mit Equi Join 
select 	art_name, count(ver_id) as "Anzahl_Verpackungseinheiten" 
from 	artikel a, artikel_verpackung av 
where 	a.art_id = av.art_id  
group by 	art_name;

/*
f) wie d), aber nur Artikel die mehr als einer Verpackungsgröße zugeordnet wurden 
*/
-- Lösung mit NATURAL JOIN
select 	art_name, count(ver_id) as "Anzahl_Verpackungseinheiten" 
from 	artikel natural join artikel_verpackung  
group by 	art_name 
having 	count(ver_id) > 1;

-- Lösung mit INNER JOIN
select 	art_name, count(ver_id) as "Anzahl_Verpackungseinheiten" 
from 	artikel inner join artikel_verpackung using(art_id) 
group by 	art_name 
having 	count(ver_id) > 1;

-- Lösung mit Equi Join 
select 	art_name, count(ver_id) as "Anzahl_Verpackungseinheiten" 
from 	artikel a, artikel_verpackung av 
where 	a.art_id = av.art_id  
group by 	art_name 
having 	count(ver_id) > 1;

/*
g) Welche Artikel wurden noch keiner Verpackung zugeordnet - outer join 
*/
select 	art_name     
from 	artikel left outer join artikel_verpackung using(art_id) 
where 	ver_id is null; 

/*
h) wie g) mit subquery  
*/
select 	art_name     
from 	artikel 
where art_id not in (select art_id from artikel_verpackung);
