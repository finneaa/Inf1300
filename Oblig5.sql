/* 1. Skriv	ut	en	tabell	med	to	kolonner,	først	rollefigur,	så	antall	ganger	dette
 *    rollefigurnavnet	forekommer	i	filmcharacter-tabellen.	Ta	bare	med	navn	som
 *    forekommer	mer	enn	800	ganger.	Sorter	etter	fallende	hyppighet	(365	rader).
 */

 select filmcharacter, count(*) AS "Antall forekomster"
 from filmcharacter
 group by filmcharacter
 having count(*) > 800
 order by count(*) desc;

/* 2. Skriv	ut	personid	og	etternavn	til	Ingrid-er	som	har	spilt	rollen	'Ingrid'.	Ta	også	med
 *    filmtittel	og	land	filmen	er	produsert	i.	(14	med	tittel,	4	uten)
 */

 select p.personid, p.lastname, f.title, fco.country
 from filmparticipation fp
  inner join filmcharacter fc on fp.partid = fc.partid
  left outer join film f on fp.filmid = f.filmid
  inner join filmcountry fco on fp.filmid = fco.filmid
  inner join person p on fp.personid = p.personid
 where fc.filmcharacter like 'Ingrid' and p.firstname like 'Ingrid';

/* 3. Skriv	ut	fornavn,	etternavn,	rollenavn	(fra	filmcharacter)	som	skuespilleren	med
 *    personid=3914169	har	hatt,	og	i	hvilke	filmer	(tittel).	Ikke	ta	med	rollenavn	som	er
 *    tomme.	(169	med	tittel,	7	uten)
 */

 select p.firstname, p.lastname, fc.filmcharacter, f.title
 from filmparticipation fp
  inner join filmcharacter fc on fp.partid = fc.partid
  left outer join film f on fp.filmid = f.filmid
  inner join person p on fp.personid = p.personid
 where fp.personid = '3914169' and fc.filmcharacter != '';

/* 4. Hvem	(id	og	navn)	har	spilt	en	rollfigur	med	navn	Ingrid	flest	ganger?	Skriv	også	ut
 *    antall	ganger.
 */

 select fp.personid, p.lastname, p.firstname, count(fp.personid) as "Antall ganger"
 from filmparticipation fp
  inner join filmcharacter fc on fp.partid = fc.partid
  inner join person p on fp.personid = p.personid
  where fc.filmcharacter like 'Ingrid'
 group by fp.personid,p.lastname, p.firstname
 order by "Antall ganger" desc
 limit 1;

/* 5. Finn	hvilket/hvilke	rollefigurnavn	spilt	av	personer	med	det	samme	navnet	som
 *    fornavn,	som	forekommer	flest	ganger	i	filmdatabasen.
 */

 select fc.filmcharacter, count(fc.filmcharacter) as "Antall forekomster"
 from filmparticipation fp
  inner join filmcharacter fc on fp.partid = fc.partid
  inner join person p on fp.personid = p.personid
 where fc.filmcharacter like p.firstname
 group by fc.filmcharacter
 order by "Antall forekomster" desc
 limit 10;

/*6. Finn	antall	deltagere	i	hver	deltagelsestype	per film	blant	kinofilmer	som	har	Lord	of
 *   the	Rings som	del	av	tittelen	(hint:	kinofilmer	har	filmtype	'C'	i	tabellen	filmitem).
 *   Skriv	ut	filmnavn,	deltagelsestype	og	antall	deltagere.
 */

 select f.title, fp.parttype, count(fp.parttype) as "Antall deltagere"
 from filmparticipation fp
  inner join film f on fp.filmid = f.filmid
  inner join filmitem fi on fp.filmid = fi.filmid and fi.filmtype like 'C'
 where f.title like '%Lord of the Rings%' and fi.filmtype like 'C'
 group by f.title, fp.parttype;

/* 7. Finn	filmer	som	både	er	med	i	sjangeren	Film-Noir	og	Comedy	(3	rader)
 */

 select f.filmid, f.title
 from film f
  inner join filmgenre fg on f.filmid = fg.filmid
 where fg.genre in ('Film-Noir','Comedy')
 group by f.filmid,f.title
 having count(distinct fg.genre) = 2;

/* 8. Tabell	over	antall	sjangrer filmer	med	tittel	som	inneholder	tekststrengen	’Antoine	’
 *    har.	(Legg	merke	til	blank	etter	’toine’.)	Skriv	ut	filmid,	tittel og	antall	sjangrer.	Husk	å
 *    ta	med	filmer	uten	sjanger.	(17	rader,	4	i	en	sjanger eller	mer).
 */

 select f.filmid, f.title, count(genre) as "Antall sjangre"
 from film f
  full outer join filmgenre fg on f.filmid = fg.filmid
 where f.title like '%Antoine %'
 group by f.filmid, f.title
 order by count(genre) desc;

/* 9. Hvilke	skuespillere	(navn	og	antall	filmer)	har	spilt	figurer	med unikt	rollenavn
 *    (rollenavn	som	forekommer	kun	i	én	film)	i	mer	enn	199 filmer? ( 13	(23) rader )
 */

 select p.firstname || ' ' || p.lastname AS "Fullt navn", count(fc.filmcharacter) as "Antall filmer"
 from filmparticipation fp
  natural join filmcharacter fc
  natural join person p
  inner join (
    select filmcharacter
    from filmcharacter
    group by filmcharacter
    having count(filmcharacter) = 1
  ) unike on unike.filmcharacter = fc.filmcharacter
where fp.parttype = 'cast'
group by "Fullt navn"
having count(*) > 199
order by count(*) desc;
