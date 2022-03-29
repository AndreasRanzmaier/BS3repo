
-- a)
select gast_id as Gast,
vosp_name as Vorstpeise,  
hasp_name as Hauptspeise,
case when men_beilagensalat 
is null then "keinen" else "ja" end as "Beilage",
nasp_name as Nachspeise
from gast 
inner join menuewahl using(gast_id)
inner join vorspeise using(vosp_id)
inner join hauptspeise using(hasp_id)
inner join nachspeise using(nasp_id)
order by gast_id, vosp_name, hasp_name, hasp_name;

-- b) 
select concat_ws(' ', gast_vname, gast_nname)
as "Gast ohne Menue"
from gast
left join menuewahl using(gast_id)
where mewa_id is null;

-- c) 
select hasp_name 
as "Hauptgericht"
from hauptspeise
left join menuewahl using(hasp_id)
where mewa_id is null;

-- d)
select hasp_name, count(mewa_id)
from hauptspeise
inner join menuewahl using(hasp_id)
group by hasp_name;

-- e)
select hasp_name, count(mewa_id)
from hauptspeise
inner join menuewahl using(hasp_id)
group by hasp_name
having count(mewa_id) > 1;

-- f) 
select sum(vosp_preis + hasp_preis + nasp_preis)
from gast
inner join menuewahl using(gast_id)
inner join vorspeise using(vosp_id)
inner join hauptspeise using(hasp_id)
inner join nachspeise using(nasp_id)
where gast_id = 1;

-- g) 
select * 
