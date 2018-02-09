use Northwind
--Æwiczenia do bazy: NorthWind
--Æw.1	Wypisz imiona i nazwiska wszystkich pracowników.
select FirstName, LastName
from Employees

--Æw.2	Wypisz imiona i nazwiska wszystkich pracowników, któych nazwiska zaczynaj¹ siê na litere D.
select FirstName, LastName
from Employees
where LastName Like 'D%'
--Æw.3	Wypisz imiona, nazwiska oraz dok³adne adresy wszystkich pracowników zatrudnionych w Stanach Zjednoczonych.
--Æw.4	W tabeli wynikowej z  æw.3 kolumny powinny mieæ  polskie nazwy (aliasy).
select FirstName as Imiê, LastName as Nazwisko, Address as Adres
from Employees
where Country like 'USA'

--Æw.5	Wypisz nazwiska, imiona oraz stanowiska pracowników.
select LastName, FirstName, Title
from Employees
--Æw.6	Wypisz nazwiska, imiona osób zatrudnionych na stanowisku "Sales Representative".
select LastName, FirstName, title
from Employees
where Title like 'Sales Representative'
--Æw.7	Wypisz dane tych pracowników, którzy nie maj¹ przypisanego szefa.
select *
from Employees
where ReportsTo is null
--Æw.8	Wypisz nazwiska, imiona oraz rok urodzenia pracowników.
--Dane posortuj wed³ug roku urodzenia.
select LastName, FirstName, YEAR(BirthDate) 
from Employees
order by YEAR(BirthDate) --desc asc domyœlnie
--Æw.9	Wypisz nazwiska, imiona oraz wiek  pracowników. 
--Dane posortuj wed³ug wieku, tak by osoby najstarsze by³y wypisane jako pierwsze,
--nastêpnym kryterium sortowania powinno byæ nazwisko.
select LastName,FirstName, (YEAR(GETDATE())-YEAR(BirthDate)) as 'wiek'
from Employees
order by wiek desc, LastName
--Æw.10	Wypisz nazwiska, imiona oraz iloœæ przepracowanych lat, 
--pracowników najd³u¿ej zatrudnionych, w firmie NothWind.
select top(1) with ties LastName,FirstName,(YEAR(GETDATE())-YEAR(HireDate)) as 'Iloœæ przepracowanych lat'
from Employees
order by (YEAR(GETDATE())-YEAR(HireDate)) desc
--Æw.11	Wypisz  nazwiska pracowników pochodz¹cych z Seattle i nazwiska osób pochodz¹cych 
--z Redmond.
select LastName, City
from Employees
where City like 'Seattle' or city like 'Redmond'
--Æw.12	Wypisz  nazwiska pracowników o identyfikatorach: 2,6,7,9.
select LastName
from Employees
where EmployeeID in ('2','6','7','9')
--Æw.13	Wypisz  nazwiska pracowników o identyfikatorach miêdzy 2 i 8.
select  LastName
from Employees
where EmployeeID between '2' and '8'
--Æw.14	Wypisz wszystkie dane dostawców z Niemiec i z Japonii
select *
from Suppliers
where Country like 'Japan' or Country like 'germany'
--Æw.15	Wypisz nazwy i adresy dostawców – spó³ek z ograniczona odpowiedzialnoœci¹ (Ldt).
Select *
from Suppliers
where CompanyName like '%Ltd%'
--Æw.16	Wypisz dane (Nazwy, Jednostki w jakich s¹ sprzedawane oraz ceny) tych produktów, 
--które w nazwie maj¹ s³owo „Camembert” .
select ProductName,UnitsOnOrder,UnitPrice
from Products
where ProductName like '%Camembert%'
--Æw.17	Wypisz dane (Nazwy, Jednostki w jakich s¹ sprzedawane oraz ceny) tych produktów,
--które  sprzedawane s¹ w s³oikach lub w butelkach (bottles, jars). Dane posortuj wed³ug ceny, 
--tak by najdro¿sze wyœwietlone by³y jako pierwsze.
select ProductName,UnitsOnOrder,UnitPrice
from Products
where QuantityPerUnit like '%bottles%' or QuantityPerUnit like '%jars%'
order by UnitPrice desc
--Æw.18	Wypisz dane (nazwy, jednostki w jakich s¹ sprzedawane oraz ceny) tych produktów, 
--których cena jest miêdzy 10 a 20 (³¹cznie z cenami:10 i 20).
select ProductName,UnitsOnOrder,UnitPrice
from Products
where UnitPrice between 10 and 20
--Æw.19	Wypisz dane (nazwy, jednostki w jakich s¹ sprzedawane oraz ceny) tych produktów, 
--których nazwy zaczynaj¹ siê na jedn¹ z liter: C, K i P oraz sprzedawane s¹ w paczkach.
select ProductName,UnitsOnOrder,UnitPrice
from Products
where ProductName like '[CKP]%' and QuantityPerUnit like '%box%'
--where ProductName like 'C%' or ProductName like 'k%' or ProductName like 'p%' and QuantityPerUnit like '%boxes%'

--Æw.20	Wypisz wszystkie dane tych produktów, których nazwy nie zaczynaj¹ sie na 
--¿adn¹ z liter: A, G, N i S oraz ich cena jest z przedzia³u zamknietego <15;20>. 
--Dane posortuj wed³ug cen, tak by jako pierwsze by³y  najdro¿sze podukty.
select *
from Products
where UnitPrice between 15 and 20 and ProductName not like '[AGNS]%'
order by UnitPrice desc
--Æw.21	Wypisz nazwy i ceny jednostkowe tych produktów, których nazwa jest czteroliterowa.
select ProductName, UnitPrice
from Products
where ProductName like '____'

select ProductName, UnitPrice
from Products
where len(ProductName)=4