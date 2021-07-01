INSERT INTO public.paziente(
	codicefiscale, nome, cognome, statocivile, impiego, datanascita)
	VALUES ('CF1', 'Mario', 'Rossi', 'celibe', NULL, '12/12/1983'),
	('CF2', 'Alfredo', 'Alfredi', 'sposato', NULL, '1/1/1953'),
	('CF3', 'Maurizio', 'Cogli', NULL, NULL, '10/07/1966'),
	('CF4', 'Bianca', 'Lobianco', 'nubile', NULL, '4/9/1999'),
	('CF5', 'Carola', 'Scagni', NULL, NULL, '31/01/2012'),
	('CF6', 'Saro', 'Conte', 'sposato', NULL, '15/4/1984'),
	('CF7', 'Tina', 'Cozza', NULL, NULL, '4/8/2005');

INSERT INTO public.medico(
	codicefiscale, nome, cognome, email, datanascita, dataabilitazione, abilitato, specializzazione)
	VALUES ('CFM1', 'Costa', 'Smeralda', 'costa.smeralda@unibo.it', '31/01/1966', '15/05/1992', true, 'anestesista'),
	('CFM2', 'Giuseppino', 'Quercia', 'giuseppino.quercia@med.uniupo.it', '18/03/1970', '1/09/1996', true, 'rianimatore'),
	('CFM3', 'Guido', 'Piano', 'piano.guido@ospmaggiore.no.it', '18/08/1968', '8/1/1994', true, 'chirurgo'),
	('CFM4', 'Franco', 'Forte', 'forte.francomedical@bonvinimedicalservices.it', '31/10/1994', NULL, false, NULL),
	('CFM5', 'Gustavo', 'Nacrema', 'gustavo.nacrema@med.unicatt.it', '27/11/1992', NULL, false, NULL),
	('CFM6', 'Rosa', 'Foglio', 'rosa.foglio@med.unica.it', '19/02/1996', NULL, false, NULL);

INSERT INTO public.patologia(
	nome, attuale, tipo, descrizione, cfpaziente)
	VALUES ('gastroenterite batterica', true, 'enterobacter aerogenes', NULL, 'CF2'),
	('leucemia mieloide', false, 'leucemia', 'leucemia mieloide dovuta alla sovraesposizione a radiazioni ionizzanti di tipo gamma, sconsigliata esami strumentali che utilizzano radiazioni quali TC.', 'CF4'),
	('leucopenia con immunodepressione', true, 'leucopenia immunodepressa', 'leucopenia con immunodepressione successivo a trattamento chemioterapico da oxalilplatino', 'CF1');

INSERT INTO public.visita(
	risultati_eco, farmaci, peso, pressione_diastolica, pressione_sistolica, dolori_addominali, cfpaziente, cfmedico)
	VALUES (NULL, NULL, 80, 70, 115, false, 'CF4', 'CFM2'),
	(NULL, 'tachipirina 500mg, deltacortene 25mg', 80, 90, 140, true, 'CF1', 'CFM3'),
	(NULL, 'tachidol 500mg+30mg (codeina)', 100, 76, 119, true, 'CF2', 'CFM5'),
	(NULL, NULL, 96, 86, 125, false, 'CF3', 'CFM6'),
	(NULL, 'lobivon 5mg', 76, 60, 90, false, 'CF4', 'CFM4');

INSERT INTO public.ecografia(
	numerocalcoli, dimensioni, posizione, forma, id_visita)
	VALUES (2, 25, 'tra il dotto epatico e il dotto cistico, occlude parzialmente in modo trasversale', NULL, 2),
	(8, 15, 'collacoto tra il dotto pancreatico e il dotto cistico', 'sferica', 1),
	(1, 35, 'dotto cistico occluso in modo completo', 'cubica', 5);

INSERT INTO public.intervento(
	tipo, complicazioni, cfpaziente)
	VALUES ('litotrissia', NULL, 'CF4'),
	('tradizionale', 'guarigione prolungata', 'CF1'),
	('litotrissia', NULL, 'CF2'),
	('tradizionale', 'defibrillazione ventricolare', 'CF4'),
	('litotrissia', NULL, 'CF5'),
	('litotrissia', NULL, 'CF6'),
	('tradizionale', 'emorragia interna, decesso', 'CF4');

INSERT INTO public.compiere(
	id_intervento, cfmedico, primo)
	VALUES (1, 'CFM1', true),
	(2, 'CFM1', true),
	(2, 'CFM2', true),
	(2, 'CFM3', true),
	(3, 'CFM2', true),
	(4, 'CFM1', false),
	(4, 'CFM2', false),
	(4, 'CFM3', false),
	(5, 'CFM4', true),
	(6, 'CFM5', true),
	(7, 'CFM2', false),
	(7, 'CFM3', false);

INSERT INTO public.ricovero(
	datainizio, datafine, drg, tipo, cfpaziente)
	VALUES ('19/5/2000', '19/5/2000', 751.00, 'day-hospital', 'CF4'),
	('15/04/2008', '1/5/2008', 751.00, 'degenza', 'CF1'),
	('8/07/2009', '8/07/2009', 751.00, 'day-hospital', 'CF2'),
	('10/08/2010', '11/08/2010', 751.00, 'degenza', 'CF4'),
	('15/3/2011', '15/3/2011', 751.00, 'day-hospital', 'CF5'),
	('19/5/2011', '20/5/2011', 751.00, 'degenza', 'CF4');