
/* Crea la tabella del Venditore */

CREATE TABLE Venditore(
Matricola int (5) PRIMARY KEY,
CodiceFiscale char (16) DEFAULT NULL,
Nome varchar (20),
Cognome varchar (20),
e_mail varchar (20),
NumeroTelefonico char (13),
Indirizzo varchar (80));

/* Crea la tabella del Paese */

CREATE TABLE Paese (
Nome varchar (40) PRIMARY KEY,
NomeSede varchar (20) NOT NULL,
Indirizzosede varchar (80));

/* Crea la tabella del Assegnazione */

CREATE TABLE Assegnazione (
Venditore int (5) REFERENCES Venditore (Matricola) ON DELETE CASCADE ON UPDATE CASCADE,
Cliente int (6) REFERENCES Azienda (CodiceAzienda) ON DELETE CASCADE ON UPDATE CASCADE,
NomePaese varchar (40) REFERENCES Paese (Nome) ON DELETE CASCADE ON UPDATE CASCADE,
PRIMARY KEY (Venditore, Cliente, NomePaese));

/* Crea la tabella del Cliente */

CREATE TABLE Azienda (
CodiceAzienda int (6) PRIMARY KEY,
Nome varchar (20),
e_mail varchar (40),
Numerotelefonico char (13),
Indirizzosede varchar (80) );

/* Crea la tabella della Dipendenza*/

CREATE TABLE Dipendenza (
Manifattura int (6) PRIMARY KEY REFERENCES Azienda(CodiceAzienda) ON DELETE CASCADE ON UPDATE CASCADE,
Cliente int (6) NOT NULL REFERENCES Azienda(CodiceAzienda) ON DELETE CASCADE ON UPDATE CASCADE);

/* Crea la tabella del Ordine */

CREATE TABLE Ordine (
IDordine char (9) PRIMARY KEY,
Prodotto char (10) NOT NULL REFERENCES Prodotto (Codice) ON DELETE SET NULL ON UPDATE CASCADE,
Cliente int (6) NOT NULL REFERENCES Azienda (CodiceAzienda) ON DELETE SET NULL ON UPDATE CASCADE,
Venditore int (5) NOT NULL REFERENCES Venditore (Matricola) ON DELETE SET NULL ON UPDATE CASCADE,
Quantità integer (6) NOT NULL,
Completato boolean NOT NULL DEFAULT 0,
DataOrdine date NOT NULL);

/* Crea la tabella del Prodotto */

CREATE TABLE Prodotto (
Codice char (10) PRIMARY KEY,
Nome varchar (20),
Prezzo numeric (5,2));

/* Crea la tabella del Spedizione */

CREATE TABLE Spedizione (
IDspedizione char (10) PRIMARY KEY,
Ordine char (9) NOT NULL REFERENCES Ordine (IDordine) ON DELETE CASCADE ON UPDATE CASCADE,
Manifattura int (6) NOT NULL REFERENCES Dipedenza (Manifattura) ON DELETE SET NULL ON UPDATE CASCADE,
Quantità integer (6),
Aziendatrasporti varchar (20),
Datainvio date,
Dataeffettiva date,
Dataconsegna date DEFAULT NULL);

/* Popolamento Venditore */
insert into Venditore values(12345, "BRGGNN2132EY783K", "Giovanni", "Bergo", "giovanni.bergo@icloud.com", 0426664892, "Via Zanini");
insert into Venditore values(12346, "RSSNDR97L210F", "Andrea", "Rossi", "reds@alice.it", 34604129754, "Via Giuseppe Verdi");
insert into Venditore values(12347, "FRNVTL91C04G273B", "Francesco", "Vitale", "frensis@gmail.com", 3407869573, "Via Vittorio Emanuele");
insert into Venditore values(12348, "RDRBLN86M50Z600X", "Belén", "Rodriguez", "belen.official@gmail.com", 330699069, "Via Santa Marta");
insert into Venditore values(12349, "DLPLSN78R15G224W", "Alessandro", "Del Piero", "adp10@gmail.com", 346678699, "Via Cesare Battisti");
insert into Venditore values(12350, "VRICST72A20C351M", "Cristian", "Vieri", "bobo@gmail.com", 349029075, "Via Roma");
insert into Venditore values(12369, "BCCCST84C50H573E", "Cristina", "Buccino", "cribuccino@gmail.com", 347543290, "Via Buccino");
insert into Venditore values(12390, "GMZSRN80H45Z604J", "Esperanza", "Gomez", "gommezreal@gmail.com", 333542111, "Via Salvo d'Acquisto");
insert into Venditore values(12399, "NDRPML79D70Z401U", "Pamela", "Anderson", "pami@yahoo.com", 33943791, "Rue Saint Louis");
insert into Venditore values(12400, "NSTCHR97M59F839A", "Chiara", "Nasti", "nasty@gmail.com", 3409297443, "Via Capone");



