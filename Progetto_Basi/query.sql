
/*--------------------------------------------------------------------------------------------------------------------------------
FUNZIONI
--------------------------------------------------------------------------------------------------------------------------------*/

/* Funzione che restituisce la data di un anno prima della data corrente*/
delimiter $$
create function UltimoAnno()
returns date
begin
declare DataAnno date;
declare Temp_date date;
	set Temp_date='0001-00-00';
	set DataAnno=current_date-Temp_date;
return DataAnno;
end; $$

/* Funzione che determina il valore totale di un ordine, moltiplicando la quantità del prodotto ordinato per il suo prezzo*/

create function ValoreOrdine (CodiceOrdine char(9))
returns decimal(10,2) deterministic
begin
declare Valore decimal(10,2);
	(select Quantità*Prezzo into Valore
	from Ordine O join Prodotto P on O.Prodotto=P.Codice
	where O.IDordine=CodiceOrdine);
return Valore;
end; $$

delimiter ;

/*-------------------------------------------------------------------------------------------------------------------------------
QUERY
-------------------------------------------------------------------------------------------------------------------------------*/
/*Query 1, procedura che assegna un cliente a un venditore e, nel caso questi sia mancante nella lista clienti, provvede ad aggiungerlo*/
delimiter $$
create procedure AssegnaCliente(Vend int (5), Cl int (6), Paese varchar (40))
begin
	if Cl<>any(select CodiceAzienda from Azienda)
	then insert into Azienda(CodiceAzienda)
	values (Cl);
	end if;
	if (Paese=any(select Nome from Paese) and Vend=any(select Matricola from Venditore))
	then insert into Assegnazione
	values (Paese, Vend, Cl);
	end if;
end; $$
delimiter ;

/*Query 2, procedura che effettua un nuovo ordine*/
delimiter $$
create procedure CreaOrdine(ID char (9), Prod char (10), Cl int (6), Vend int (5), Quant integer (6))
begin
	insert into Ordine(IDordine, Prodotto, Cliente, Venditore, Quantità)
	values (ID, Prod, Cl, Vend, Quant);
	update Ordine
	set DataOrdine=current_date
	where IDordine=ID;
end; $$
delimiter ;

/*Query 3, che mostra le vendite dei venditori per paese e quantità totale nell'ultimo anno.
	Utilizza una vista che seleziona gli ordini in base al paese del cliente e al venditore*/
create view OrdiniPaese as
select P.NomePaese as Paese, O.IDordine, O.Quantità,
	O.DataOrdine as DataOrd, O.Venditore, ValoreOrdine(IDordine) as Valore
from Assegnazione P, Ordine O
where P.Cliente=O.Cliente;

select O.Venditore as Matricola, Paese, sum(Quantità) as TotaleUltimoAnno, sum(Valore) as Valore
from OrdiniPaese O join Assegnazione on Paese=NomePaese
where (UltimoAnno()<DataOrd<current_date)
group by O.Venditore, Paese
order by O.Venditore;

/*Query 4, procedure che di un cliente trova le sue manifatture e la somma della quantità di merce spedita per manifattura nell'ultimo anno*/
delimiter $$
create procedure ManifattureCliente (Cl int (6))
begin
	select D.Manifattura, sum(S.Quantità) as Quantità_Totale
	from  Dipendenza D, Spedizione S
	where Cliente=Cl and UltimoAnno()<Datainvio<current_date;
end; $$
delimiter ;

/*Query 5, trovare la media di vendite dei vari prodotti nell'ultimo anno, con ordinamento decrescente*/
select Prodotto, avg(Quantità) as Quantità_Media
from Ordine 
where UltimoAnno()<DataOrdine<current_date
group by Prodotto
order by Quantità_Media desc; 

/* Query 6, degli ordini non completati, vedere le date previste di completamento*/
select IDordine, max(Datainvio) as Data_Prevista
from Ordine, Spedizione
where Completato=0 and IDordine=Ordine
group by Ordine;

/*Query 7, trova il fatturato della azienda negli ultimi 12 mesi.*/
select sum(ValoreOrdine(IDordine)) as Fatturato
from Ordine
where UltimoAnno()<DataOrdine<current_date;




/*----------------------------------------------------------------------------------------------------------------
TRIGGER
----------------------------------------------------------------------------------------------------------------*/
/* Trigger che aggiorna lo stato di completamento di un ordine quando tutte le spedizioni sono state completate 
(ossia che hanno il campo Dataconsegna non nullo) */
delimiter $$
create trigger AggiornaOrdine
after update on Spedizione
	for each row
begin 
	if (null<> all(select Dataconsegna from Spedizione where Ordine=new.Ordine))
	then update Ordine
	set Completato=1
	where IDordine=(select distinct Ordine from Spedizione where Ordine=new.Ordine);
	end if;
end; $$
delimiter ;


/*Serie di trigger che impediscono l'immissione di valori negativi per prezzi e quantità:*/

/*Trigger Prezzo Negativo */
DELIMITER $$
create trigger I_PrezzoNeg
before insert on Prodotto
	for each row
begin
	if (new.Prezzo < 0)
	then set new.Prezzo=NULL;
	end if;
end;$$

DELIMITER $$
create trigger U_PrezzoNeg
before update on Prodotto
	for each row
begin
	if (new.Prezzo < 0)
	then set new.Prezzo=old.Prezzo;
	end if;
end;$$

/*Trigger Quantità Negativa*/
DELIMITER $$
create trigger I_QuantitàNeg
before insert on Ordine
	for each row
begin
	if (new.Quantità < 0)
	then set new.Quantità=0;
    end if;
end;$$ 

DELIMITER $$
create trigger U_QuantitàNeg
before update on Ordine
	for each row
begin
	if (new.Quantità < 0)
	then set new.Quantità=old.Quantità;
    end if;
end;$$

DELIMITER $$
create trigger I_QuantitàNeg_S
before insert on Spedizione
	for each row
begin
	if (new.Quantità < 0)
	then set new.Quantità=0;
    end if;
end;$$

DELIMITER $$
create trigger U_QuantitàNeg_S
before update on Spedizione
	for each row
begin
	if (new.Quantità < 0)
	then set new.Quantità=old.Quantità;
    end if;
end;$$

delimiter ;





