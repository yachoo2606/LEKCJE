CREATE DATABASE Zadania_123

use Zadania_123

/*zadanie 1*/

create table DZIALY
(
	KOD_DZIALU varchar(3) primary key,
	NAZWA_DZIALU varchar(30) NOT NULL unique,
)

select* from DZIALY
/*zadanie 2*/

ALTER TABLE DZIALY
ADD CONSTRAINT NAZWA_DZIALU CHECK(NAZWA_DZIALU!='%[0,9]%')

/*Zadanie 3*/

create table PRACOWNICY
(
	NUMER int unique identity(1,1),
	NAZWISKO VARCHAR NOT NULL,
	IMIE VARCHAR NOT NULL,
	PLEC VARCHAR(1)
		CHECK (PLEC='K' OR PLEC='M'),
	[DATA URODZENIA] DATETIME,
	[DATA ZATRUDNIENIA] DATETIME,
	DZIAL VARCHAR(3) FOREIGN KEY REFERENCES DZIALY(KOD_DZIALU),
	SZEF INT FOREIGN KEY REFERENCES PRACOWNICY(NUMER)
)