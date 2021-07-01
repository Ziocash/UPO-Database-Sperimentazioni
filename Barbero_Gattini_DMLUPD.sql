-- Aggiornamento di un ricovero

UPDATE public.ricovero
	SET datafine='12/02/2020'
	WHERE cfpaziente = 'CF4' AND datainizio = '19/05/2011';

-- Aggiornamento mail medico

UPDATE public.medico
	SET email='prova@exaple.com'
	WHERE codicefiscale = 'CFM1';

-- Cambio stato civile

UPDATE public.paziente
	SET statocivile='sposato'
	WHERE codicefiscale = 'CF1';

-- Aggiornamento patologia non più attuale

UPDATE public.patologia
	SET attuale=false
	WHERE cfpaziente = 'CF1';