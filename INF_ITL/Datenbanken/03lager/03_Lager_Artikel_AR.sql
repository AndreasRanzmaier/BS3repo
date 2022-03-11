-- -- Ranzmaier Andreas 10.03.22
use lager_artikel;

-- a) Artikel | Eigenschaft | Verpackungseinheit
select art_name as "Artikel", eig_name as "Eigenschaft", concat_ws('', arve_einheit, ver_groesse) as "Verpackungseinehit"
from artikel_eigenschaft 
inner join eigenschaft using(eig_id)
inner join artikel using(art_id)
inner join artikel_verpackung using(arei_id)
inner join verpackung using(ver_id);

-- b) Welche Artikel wurde mehr als einer Verpackungsgröße zugeordnet wurde
select art_name, count(ver_id)
from artikel 
natural join artikel_eigenschaft 
natural join artikel_verpackung
group by art_name
having count(ver_id) > 1;

-- c) wie a) aber auch Artikelname, die noch nicht zugeordnet sind
select art_name as "Artikel", eig_name as "Eigenschaft", concat_ws('', arve_einheit, ver_groesse)
from artikel 
left outer join artikel_eigenschaft using(art_id)
left outer join eigenschaft using(eig_id)
left outer join artikel_verpackung using(arei_id)
left outer join verpackung using(ver_id);

-- d) Welche Artikel inkl. Eigenschaft wurden noch keiner Verpackung zugeordnet - outer join 
select concat_ws(' ', art_name, eig_name) as "Artikel"
from artikel 
left outer join artikel_eigenschaft using(art_id)
left outer join eigenschaft using(eig_id)
left outer join artikel_verpackung using(arei_id)
where arve_id is null;

-- e) wie d) nur mit subquery
select concat_ws(' ', art_name, eig_name) as "Artikel"
from artikel
left outer join artikel_eigenschaft using(art_id)
left outer join eigenschaft using(eig_id)
where arei_id not in (select arei_id from artikel_verpackung)
or art_id not in (select art_id from artikel_eigenschaft);

 