/* Popolamento Paese */
insert into Paese  values("Rovigo", "Gore-tex IT", "Via Silvestri");
insert into Paese  values("Torino", "Gore-tex IT", "Via Silvestri");
insert into Paese  values("Madrid", "Gore-tex SP", "Calle Mayor");
insert into Paese  values("Buenos Aires", "Gore-tex AG", "Av. Sermiento");
insert into Paese  values("Amsterdam", "Gore-tex AM", "Nieuwebrugsteeg");
insert into Paese  values("Medelin", "Gore-tex CB", "Av. Maracaibo");
insert into Paese  values("Milano", "Gore-tex IT", "Via Silvestri");
insert into Paese  values("Londra", "Gore-tex UK", "Cranbourn St");
insert into Paese  values("Stati Uniti", "Gore-tex USA", "Connecticut Ave NW");
insert into Paese  values("Russia", "Gore-tex RUS", "Tverskaya ul.");
insert into Paese  values("Cagliari", "Gore-tex IT", "Via Silvestri");



/* Popolamento Assegnazione */
insert into Assegnazione values("Rovigo", 12345, 123456);
insert into Assegnazione values("Torino", 12346, 110001);
insert into Assegnazione values("Madrid", 12347, 110002);
insert into Assegnazione values("Buenos Aires", 12348, 110003);
insert into Assegnazione values("Amsterdam", 12349, 110004);
insert into Assegnazione values("Medelin", 12350, 110005);
insert into Assegnazione values("Milano", 12369, 110006);
insert into Assegnazione values("Londra", 12390, 110007);
insert into Assegnazione values("Stati Uniti", 12399, 110008);
insert into Assegnazione values("Russia", 12400, 110009);
insert into Assegnazione values("Cagliari", 12345, 110010);


/* Popolamento Azienda */
insert into Azienda values (123456, "Geox", "geox@gmail.com", 0495840515, "Corso del Popolo");
insert into Azienda values (110001, "K-WAY", "k_way@gmail.com", 0112617464, "Via Luigi Cibrario");
insert into Azienda values (110002, "Eastpak", "eastpak@gmail.com", 1312617993, "Santa Maria");
insert into Azienda values (110003, "Diesel", "diesel@alice.it", 88820984, "Av. Colon");
insert into Azienda values (110004, "Versace AM", "versace@yahoo.com", 091203912, "Oudezijds Achterburgwal");
insert into Azienda values (110005, "Cycle Columbia", "cycle@gmail.com", 95401663942, "Carrera 4");
insert into Azienda values (110006, "Armani", "armani@gmail.com", 042669942, "Piazza del Duomo");
insert into Azienda values (110007, "Calvin Klein", "ckmail@gmail.com", 467968904, "Camden Rd");
insert into Azienda values (110008, "Abercrombie & Fitch", "abercrombie@gmail.com", 039844832, "Pine Tree Dr");
insert into Azienda values (110009, "Nike", "nike@gmail.com", 349889532, "Bolotnaya Square");
insert into Azienda values (110010, "Adidas", "adidasoriginal@gmail.com", 01238747, "An der Oberrothe");


/* Popolamento Dipendenza */
insert into Dipendenza values (123456, 123456);
insert into Dipendenza values (110011, 110001);
insert into Dipendenza values (110002, 110002);
insert into Dipendenza values (220011, 110003);
insert into Dipendenza values (110004, 110004);
insert into Dipendenza values (330005, 110005);
insert into Dipendenza values (440006, 110006);
insert into Dipendenza values (110007, 110007);
insert into Dipendenza values (110008, 110008);
insert into Dipendenza values (550009, 110009);
insert into Dipendenza values (660010, 110010);


