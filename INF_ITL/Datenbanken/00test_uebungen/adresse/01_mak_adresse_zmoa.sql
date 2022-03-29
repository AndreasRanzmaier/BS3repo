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
left outer join plz using(ort_id)
where plz_nr is null;

-- 3)
select plz_nr as "PLZ"
from plz 
left outer join plz_strasse using(plz_id)
where str_id is null;

-- 4) group by ort_name having count(str_id) > 1
select ort_name, str_id 
from ort
left join plz using(ort_id)
left join plz_strasse using(plz_id)
left join strasse using(str_id)
group by ort_name;