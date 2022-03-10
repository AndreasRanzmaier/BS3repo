-- Ranzmaier Andreas 10.03.22
use lager;

-- a) Alle Artikel inkl. Eigenschaft und Verpackungsgröße
select art_name as "Artikel", eig_name as "Eigenschaft", concat_ws('', arve_einheit, ver_groesse) as "Verpackungseinehit"
from artikel_verpackung 
inner join (artikel, eigenschaft, verpackung) using(art_id, eig_id, ver_id);

-- b) wie a) aber auch Artikelname die noch nicht zugeordnet sind
select art_name as "Artikel", eig_name as "Eigenschaft", concat_ws('', arve_einheit, ver_groesse) as "Verpackungseinehit"
from artikel_verpackung 
