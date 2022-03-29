use adresse;
show tables;

-- 1) 
select plz_nr as "1", ort_name, str_name
from ort  
inner join plz using(ort_id)
inner join plz_strasse using(plz_id)
inner join strasse using(str_id)
order by ort_name and str_name;

-- 2)
select ort_name 
from ort
left outer join plz using(plz_id)
where plz_name is null;
