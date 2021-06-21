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
    - la tabella city contiene un campo country che corrisponde al codice della nazione
     (city.name = Rome -> city.country = IT -> country.code = IT -> country.name = Italy)

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
    - non risultano sottoproblemi
4- Assunzioni:
    - si assume che i dati siano corretti
    - si assume che essendoci più fiumi nella stessa città la città sia elencata una volta sola
5- Viste:
    - nessuna vista richiesta
6- Controllo del risultato:
    - la tabella "located" contiene il campo "river", se non è nullo, nella città scorre un fiume
    (es.: Parigi -> Senna)

*/

SELECT DISTINCT city FROM located
WHERE river IS NOT NULL

/*

Query 3:
Elencare le città con un nome che comprende la lettera y in qualsiasi posizione (il risultato deve 
contenere il nome della città e il nome del paese e essere ordinato per paese e città).

1- Informazioni correlate: Nome città, nome nazione, codice nazione e nazione della città
2- Proprietà delle informazioni: 
    - city.name: character varying(50), non accetta valori NULL, parte della chiave primaria composta citykey
    - city.country: character varying(4), non accetta valori NULL; parte della chiave primaria composta citykey, chiave esterna
    - country.name: character varying(50), non accetta valori NULL, valore univoco, non duplicabile
    - country.code: character varying(4), non accetta valori NULL, chiave primaria countrykey
3- Sottoproblemi:
    - Selezionare il nome della città in base alla lettera y
    - Selezionare il nome del Paese
4- Assunzioni:
    - si assume che i dati siano corretti
5- Viste:
    - nessuna vista richiesta
6- Controllo del risultato:
    - controllo che tutti i nomi delle città contengano la lettera y in una posizione qualsiasi

*/

SELECT city.name, country.name FROM country JOIN city ON city.country = country.code
WHERE city.name LIKE '%y%'
ORDER BY country.name, city.name

/*
Query 4:
Elencare le città che si trovano nei circoli polari artico e antartico, cioè oltre 66 gradi di latitudine 
nord e sud (il risultato deve contenere le città e la loro latitudine).

1- Informazioni correlate: Nome città e latitudine della città
2- Proprietà delle informazioni:
    - city.name: character varying(50), non accetta valori NULL, parte della chiave primaria composta citykey
    - city.latitude: numeric, accetta valori NULL
3- Sottoproblemi:
    - Selezionare tutte le città con latitudine > 66
    - Selezionare tutte le città con latitudine < -66
4- Assunzioni:
    - si assume che i dati siano corretti
    - si assume che i valori massimo e minimo di latitudine non superino 90 e -90
5- Viste:
    - nessuna vista richiesta
6- Controllo del risultato:
    - SELECT city.name, city.latitude FROM city WHERE latitude > 66 sia parte del risultato della query
    - SELECT city.name, city.latitude FROM city WHERE latitude < -66 sia parte del risultato della query
*/

SELECT city.name, city.latitude FROM city
WHERE latitude > 66 OR latitude < -66

/*

Query 5:
Elencare le nazioni che confinano con l'Italia (il risultato deve comprendere soltanto il nome delle
nazioni).

1- Informazioni correlate: Nome della nazione, codice della nazione e il confine tra due nazioni
2- Proprietà delle informazioni:
    - country.name: character varying(50), non accetta valori NULL, valore univoco, non duplicabile
    - country.code: character varying(4), non accetta valori NULL, chiave primaria countrykey
    - borders.country1: character varying(4), non accetta valori NULL, parte della chiave primaria composta borderkey
    - borders.country2: character varying(4), non accetta valori NULL, parte della chiave primaria composta borderkey
3- Sottoproblemi:
    - Selezionare tutti i confini che contengono il codice nazione I in qualsiasi dei due campi di borders
    - Scartare tutti i confini il cui nome nazione corrisponde a "Italia"
4- Assunzioni:
    - si assume che i dati siano corretti
    - si assume che i confini non vengano modificati spesso
5- Viste:
    - nessuna vista richiesta 
6- Controllo del risultato:
    - il risultato deve contenere "Francia", "Svizzera", "Austria", "Slovenia", "San Marino" e "Città del Vaticano"

*/

SELECT country.name FROM borders JOIN country ON country.code = country1 OR country2 = country.code
WHERE (borders.country1 = 'I' OR borders.country2 = 'I') AND country.name <> 'Italy'

/*

Query 6.1 (con MAX):
Trovare la capitale con più abitanti tra tutte le capitali (il risultato deve contenere il nome della 
capitale e la sua popolazione).

1- Informazioni correlate: Nome della città, popolazione della città e capitale del Paese
2- Proprietà delle informazioni:
    - city.name: character varying(50), non accetta valori NULL, parte della chiave primaria composta citykey
    - city.population: numeric, accetta valori NULL 
    - country.capital: character varying(50), accetta valori NULL
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
2- Proprietà delle informazioni:
    - city.name: character varying(50), non accetta valori NULL, parte della chiave primaria composta citykey
    - city.population: numeric, accetta valori NULL 
    - country.capital: character varying(50), accetta valori NULL
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

1- Informazioni correlate: 
2- Proprietà delle informazioni: 
3- Sottoproblemi:
4- Assunzioni:
5- Viste:
6- Controllo del risultato:

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

1- Informazioni correlate: 
2- Proprietà delle informazioni: 
3- Sottoproblemi:
4- Assunzioni:
5- Viste:
6- Controllo del risultato:

*/

-----

/*

Query 8


1- Informazioni correlate: 
2- Proprietà delle informazioni: 
3- Sottoproblemi:
4- Assunzioni:
5- Viste:
6- Controllo del risultato:

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