/*Lena Wurmsdobler - 23.03.2022
MAK zu SQL*/

select * from gast;

select * from hauptspeise;

select * from menuewahl;

select * from nachspeise;

select * from vorspeise;

-- a)
select concat_ws(' ', g.gast_vname, g.gast_nname) as "Gast",
	   v.vosp_name as "Vorspeise",       
       h.hasp_name as "Hauptspeise",
       case
	   when m.men_beilagensalat is null then "keinen"
       else "Ja"
       end as "Beilagensalat",
       n.nasp_name as "Nachspeise"
  from gast g, menuewahl m, vorspeise v, hauptspeise h, nachspeise n
 where g.gast_id = m.gast_id
   and v.vosp_id = m.vosp_id
   and h.hasp_id = m.hasp_id
   and n.nasp_id = m.nasp_id
 order by 1, v.vosp_name, h.hasp_name, v.vosp_name;
   
-- b)
select concat_ws(' ', g.gast_vname, g.gast_nname) as "Gast ohne Menue"
  from gast g
 where g.gast_id not in (select m.gast_id
						   from menuewahl m);
                           
-- c)
select h.hasp_name as "Hauptgericht"
  from hauptspeise h
 where h.hasp_id not in (select m.hasp_id
						   from menuewahl m);

-- d)
select h.hasp_name as "Hauptgericht", count(m.hasp_id) as "x mal gewaehlt"
  from hauptspeise h, menuewahl m
 where h.hasp_id = m.hasp_id
 group by h.hasp_name;

-- e)
select h.hasp_name as "Hauptgericht", count(m.hasp_id) as "x mal gewaehlt"
  from hauptspeise h, menuewahl m
 where h.hasp_id = m.hasp_id
 group by h.hasp_name
having count(m.hasp_id) > 1;

-- f)
select h.hasp_preis + n.nasp_preis + v.vosp_preis as "Gesamtpreis"
  from hauptspeise h, nachspeise n, vorspeise v, gast g, menuewahl m
 where g.gast_id = m.gast_id
   and g.gast_id = 1
   and h.hasp_id = m.hasp_id
   and v.vosp_id = m.vosp_id
   and n.nasp_id = m.nasp_id;
    
-- g)
select concat_ws(' ', gast_vname, gast_nname) as "Gast", hasp_preis + nasp_preis + vosp_preis as "Gesamtpreis"
  from gast g left join menuewahl m using (gast_id)
			  left join vorspeise v using (vosp_id)
              left join nachspeise n using (nasp_id)
              left join hauptspeise h using (hasp_id)
 group by g.gast_id
 order by gast_nname;
 
 -- h)
 select concat_ws(' ', gast_vname, gast_nname) as "Gast", h.hasp_preis + n.nasp_preis + v.vosp_preis as "Gesamtpreis"
   from hauptspeise h, nachspeise n, vorspeise v, gast g, menuewahl m
  where g.gast_id = m.gast_id
    and h.hasp_id = m.hasp_id
    and v.vosp_id = m.vosp_id
    and n.nasp_id = m.nasp_id
  group by g.gast_id
  order by 2 desc
  limit 0, 1;