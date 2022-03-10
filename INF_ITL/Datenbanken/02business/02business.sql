-- business 
-- Andreas Ranzmaier 09.03.22
-- a) Ausgabe aller DS und Attribute der Tabelle PRODUCER
select * from producer;

-- b) Tabellenstruktur der Tabelle PRODUCER ausgeben
SHOW FIELDS FROM producer;
describe article_producer;

-- c) Geben Sie von der Tabelle ARTICLE_PRODUCER, 
--    die Bezeichnung der CONSTRAINTs aus (show create table)
SHOW CREATE TABLE article_producer;

-- d) Alle PRODUCER aufsteigend nach Bezeichnung sortiert
select pro_name from producer ORDER BY pro_name ASC;
 
-- e)Alle Artikel + Herstellerbezeichnung sortiert nach 
--   Herstellerbezeichnung absteigend und innerhalb nach Artikelbezeichnung aufsteigend
-- e1) inner join 
select a.art_name, p.pro_name
from article a inner join article_producer ap using(art_id) 
			   inner join producer p using(pro_id)
 order by p.pro_name desc, a.art_name;

-- e2) natural join 
select a.art_name, p.pro_name
from article a natural join producer p natural join article_producer ap
order by p.pro_name DESC, a.art_name ASC;

-- e3) equi join 
select a.art_name, p.pro_name
    from article a, article_producer ap, producer p
 where a.art_id = ap.art_id and p.pro_id = ap.pro_id
 order by p.pro_name desc, a.art_name asc;

-- f) Herstellerbezeichnung, Artikelbezeichnung und Preis ausgeben. 
--    Alias für Attribute: Hersteller | Artikel| Preis
select p.pro_name as "Hersteller", a.art_name as "Artikel", a.art_price as "Preis"
from article a natural join producer p natural join article_producer ap;

-- g) gleich wie f) abe nur der 3. Datensatz
select p.pro_name as "Hersteller", a.art_name as "Artikel", a.art_price as "Preis"
from article a natural join producer p natural join article_producer ap
Limit 2, 1;

-- h) Alle Artikel + Herstellerbezeichnung, 
-- 	  auch jene Artikel die nicht verknüpft sind sortiert nach
-- 	  Herstellerbezeichnung absteigend und dann Artikelbezeichnung aufsteigend

-- adding a article with no producer 
insert into article (art_name, art_price)
values ('vonNiemandem', '400');

select a.art_name, p.pro_name
from article a 
left outer join article_producer ap using(art_id)
left outer join producer p using (pro_id)
order by p.pro_id desc, a.art_id asc;

-- i) Anzahl der Artikel je Hersteller(bezeichnung)– nur jene Artikel, 
--    die einen Hersteller haben
select p.pro_name, count(ap.art_id) -- count ist eine Funktion 
from producer p 
natural join article_producer ap  
group by p.pro_name; -- nach einer funktion muss man gruppieren siehe pp s11
					 -- zerlegt den count ind die einzelnen Attribute

-- j) Anzahl der Artikel je Hersteller (id genügt) –
--    auch jene Hersteller, die nicht verknüpft sind, sortiert nach Anzahl
select p.pro_id, count(ap.art_id)
from producer p 
left outer join article_producer ap using(pro_id)
group by p.pro_name
order by count(ap.art_id);

-- k) Herstellerbezeichnung jener Hersteller ausgeben, 
--    die mit einem Artikel verknüpft sind (keine
--    mehrfach Ausgabe der Herstellerbezeichnung ‐ DISTINCT)
select distinct p.pro_name
from producer p
inner join article_producer ap using(pro_id);

-- l) Anzahl aller Artikel
--    nun 5 da wir vorher einen Insertet haben
select count(art_id)
from article;

-- m) Welche Hersteller haben noch keine Artikel?
select p.pro_name
from producer p
left join article_producer ap on ap.pro_id = p.pro_id
where ap.art_id is null;

-- n) Anzahl der Artikel je Hersteller – nur jene Hersteller, die mehr als einen Artikel haben
select p.pro_name, count(ap.art_id) as anz
from producer p  
natural join article_producer ap 
group by p.pro_name
having anz > 1;

-- R. Martl, 10.03.22
-- selecting all ds not in the other
-- outer join
select * from article
left outer join article_producer using (art_id) -- using kann nur dann verwendet werden wennpk und fk gleich sind
where pro_id is null;

-- subquery
select * from article
where art_id not in 
(select art_id from article_producer);

-- Aufgabe: alle Hersteller die noch keinen Artikel haben 
-- outer join
select p.pro_name
from producer p
left join article_producer ap using(pro_id)
where ap.art_id is null;

-- sub query 
select p.pro_name 
from producer p
where pro_id not in (select pro_id from article_producer);

-- natural join (gehört zu Inner Joins)
select art_name, pro_name
from article_producer natural join (producer, article);
-- natural join: vergleicht von allen Tabellen, 
-- alle Atribute mit gleichem Namen!