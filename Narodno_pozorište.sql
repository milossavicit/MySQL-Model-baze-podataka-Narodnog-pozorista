/*==============================================================*/
/* DBMS name:      MySQL 5.0                                    */
/* Created on:     1/29/2017 11:09:10 PM                        */
/*==============================================================*/

CREATE DATABASE IF NOT EXISTS `Narodno_pozorište` DEFAULT CHARACTER SET utf8;
USE `Narodno_pozorište`;
drop table if exists KREDITNA_KARTICA;

/*==============================================================*/
/* Table: KREDITNA_KARTICA                                      */
/*==============================================================*/
create table KREDITNA_KARTICA
(
   BROJ                 int not null auto_increment,
   TIP                  varchar(45),
   DATUM_VAZENJA        date,
   primary key (BROJ)
);

/*==============================================================*/
/* Table: POZORISNI_KOMAD                                       */
/*==============================================================*/
create table POZORISNI_KOMAD
(
   ID_POZORISNOG_KOMADA int not null auto_increment,
   ID_TRUPE             int,
   ID_PRODUCENTA        int,
   NAZIV                varchar(50) not null,
   primary key (ID_POZORISNOG_KOMADA)
);

/*==============================================================*/
/* Index: INDEX_4                                               */
/*==============================================================*/
create unique index INDEX_4 on POZORISNI_KOMAD
(
   NAZIV
);

/*==============================================================*/
/* Table: PREDSTAVA                                             */
/*==============================================================*/
create table PREDSTAVA
(
   ID_PREDSTAVE         int not null auto_increment,
   ID_POZORISNOG_KOMADA int,
   DATUM_ODRZAVANJA     date,
   BROJ_RASPOLOZIVIH_MESTA varchar(100),
   CENA_ULAZNICE        varchar(10),
   primary key (ID_PREDSTAVE)
);

/*==============================================================*/
/* Table: PRETPLATNIK                                           */
/*==============================================================*/
create table PRETPLATNIK
(
   ID_PRETPLATNIKA      int not null auto_increment,
   BROJ                 int,
   ADRESA               varchar(50),
   TELEFON              varchar(45),
   primary key (ID_PRETPLATNIKA)
);

/*==============================================================*/
/* Table: PRODUCENT                                             */
/*==============================================================*/
create table PRODUCENT
(
   ID_PRODUCENTA        int not null auto_increment,
   IME                  varchar(45),
   PREZIME              varchar(45),
   primary key (ID_PRODUCENTA)
);

/*==============================================================*/
/* Table: REZERVACIJA                                           */
/*==============================================================*/
create table REZERVACIJA
(
   ID_REZERVACIJE       int not null auto_increment,
   ID_PREDSTAVE         int,
   ID_PRETPLATNIKA      int,
   DATUM_REZERVACIJE    date,
   UKUPNA_CENA          varchar(10),
   primary key (ID_REZERVACIJE)
);

/*==============================================================*/
/* Table: TRUPA                                                 */
/*==============================================================*/
create table TRUPA
(
   ID_TRUPE             int not null auto_increment,
   IMENA_GLUMACA        varchar(1024),
   primary key (ID_TRUPE)
);

alter table POZORISNI_KOMAD add constraint FK_RELATIONSHIP_5 foreign key (ID_TRUPE)
      references TRUPA (ID_TRUPE) on delete cascade on update cascade;

alter table POZORISNI_KOMAD add constraint FK_RELATIONSHIP_7 foreign key (ID_PRODUCENTA)
      references PRODUCENT (ID_PRODUCENTA) on delete cascade on update cascade;

alter table PREDSTAVA add constraint FK_ORGANIZUJE foreign key (ID_POZORISNOG_KOMADA)
      references POZORISNI_KOMAD (ID_POZORISNOG_KOMADA) on delete cascade on update cascade;

alter table PRETPLATNIK add constraint FK_REFERENCE_9 foreign key (BROJ)
      references KREDITNA_KARTICA (BROJ) on delete cascade on update cascade;

alter table REZERVACIJA add constraint FK_IMA2 foreign key (ID_PREDSTAVE)
      references PREDSTAVA (ID_PREDSTAVE) on delete cascade on update cascade;

alter table REZERVACIJA add constraint FK_PRAVI foreign key (ID_PRETPLATNIKA)
      references PRETPLATNIK (ID_PRETPLATNIKA) on delete cascade on update cascade;

#Unos podataka.

