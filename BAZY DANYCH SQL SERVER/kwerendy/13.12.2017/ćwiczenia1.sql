use Northwind
--�wiczenia do bazy: NorthWind
--�w.1	Wypisz imiona i nazwiska wszystkich pracownik�w.
select FirstName, LastName
from Employees

--�w.2	Wypisz imiona i nazwiska wszystkich pracownik�w, kt�ych nazwiska zaczynaj� si� na litere D.
select FirstName, LastName
from Employees
where LastName Like 'D%'
--�w.3	Wypisz imiona, nazwiska oraz dok�adne adresy wszystkich pracownik�w zatrudnionych w Stanach Zjednoczonych.
--�w.4	W tabeli wynikowej z  �w.3 kolumny powinny mie�  polskie nazwy (aliasy).
select FirstName as Imi�, LastName as Nazwisko, Address as Adres
from Employees
where Country like 'USA'

--�w.5	Wypisz nazwiska, imiona oraz stanowiska pracownik�w.
select LastName, FirstName, Title
from Employees
--�w.6	Wypisz nazwiska, imiona os�b zatrudnionych na stanowisku "Sales Representative".
select LastName, FirstName, title
from Employees
where Title like 'Sales Representative'
--�w.7	Wypisz dane tych pracownik�w, kt�rzy nie maj� przypisanego szefa.
select *
from Employees
where ReportsTo is null
--�w.8	Wypisz nazwiska, imiona oraz rok urodzenia pracownik�w.
--Dane posortuj wed�ug roku urodzenia.
select LastName, FirstName, YEAR(BirthDate) 
from Employees
order by YEAR(BirthDate) --desc asc domy�lnie
--�w.9	Wypisz nazwiska, imiona oraz wiek  pracownik�w. 
--Dane posortuj wed�ug wieku, tak by osoby najstarsze by�y wypisane jako pierwsze,
--nast�pnym kryterium sortowania powinno by� nazwisko.
select LastName,FirstName, (YEAR(GETDATE())-YEAR(BirthDate)) as 'wiek'
from Employees
order by wiek desc, LastName
--�w.10	Wypisz nazwiska, imiona oraz ilo�� przepracowanych lat, 
--pracownik�w najd�u�ej zatrudnionych, w firmie NothWind.
select top(1) with ties LastName,FirstName,(YEAR(GETDATE())-YEAR(HireDate)) as 'Ilo�� przepracowanych lat'
from Employees
order by (YEAR(GETDATE())-YEAR(HireDate)) desc
--�w.11	Wypisz  nazwiska pracownik�w pochodz�cych z Seattle i nazwiska os�b pochodz�cych 
--z Redmond.
select LastName, City
from Employees
where City like 'Seattle' or city like 'Redmond'
--�w.12	Wypisz  nazwiska pracownik�w o identyfikatorach: 2,6,7,9.
select LastName
from Employees
where EmployeeID in ('2','6','7','9')
--�w.13	Wypisz  nazwiska pracownik�w o identyfikatorach mi�dzy 2 i 8.
select  LastName
from Employees
where EmployeeID between '2' and '8'
--�w.14	Wypisz wszystkie dane dostawc�w z Niemiec i z Japonii
select *
from Suppliers
where Country like 'Japan' or Country like 'germany'
--�w.15	Wypisz nazwy i adresy dostawc�w � sp�ek z ograniczona odpowiedzialno�ci� (Ldt).
Select *
from Suppliers
where CompanyName like '%Ltd%'
--�w.16	Wypisz dane (Nazwy, Jednostki w jakich s� sprzedawane oraz ceny) tych produkt�w, 
--kt�re w nazwie maj� s�owo �Camembert� .
select ProductName,UnitsOnOrder,UnitPrice
from Products
where ProductName like '%Camembert%'
--�w.17	Wypisz dane (Nazwy, Jednostki w jakich s� sprzedawane oraz ceny) tych produkt�w,
--kt�re  sprzedawane s� w s�oikach lub w butelkach (bottles, jars). Dane posortuj wed�ug ceny, 
--tak by najdro�sze wy�wietlone by�y jako pierwsze.
select ProductName,UnitsOnOrder,UnitPrice
from Products
where QuantityPerUnit like '%bottles%' or QuantityPerUnit like '%jars%'
order by UnitPrice desc
--�w.18	Wypisz dane (nazwy, jednostki w jakich s� sprzedawane oraz ceny) tych produkt�w, 
--kt�rych cena jest mi�dzy 10 a 20 (��cznie z cenami:10 i 20).
select ProductName,UnitsOnOrder,UnitPrice
from Products
where UnitPrice between 10 and 20
--�w.19	Wypisz dane (nazwy, jednostki w jakich s� sprzedawane oraz ceny) tych produkt�w, 
--kt�rych nazwy zaczynaj� si� na jedn� z liter: C, K i P oraz sprzedawane s� w paczkach.
select ProductName,UnitsOnOrder,UnitPrice
from Products
where ProductName like '[CKP]%' and QuantityPerUnit like '%box%'
--where ProductName like 'C%' or ProductName like 'k%' or ProductName like 'p%' and QuantityPerUnit like '%boxes%'

--�w.20	Wypisz wszystkie dane tych produkt�w, kt�rych nazwy nie zaczynaj� sie na 
--�adn� z liter: A, G, N i S oraz ich cena jest z przedzia�u zamknietego <15;20>. 
--Dane posortuj wed�ug cen, tak by jako pierwsze by�y  najdro�sze podukty.
select *
from Products
where UnitPrice between 15 and 20 and ProductName not like '[AGNS]%'
order by UnitPrice desc
--�w.21	Wypisz nazwy i ceny jednostkowe tych produkt�w, kt�rych nazwa jest czteroliterowa.
select ProductName, UnitPrice
from Products
where ProductName like '____'

select ProductName, UnitPrice
from Products
where len(ProductName)=4