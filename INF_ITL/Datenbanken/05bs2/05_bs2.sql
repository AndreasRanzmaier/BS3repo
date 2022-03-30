-- 05 bs2 mak übungen 
-- Ranzmaier Andreas 14.03.2022

-- 1) Verwenden Sie diese Datenbank für alle nachfolgenden Aufgaben mit dem geeigneten Befehl.
use bs2_mak;
show tables;

-- 2) Geben Sie die Anzahl der Schüler je Schuljahr aus (sortiert nach Schuljahr)
select scja_name as "Schuljahr", count(sch_id)
from schuljahr 
inner join schuljahr_klasse using(scja_id)
inner join schueler using(sckl_id)
group by scja_id;

-- 3) Geben Sie alle Klassen aus, die noch KEINEM Schuljahr zugeordnet sind.
select kla_name
from klasse 
left outer join schuljahr_klasse using(kla_id)
left outer join schuljahr using (scja_id)
where scja_id is null;

-- 4) 4.	Geben Sie alle Schüler der Klasse 4 Klassen (alle Klassen die mit 4 beginnen) sortiert nach Klassen im Schuljahr 2020/2021 aus.
select concat_ws(' ', per_vname, per_nname)
from schueler
inner join schuljahr_klasse using(sckl_id)
inner join person using(per_id)
inner join schuljahr using(scja_id)
where kla_id = 4 or kla_id = 5 and scja_id = 2;

-- ??5) Geben Sie die Anzahl der Schüler je Schuljahr/Klasse, inkl. Anzahl der Personen, die noch keiner Klasse zugeordnet wurden aus. Ergebnis:
select
concat_ws(' ', scja_name, kla_name), count(per_id)
from schuljahr
inner join schuljahr_klasse using(scja_id)
inner join klasse using(kla_id)
inner join schueler using(sckl_id)
inner join person using(per_id)
group by concat_ws(' ', scja_name, kla_name)
order by concat_ws(' ', scja_name, kla_name) desc;
-- todo: nicht zugeteile Anzahl fehlt ka wie

-- 6) Geben Sie die Person aus, die noch keinem Schuljahr zugeordnet wurde.
select concat_ws(' ', per_vname, per_nname)
from person
left outer join schueler using(per_id)
left outer join schuljahr_klasse using(sckl_id)
where scja_id is null
group by per_id; 

-- 7) a)	Geben Sie an, wie vielen Schuljahren einzelne Klassen zugeordnet sind – Sortierung nach Klasse alle Klassen
select kla_name ,
count(scja_id)
from klasse 
left join schuljahr_klasse using(kla_id)
group by kla_name;

-- 7 b)
select kla_name
count(scja_id)
from klasse 
left join schuljahr_klasse using(kla_id)
group by kla_name
having kla_name = "2aAPC";

-- 7 c)
select kla_name,
count(scja_id)
from klasse 
left join schuljahr_klasse using(kla_id)
group by kla_name
having count(scja_id) > 1;

-- 8) 8.Geben Sie alle Personen aus, die entweder im Vornamen oder im Nachnamen an zweiter Stelle mit 'er' beginnen. 
select * from person
where per_vname like "_er%" or per_nname like "_er%";

-- 9) 9.	Geben Sie alle Schuljahre, zugeordneten Klassen und Schüler aus. Sortieren Sie die Ausgabe nach Schuljahr, Klasse, Nachname und Vorname.
select scja_name as "Schuljahr", kla_name as "Klasse", concat_ws(' ',per_nname, per_vname) as "Person"
from schuljahr
inner join schuljahr_klasse using(scja_id)
inner join klasse using(kla_id)
inner join schueler using(sckl_id)
inner join person using(per_id)
order by scja_name, kla_name, per_nname, per_vname;

-- 9) 
	

-- 10) Geben Sie den CREATE TABLE Befehl für die Tabelle schueler aus.
show create table schueler;