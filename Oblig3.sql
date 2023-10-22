-- Oppgave 2
-- 1)
SELECT *
FROM timelistelinje t
WHERE t.timelistenr = 3;


-- 2)
SELECT COUNT(timelistenr) AS "antall timelister"
FROM timeliste;


-- 3)
SELECT COUNT(timelistenr) AS "antall utbetalte timelister"
FROM timeliste
WHERE status <> 'utbetalt';


-- 4)
--Antar at etter kl. 05 er det folk som kommer veldig tidlig på jobb.
SELECT COUNT(sluttid) AS "antall ganger passert midnatt"
FROM timelistelinje
WHERE sluttid BETWEEN '00:00:00' AND '05:00:00';


-- 5) Deler paa 60 for aa faa antall timer
SELECT SUM(v.varighet/60) AS "ubetalte timer"
FROM Varighet v
INNER JOIN Timeliste t
	ON v.timelistenr = t.timelistenr
WHERE t.status <> 'utbetalt';


-- 6)
SELECT SUM(v.varighet/60) AS "timer i juli"
FROM Varighet v
INNER JOIN Timelistelinje l
	ON v.timelistenr = l.timelistenr
WHERE l.startdato BETWEEN '2016-07-01' AND '2016-07-31';


-- 7)
SELECT t.timelistenr, t.beskrivelse
FROM Timeliste t
WHERE t.beskrivelse LIKE '%Test%' OR t.beskrivelse LIKE '%test%';


-- 8)
SELECT DISTINCT tl.beskrivelse
FROM Timelistelinje tl
INNER JOIN Timeliste t
	ON tl.timelistenr = t.timelistenr
WHERE t.status <> 'utbetalt';




-- Oppgave 3
--
--NB: Dersom det testes på en database der disse tablene finnes fra før, vennligst kommenter ut oppgave3 koden

--1)
INSERT INTO timeliste VALUES
(8, 'utbetalt', '2016-07-29', '2016-08-10', 'Planlegging av neste trinn'),
(9, 'levert', '2016-08-03', null, 'Detaljering av neste trinn'),
(10, 'aktiv', null, null, 'Skriving av rapport');


--2)
INSERT INTO timelistelinje VALUES
(8, 1, '2016-07-25', '10:15', '17:30', 50, 'diskusjoner'),
(8, 2, '2016-07-27', '12:45', '14:00', null, 'konkretisering'),
(9, 1, '2016-07-27', '15:15', '18:45', 70, 'del1'),
(9, 2, '2016-07-28', '10:00', '14:00', 35, 'del2'),
(9, 3, '2016-07-28', '21:00', '04:15', 90, 'del3'),
(9, 4, '2016-08-02', '13:00', '17:00', null, 'del4'),
(10, 1, '2016-08-03', '10:50', '16:10', 40, 'kap1'),
(10, 2, '2016-08-05', '18:00', null, null, 'kap2');




--Oppgave 4 Lag noen egne spørringer, som sjekker om det nye er inkludert.


-- Skrive ut alt om timeliste, for å se om 8, 9 og 10 er lagt til.
SELECT *
FROM timeliste;


-- Skrive ut antall timelistelinjer for å sjekke om riktig antall er der. (Det var 33 før innlegging, nå skal det være 41)
SELECT COUNT(timelistenr) AS "Antall timeliste-linjer"
FROM timelistelinje;


-- Skrive ut alt fra begge listene lagt sammen.
SELECT *
FROM timeliste t
INNER JOIN timelistelinje tl
    ON t.timelistenr = tl.timelistenr;


-- Skriv ut timelister sitt nr, status og beskrivelse som har status "levert"
SELECT t.timelistenr, t.status, t.beskrivelse
FROM timeliste t
WHERE t.status LIKE 'levert';


-- Skriv ut alle utbetalte timelistelinjer, der sluttid er mellom 00 og 06 på natten
SELECT *
FROM Timelistelinje tl
WHERE tl.sluttid BETWEEN '00:00:00' AND '06:00:00';
