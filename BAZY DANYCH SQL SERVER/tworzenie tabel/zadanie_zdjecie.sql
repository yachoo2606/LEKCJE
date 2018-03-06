create database Muzyka

use Muzyka

create table PANSTWA
(
	Id_Panstwa varchar(3)primary key
	check(Id_Panstwa not like'[0-9][0-9][0-9]'),
	Nazwa varchar(20) not null,
)
drop table PANSTWA

insert into PANSTWA
values ('PL','Polska'),
 ('USA','Stany Zjednoczone'),
 ('IR','Irlandia'),
 ('FR','Francja'),
 ('GB','Wielka Brytania')

select* from PANSTWA

create table Wykonawcy
(
	Id_wykonawcy varchar(3) primary key
		check(Id_wykonawcy like'[A-Z][0-9][0-9]'),
	Nazwisko varchar(25),
	Imie varchar(10),
	Pseudonim varchar(10),
	Pochodzenie varchar(3) not null FOREIGN KEY REFERENCES PANSTWA(Id_Panstwa) ON UPDATE CASCADE,
)

insert into Wykonawcy
values 
('W01',null,null,'U2','IR'),
('W02','Kasia','Kowalska',null,'Pl'),
('W03','Davis','Miles',null,'USA')

select* from Wykonawcy

create table Muzyka_Rodzaje
(
	Id_Rodzaju varchar(3) primary key,
	Rodzaj varchar(10) not null,
)
insert into Muzyka_Rodzaje
values
('J','Jazz'),
('R','Rock'),
('P','Pop')

create table Plyty 
(
	Id_plyty varchar(5) primary key
		check(Id_plyty like '[A-Z][0-9][0-9][0-9][0-9]'),
	Tytul varchar(35) not null,
	Rok int
		check (Rok>1950),
	Id_Rodzaju varchar(3) not null FOREIGN KEY REFERENCES Muzyka_Rodzaje(Id_Rodzaju),
)

insert into Plyty
values 
('P0001','Seven steps to heaven',1963,'J'),
('P0002','Love songs',1999,'J'),
('P0003','Achtung Baby',null,'R')

select* from Plyty

create table Plyty_Wykonawcy
(
	Id_plyty varchar(5)  foreign key REFERENCES Plyty(Id_plyty)
		check(Id_plyty like '[A-Z][0-9][0-9][0-9][0-9]'),
	Id_wykonawcy varchar(3)  foreign key REFERENCES Wykonawcy(Id_wykonawcy)
		check(Id_wykonawcy like '[A-Z][0-9][0-9]'),
	CONSTRAINT PK PRIMARY KEY (Id_plyty,Id_wykonawcy),
)
insert into Wykonawcy
values
('W04','Fitzgerald','Ella',null,'USA'),
('W05','Louis','Armstrong',null,'USA')

insert into Plyty
values
('P0004','Ella i Louis Again',2003,'J')

insert into Plyty_Wykonawcy
values 
('P0004','W04'),
('P0004','W05')

alter table Wykonawcy
	add KTO char 
		check(KTO like '[K,M,Z]')

		select* from Wykonawcy


update Wykonawcy
set KTO='Z'
where imie is null

update Wykonawcy
set KTO='K'
where imie like '%a'

update Wykonawcy
set KTO='M'
where imie not like '%a'

alter table Plyty
add Cena money check (Cena>0)

select* from Plyty