INSERT INTO `Narodno_pozorište`.`Kreditna_kartica` (Broj, Tip, Datum_vazenja) VALUES (123, "Visa", "2020-01-27");
INSERT INTO `Narodno_pozorište`.`Kreditna_kartica` (Broj, Tip, Datum_vazenja) VALUES (124, "Master", "2019-01-28");
INSERT INTO `Narodno_pozorište`.`Kreditna_kartica` (Broj, Tip, Datum_vazenja) VALUES (125, "Visa", "2018-01-28");
INSERT INTO `Narodno_pozorište`.`Pretplatnik` (Broj, Adresa, Telefon) VALUES (123, "Vojvode Mišića 3", 065234567);
INSERT INTO `Narodno_pozorište`.`Pretplatnik` (Broj, Adresa, Telefon) VALUES (124, "Mihajla Pupina 23", 065214867);
INSERT INTO `Narodno_pozorište`.`Pretplatnik` (Broj, Adresa, Telefon) VALUES (125, "Petra Kočića 11", 065244567);
INSERT INTO `Narodno_pozorište`.`Producent` (Ime, Prezime) VALUES ("Milena", "Bogovac");
INSERT INTO `Narodno_pozorište`.`Producent` (Ime, Prezime) VALUES ("Vanja", "Rikić");
INSERT INTO `Narodno_pozorište`.`Trupa` (Imena_glumaca) VALUES ("Jelena Marković, Slobodan Krstić, Ana Grujić");
INSERT INTO `Narodno_pozorište`.`Pozorisni_komad` (ID_Trupe, ID_Producenta, Naziv) VALUES (1, 1, "Koštana");
INSERT INTO `Narodno_pozorište`.`Pozorisni_komad` (ID_Trupe, ID_Producenta, Naziv) VALUES (1, 2, "SAD!");
INSERT INTO `Narodno_pozorište`.`Pozorisni_komad` (ID_Trupe, ID_Producenta, Naziv) VALUES (1, 1, "Sloboda.");
INSERT INTO `Narodno_pozorište`.`Predstava` (ID_Pozorisnog_komada, Datum_odrzavanja, Broj_raspolozivih_mesta, Cena_ulaznice) VALUES (1, "2017-01-28", "0", "200");
INSERT INTO `Narodno_pozorište`.`Predstava` (ID_Pozorisnog_komada, Datum_odrzavanja, Broj_raspolozivih_mesta, Cena_ulaznice) VALUES (2, "2017-01-29", "50", "230");
INSERT INTO `Narodno_pozorište`.`Predstava` (ID_Pozorisnog_komada, Datum_odrzavanja, Broj_raspolozivih_mesta, Cena_ulaznice) VALUES (3, "2017-01-30", "50", "200");
INSERT INTO `Narodno_pozorište`.`Rezervacija` (ID_Predstave, ID_Pretplatnika, Datum_rezervacije, Ukupna_cena) VALUES (1, 1, "2017-01-25", "200");
INSERT INTO `Narodno_pozorište`.`Rezervacija` (ID_Predstave, ID_Pretplatnika, Datum_rezervacije, Ukupna_cena) VALUES (2, 2, "2017-01-24", "230");
INSERT INTO `Narodno_pozorište`.`Rezervacija` (ID_Predstave, ID_Pretplatnika, Datum_rezervacije, Ukupna_cena) VALUES (1, 3, "2017-01-24", "200");
INSERT INTO `Narodno_pozorište`.`Rezervacija` (ID_Predstave, ID_Pretplatnika, Datum_rezervacije, Ukupna_cena) VALUES (2, 2, "2017-01-23", "230");

CREATE VIEW `narodno_pozorište`.`potrosennovacpretplatnika`  AS  select `narodno_pozorište`.`pretplatnik`.`ID_PRETPLATNIKA` AS `ID_Pretplatnika`,sum(`narodno_pozorište`.`rezervacija`.`UKUPNA_CENA`) AS `Ukupna_cena`,`narodno_pozorište`.`pretplatnik`.`BROJ` AS `Broj` from (`narodno_pozorište`.`pretplatnik` join `narodno_pozorište`.`rezervacija`) where (`narodno_pozorište`.`pretplatnik`.`ID_PRETPLATNIKA` = `narodno_pozorište`.`rezervacija`.`ID_PRETPLATNIKA`) group by `narodno_pozorište`.`pretplatnik`.`ID_PRETPLATNIKA` ;