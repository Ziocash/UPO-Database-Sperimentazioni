/*

Query 1:
Elencare, per ogni città, la nazione in cui si trova. Il risultato deve contenere la città e il nome della
nazione e essere ordinato lessicograficamente per città.

1- Informazioni correlate: Nome città, nome Paese, codice Paese e codice del Paese della città
2- Proprietà delle informazioni:
    - city.name: character varying(50), non accetta valori NULL, parte della chiave primaria composta citykey
    - city.country: character varying(4), non accetta valori NULL; parte della chiave primaria composta citykey, chiave esterna
    - country.name: character varying(50), non accetta valori NULL, valore univoco, non duplicabile
    - country.code: character varying(4), non accetta valori NULL, chiave primaria countrykey
3- Sottoproblemi:
    - Selezionare il nome della città
    - Selezionare il nome del Paese
4- Assunzioni: 
    - si assume che i dati inseriti siano corretti
5- Viste:
    - nessuna vista richiesta
6- Controllo del risultato:
    -

*/

SELECT city.name, country.name FROM city JOIN country ON city.country = country.code
ORDER BY city.name

/*

Query 2:
Elencare le città attraversate da un fiume (il risultato deve contenere soltanto la città).

1- Informazioni correlate: Nome città e fiume che scorre nella città
2- Proprietà delle informazioni:
    - located.city: character varying(50), accetta valori NULL, chiave esterna
    - located.river: character varying(50), accetta valori NULL, chiave esterna
3- Sottoproblemi:
4- Assunzioni:
5- Viste:
6- Controllo del risultato:

*/

SELECT DISTINCT city FROM located
WHERE river IS NOT NULL

/*

Query 3

1- Informazioni correlate: 
2- Proprietà delle informazioni: 
3- Sottoproblemi:
4- Assunzioni:
5- Viste:
6- Controllo del risultato:

*/

SELECT city.name, country.name FROM country JOIN city ON city.country = country.code
WHERE city.name LIKE '%y%'
ORDER BY country.name, city.name

/*
Query 4

1- Informazioni correlate: Nome città e fiume che scorre nella città
2- Proprietà delle informazioni:
    - located.city: character varying(50), accetta valori NULL, chiave esterna
    - located.river: character varying(50), accetta valori NULL, chiave esterna
3- Sottoproblemi:
4- Assunzioni:
5- Viste:
6- Controllo del risultato:

*/

SELECT city.name, city.latitude FROM city
WHERE latitude > 66 OR latitude < -66

/*

Query 5:
Elencare le nazioni che confinano con l'Italia (il risultato deve comprendere soltanto il nome delle
nazioni).

1- Informazioni correlate: Nome della nazione
2- 
3-
4-
5-
6-

*/

SELECT country.name FROM borders JOIN country ON country.code = country1 OR country2 = country.code
WHERE (borders.country1 = 'I' OR borders.country2 = 'I') AND country.name <> 'Italy'

/*

Query 6.1 (con MAX):
Trovare la capitale con più abitanti tra tutte le capitali (il risultato deve contenere il nome della 
capitale e la sua popolazione).

1- Informazioni correlate: Nome della città, popolazione della città e capitale del Paese
2- 
3- Sottoproblemi: 
    - Selezionare la città con la maggior popolazione 
    - Selezionale la maggior popolazione
4- Assunzioni:
    - Si presuppone che tutte le città abbiano dati di popolazione non nulli
6- Verifica del risultato: 
        SELECT city.name, city.population
        FROM country JOIN city ON country.capital = city.name
        WHERE city.population IS NOT NULL
        ORDER BY city.population DESC

*/

SELECT city.name, city.population
FROM country JOIN city ON country.capital = city.name
WHERE city.population = (SELECT MAX(city.population)
FROM country JOIN city ON country.capital = city.name)

/*

Query 6.2 (senza MAX):
Trovare la capitale con più abitanti tra tutte le capitali (il risultato deve contenere il nome della 
capitale e la sua popolazione) 

1- Informazioni correlate: Nome della città, popolazione della città e capitale del Paese
2- 
3- Sottoproblemi: 
    - Selezionare la città con la maggior popolazione 
    - Selezionale la maggior popolazione
4- Assunzioni:
    - Si presuppone che tutte le città abbiano dati di popolazione non nulli
6- Verifica del risultato:
        SELECT city.name, city.population
        FROM country JOIN city ON country.capital = city.name
        WHERE city.population IS NOT NULL
        ORDER BY city.population DESC

*/

SELECT city.name, city.population
FROM country JOIN city ON country.capital = city.name
WHERE city.population = (SELECT MIN(-1 * city.population)*-1
FROM country JOIN city ON country.capital = city.name)

/*

Query 7.1:
Per ogni città statunitense estrarre la sua popolazione e la superficie dei laghi su cui eventualmente
si affaccia (il risultato deve comprendere la città, la popolazione e l'area complessiva dei suoi laghi)
(scrivere due versioni della query)

*/

SELECT city.name, city.population, SUM(lake.area) 
FROM located JOIN city ON city.name = located.city 
JOIN lake ON located.lake = lake.name
WHERE city.country = 'USA'
GROUP BY city.name, city.population

/*

Query 7.2:
Per ogni città statunitense estrarre la sua popolazione e la superficie dei laghi su cui eventualmente
si affaccia (il risultato deve comprendere la città, la popolazione e l'area complessiva dei suoi laghi)
(scrivere due versioni della query)

*/

-----

/*

Query 8

*/

SELECT temptable.name, temptable.area FROM (SELECT DISTINCT island.name, island.area
FROM geo_island JOIN country ON country.code = geo_island.country JOIN island ON island.name = geo_island.island
EXCEPT
SELECT DISTINCT island.name, island.area
FROM geo_island JOIN country ON country.code = geo_island.country JOIN island ON island.name = geo_island.island
WHERE island.area = (SELECT MAX(island.area)FROM geo_island JOIN country ON country.code = geo_island.country JOIN island ON island.name = geo_island.island)
) AS temptable	
ORDER BY temptable.area DESC

/*

Query <numero>:
<testo>

1- Informazioni correlate: 
2- Proprietà delle informazioni: 
3- Sottoproblemi:
4- Assunzioni:
5- Viste:
6- Controllo del risultato:

*/