/* Popolamento Ordine */
insert into Ordine values ("ABC001ARV", "AAABBB1001", 123456, 12345, 1000, 1, "2015-03-24");
insert into Ordine values ("ABC002ATO", "AAABBB1002", 110001, 12346, 5000, 0, "2017-02-04");
insert into Ordine values ("ABC003ASP", "AAABBB1003", 110002, 12347, 2000, 1, "2013-07-10");
insert into Ordine values ("ABC004ARG", "AAABBB1004", 110003, 12348, 10000, 1, "2017-01-03");
insert into Ordine values ("ABC005AMS", "AAABBB1005", 110004, 12349, 30000, 0, "2017-01-05");
insert into Ordine values ("ABC006COL", "AAABBB1006", 110005, 12350, 800000, 1, "2014-10-20");
insert into Ordine values ("ABC007MIL", "AAABBB1007", 110006, 12369, 25000, 0, "2017-02-01");
insert into Ordine values ("ABC008UKK", "AAABBB1008", 110007, 12390, 4000, 1, "2013-07-10");
insert into Ordine values ("ABC009USA", "AAABBB1009", 110008, 12399, 35000, 0, "2016-12-20");
insert into Ordine values ("ABC010RUS", "AAABBB1001", 110009, 12400, 6000, 1, "2014-09-01");
insert into Ordine values ("ABC011CGI", "AAABBB1002", 110010, 12345, 9000, 1, "2015-09-05");


/* Popolamento Prodotto */
insert into Prodotto values ("AAABBB1001", "Maglieria", 10.00);
insert into Prodotto values ("AAABBB1002", "K-WAY", 25.00);
insert into Prodotto values ("AAABBB1003", "Accessori", 8.50);
insert into Prodotto values ("AAABBB1004", "Maglieria", 30.00);
insert into Prodotto values ("AAABBB1005", "Pantaloni", 150.00);
insert into Prodotto values ("AAABBB1006", "Giacche", 100.00);
insert into Prodotto values ("AAABBB1007", "Calzature", 100.00);
insert into Prodotto values ("AAABBB1008", "Accessori", 10.00);
insert into Prodotto values ("AAABBB1009", "Giacche", 100.00);
insert into Prodotto values ("AAABBB1001", "Guanti", 10.00);
insert into Prodotto values ("AAABBB1002", "Pantaloni", 150.00);


/* Popolamento Spedizione */
insert into Spedizione values ("AXZA3KLZP1", "ABC001ARV", 123456, 1000, "Bartolini", "2015-03-26", "2015-03-26", "2015-04-01");
insert into Spedizione values ("JHGQ901XAD", "ABC002ATO", 110011, 5000, "Bartolini", "2014-02-06", "NULL", "NULL");
insert into Spedizione values ("AR0IMLWG8A", "ABC003ASP", 110002, 2000, "Bartolini", "2013-07-15", "2013-07-20", "2013-07-23");
insert into Spedizione values ("D7QPNMEO0E", "ABC004ARG", 220011, 10000, "GSM", "2017-01-05", "2017-01-05", "2017-01-20");
insert into Spedizione values ("2FU8XQ4U79", "ABC005AMS", 110004, 30000, "Italsempione", "2017-01-29", "2013-02-04", "NULL");
insert into Spedizione values ("24JEC7DZUU", "ABC006COL", 330005, 800000, "DHL", "2014-10-29", "2014-10-29", "2014-11-29");
insert into Spedizione values ("XBJXIPWLMY", "ABC007MIL", 440006, 25000, "Delta Srl", "NULL", "NULL", "NULL");
insert into Spedizione values ("40QOPEVU1J", "ABC008UKK", 110007, 4000, "BCE s.r.l.", "2013-07-11", "2013-07-12", "2013-07-20");
insert into Spedizione values ("Z1MWNBYNCH", "ABC009USA", 110008, 35000, "Eaams Srl", "2017-01-05", "2017-01-25", "NULL");
insert into Spedizione values ("HOLCXD4JRB", "ABC010RUS", 550009, 6000, "Vega Srl", "2014-09-02", "2014-09-02", "2014-09-20");
insert into Spedizione values ("WRF7DUKZTX", "ABC011CGI", 660010, 9000, "UPS", "2015-09-06", "2015-09-06", "2015-09-15");







