-- Ranzmaier Andreas 10.03.22
use lager;

-- a) Alle Artikel inkl. Eigenschaft und Verpackungsgröße
select art_name as "Artikel", eig_name as "Eigenschaft", concat_ws('', arve_einheit, ver_groesse) as "Verpackungseinehit"
from artikel_verpackung 
inner join (artikel, eigenschaft, verpackung) using(art_id, eig_id, ver_id);

-- b) wie a) aber auch Artikelname die noch nicht zugeordnet sind 
-- identifying relationship
select art_name as "Artikel", eig_name as "Eigenschaft", concat_ws('', arve_einheit, ver_groesse) as "Verpackungseinehit"
from  artikel 
left outer join artikel_eigenschaft using(art_id)
left outer join eigenschaft using(eig_id)
left outer join artikel_verpackung using(art_id, eig_id)
left outer join verpackung using(ver_id);

-- c) alle Artikel die noch keiner Eigenschaft zugeordnet wurden - mit outer join
select art_name as "Keine Eigenschaft"
from artikel 
left outer join artikel_eigenschaft using(art_id)
where eig_id is null;

-- d) wie c) aber mit Subquery 
select art_name as "Keine Eigenschaft"
from artikel 
where art_id not in (select art_id from artikel_eigenschaft);

-- e) Artikel Artikelname und Anzahl der Verpackungseinheiten 
select art_name, count(ver_id)
from artikel inner join artikel_verpackung using(art_id)
group by art_name;

-- f) wie e), aber nur Artikel die mehr als einer Verpackungsgröße zugeordnet wurden 
select art_name, count(ver_id)
from artikel inner join artikel_verpackung using(art_id)
group by art_name
having count(ver_id) > 1;

-- g) Welche Artikel wurden noch keiner Verpackung zugeordnet - outer join
select art_name     
from artikel left outer join artikel_verpackung using(art_id) 
where ver_id is null; 

-- h) wie g) aber mit subquery
 select art_name 
from artikel 
where art_id not in (select art_id from artikel_verpackung);
