-- Lösungsvorschlag 1. Aufgabe ITL 
use lager_artikel;
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
from 	artikel_eigenschaft inner join (artikel, eigenschaft) using(art_id, eig_id) 
			inner join artikel_verpackung using (arei_id)
			inner join verpackung using(ver_id)
order by 	art_name, eig_name, ver_groesse, arve_einheit;

-- Lösung mit Equi Join
select 	art_name as "Artikel", 
		eig_name as "Eigenschaft", 
		concat_ws(' ', arve_einheit, ver_groesse) as "Verpackungseinheit" 
from 	artikel_eigenschaft ae, 
		artikel a, 
		eigenschaft e, 
		artikel_verpackung av, 
		verpackung v 
where 	a.art_id = ae.art_id 
and 	e.eig_id = ae.eig_id 
and 	ae.arei_id = av.arei_id 
and 	v.ver_id = av.ver_id 		
order by 	art_name, eig_name, ver_groesse, arve_einheit;
	
/*
b) wie d), aber nur Artikel die mehr als einer Verpackungsgröße zugeordnet wurden 
*/
-- Lösung mit NATURAL JOIN
select 	art_name, count(ver_id) as "Anzahl Verpackungseinheiten" 
from 	artikel natural join artikel_eigenschaft natural join artikel_verpackung  
group by 	art_name 
having 	count(ver_id) > 1;
	
-- Lösung mit INNER JOIN
select 	art_name, count(ver_id) as "Anzahl Verpackungseinheiten" 
from 	artikel inner join artikel_eigenschaft using (art_id) 
		inner join artikel_verpackung using(arei_id) 
group by 	art_name 
having 	count(ver_id) > 1;

-- Lösung mit Equi Join
select 	art_name, count(ver_id) as "Anzahl Verpackungseinheiten" 
from 	artikel a, 
		artikel_eigenschaft ae,  
		artikel_verpackung av 
where 	a.art_id = ae.art_id 
AND		ae.arei_id = av.arei_id 		
group by 	art_name 
having 	count(ver_id) > 1;
	
/*
c) wie a) aber auch Artikelname die noch nicht zugeordnet sind
*/			
select 	art_name as "Artikel", 
		eig_name as "Eigenschaft", 
		concat_ws(' ', arve_einheit, ver_groesse) as "Verpackungseinheit" 
from 	artikel left outer join artikel_eigenschaft using(art_id) 
		left outer join eigenschaft using(eig_id) 
		left outer join artikel_verpackung using(arei_id) 
		left outer join verpackung using(ver_id) 
order by 	art_name, eig_name, ver_groesse, arve_einheit;

/*
d) Welche Artikel inkl. Eigenschaft wurden noch keiner Verpackung zugeordnet - outer join 
*/
select 	concat_ws(' ', art_name, eig_name) as "Artikel"  
from 	artikel a left outer join artikel_eigenschaft ae  using(art_id) 
		left outer join eigenschaft using(eig_id) 
		left outer join artikel_verpackung av using(arei_id) 
where 	arve_einheit is null; 

/*
e) wie g) mit subquery  
*/
select 	concat_ws(' ', art_name, eig_name) as "Artikel"  
from 	artikel left join artikel_eigenschaft using(art_id) left join eigenschaft using(eig_id) 
where 	arei_id not in 
		(select arei_id from artikel_verpackung) 
or  	art_id not in (select art_id from artikel_eigenschaft);
