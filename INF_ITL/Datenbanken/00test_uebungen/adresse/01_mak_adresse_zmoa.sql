use adresse;
show tables;

-- a)
select plz_nr as "1", ort_name, str_name
from ort  
inner join plz using(ort_id)
inner join plz_strasse using(plz_id)
inner join strasse using(str_id)
order by ort_name and str_name;

-- b)
select ort_name 
from ort 
left join plz using(ort_id)
where plz_id is null;

-- c) 
select plz_nr
from plz 
left join plz_strasse using(plz_id)
where ort_id is null; 

-- d) 1
select ort_name, count(str_id)
from ort
left join plz using(ort_id)
left join plz_strasse using(plz_id)
left join strasse using(str_id)
group by ort_name 
having count(str_id) > 1;

-- e) 
select *
from ort
inner join plz using(ort_id)
inner join plz_strasse using(plz_id)
inner join strasse using(str_id)
group by ort_name;

-- f)
select str_name
from strasse
where str_name like '%u%'; -- % egal, _ one single char

-- g)
select count(plst_id)
from plz_strasse;

-- h)
select count(*) --  lol man kann einfach alles counten
from plz
where ort_id is not null;

-- i)
select plz_nr, ort_name, str_name
from ort 
left outer join plz using(ort_id)
left outer join plz_strasse using(plz_id)
left outer join strasse using(str_id);
