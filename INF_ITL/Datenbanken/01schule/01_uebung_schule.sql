-- R. Martl, 7.3.22
-- Übung
show databases;
use schule;
show tables;
select * from beruf;
describe person;
show create table person_has_beruf;
select concat(per_vname, ' ', per_nname, ' - ', per_id) as "Alle Personen"  
from person;
select concat_ws(' ', per_vname, per_nname, per_id) as "Person" 
from person;
-- Inner Join 
-- Beispiel mit Equi-Join (der Join mit der Where-Klausel) 
select concat_ws(' ', per_vname, per_nname) as "Person", 
		ber_name as "Beruf" 
from  person p, person_has_beruf phb, beruf b 
where p.per_id =phb.person_per_id 
and b.ber_id = phb.beruf_ber_id 
order by Beruf;  -- oder ber_name, oder 2

-- INNER JOIN 
select concat_ws(' ', per_vname, per_nname) as "Person", 
		ber_name as "Beruf" 
from  person p inner join person_has_beruf phb 
				on p.per_id = phb.person_per_id 
			   inner join beruf b 
                on b.ber_id = phb.beruf_ber_id;

/* ein weiterer Inner Join wäre NATURAL JOIN 
   dieser vergleicht ALLE Attribute ALLER Tabellen 
   die die gleiche Bezeichnung haben
   Schreibweise:
   select * from a natural join b;
*/
-- insert
-- insert into person (per_vname, per_nname) values('Johann', 'Freitag');
-- insert into person_has_beruf values(3, 1);
-- Anzahl der Personen je Beruf
select ber_name as "Beruf", 
	   count(person_per_id) as "Anzahl Personen" 
from person_has_beruf phb inner join beruf b 
		on b.ber_id = phb.beruf_ber_id 
group by Beruf;    
-- Welchen Beruf haben mehr als 2 Personen?
select ber_name as "Beruf", 
	   count(person_per_id) as "Anzahl Personen" 
from person_has_beruf phb inner join beruf b 
		on b.ber_id = phb.beruf_ber_id 
group by Beruf 
having count(person_per_id) > 2;   

-- Alle Personen, die im Nachnamen ein u haben
select 	* 
from 	person 
where 	per_nname like '%u%';
-- % ... Joker für beliebig viele beliebige Zeichen
-- _ ... Joker für ein beliebiges Zeichen 

-- Outer Join
select 	* 
from 	person p left outer join person_has_beruf phb 
			on  p.per_id = phb.person_per_id  
            left outer join beruf b 
            on b.ber_id = phb.beruf_ber_id;
            
select 	* 
from 	person_has_beruf phb right outer join person p
			on  p.per_id = phb.person_per_id  
            left outer join beruf b 
            on b.ber_id = phb.beruf_ber_id 
where phb.beruf_ber_id is null;

select * 
from person 
where per_id not in (select person_per_id from person_has_beruf);

-- Limit
select * from person limit 0, 1;

