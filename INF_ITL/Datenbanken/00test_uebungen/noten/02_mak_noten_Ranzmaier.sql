-- Ranzmaier 30.03.2022
-- MAK SQL abfragen noten
show tables;

-- a)
select concat_ws(' ', per_vname, per_nname) as "Schueler",
gekla_name as "Gegenstand/Klasse",
pgk_note as "Note"
from person 
inner join person_gegenstand_klasse using(per_id)
inner join gegenstand_klasse using(gekl_id)
order by per_id, gekla_name;

-- b) 
select concat_ws(' ', per_vname, per_nname) as "Schueler",
gekla_name as "Gegenstand/Klasse",
pgk_note as "Note"
from person 
left outer join person_gegenstand_klasse using(per_id)
left outer join gegenstand_klasse using(gekl_id)
order by per_id, gekla_name;

-- c)
select concat_ws(' ', per_vname, per_nname) as "Schueler", 
gekla_name as "Gegenstand ohne Note"
from person 
left outer join person_gegenstand_klasse using(per_id)
left outer join gegenstand_klasse using(gekl_id)
where pgk_note is null;

-- d) 
select count(gekl_id) as "Gegenstände ohne Zuordnung"
from gegenstand_klasse 
left join person_gegenstand_klasse using(gekl_id)
where per_id is null;

-- e)
select gekla_name as "Gegenstand",
count(per_id) as "Anzahl Personen"
from gegenstand_klasse
left join person_gegenstand_klasse using(gekl_id)
group by gekl_id;

-- f)
select gekla_name as "Gegenstand",
count(per_id) as "Anzahl Personen"
from gegenstand_klasse
left join person_gegenstand_klasse using(gekl_id)
group by gekl_id
having count(per_id) > 2;

-- g)
select geKla_name as "Gegenstand AMA"
from gegenstand_klasse
where gekla_name like 'AMA%';

-- h) 
select concat_ws(' ', per_vname, per_nname) as "Schueler",
avg(pgk_note)
from person
inner join person_gegenstand_klasse using(per_id)
group by per_id;