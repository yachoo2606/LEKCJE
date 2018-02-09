use Northwind

--�wiczenia do bazy: NorthWind � grupowanie 
--�w.1	Oblicz �redni� cen� wszystkich produkt�w.

select avg(Products.UnitPrice) as '�rednia cena wszystkich produkt�w'
from Products

--�w.2	Jaka ��czna ilo�� produkt�w zosta�a zam�wiona?

select SUM([Order Details].Quantity) as 'Suma zam�wionych produkt�w'
from [Order Details]

--�w.3	Ilu jest pracownik�w?

select COUNT(Employees.EmployeeID) as 'Ilosc pracownik�w'
from Employees

--�w.4	Ilu jest pracownik�w, kt�rzy maj� szefa?

select count(Employees.EmployeeID) as 'Ilo�� pracownik�w kt�rzy maj� szefa'
from Employees
where Employees.ReportsTo is not null

--�w.5	Ilu jest klient�w z poszczeg�lnych pa�stw? Dane posortuj tak, 
--by pa�stwa gdzie jest najwi�cej klient�w  by�y wymienione jako pierwsze.

select Customers.Country,count(Customers.CustomerID) as p
from Customers
group by Customers.Country
order by count(Customers.CustomerID) desc 

--�w.6	Kt�ry z kurier�w realizuje najwi�cej zam�wie�?

select Shippers.CompanyName, count(Orders.ShipVia)
from Shippers join Orders on Shippers.ShipperID = Orders.ShipVia
group by Shippers.CompanyName
order by Count(Orders.ShipVia) desc

--�w.7	Jaka jest maksymalna cena produktu w ka�dej kategorii?

select Categories.CategoryName,max(Products.UnitPrice) as 'Najwi�ksza cena produktu'
from Products join Categories on Categories.CategoryID = Products.CategoryID
group by Categories.CategoryName
order by [Najwi�ksza cena produktu] desc

--�w.8	Zr�b zestawienie pokazuj�ce ��czn� warto�� poszczeg�lnych zam�wie�. Wypisz  pi�� zam�wie� o najwi�kszej warto�ci.

select top(5) Orders.OrderID as 'ID zam�wienia', sum([Order Details].Quantity*[Order Details].UnitPrice) as 'wartosc'
from Orders inner join [Order Details] on orders.OrderID = [Order Details].OrderID
group by Orders.OrderID
order by wartosc desc

--�w.9	Zr�b zestawienie pokazuj�ce ��czn� warto�� poszczeg�lnych zam�wie�. Wypisz  zam�wienia przekraczaj�ce kwot� 15000.

select Orders.OrderID as 'ID zam�wienia', sum([Order Details].Quantity*[Order Details].UnitPrice) as 'wartosc'
from Orders join [Order Details] on orders.OrderID = [Order Details].OrderID
group by Orders.OrderID
order by wartosc desc

--�w.10	Policz po ile r�nych produkt�w  jest na ka�dym zam�wieniu.

select Orders.OrderID as 'ID zam�wienia', Products.ProductName as 'Nazwa produktu' , [Order Details].Quantity as 'ilo��'
from Orders join [Order Details] on orders.OrderID = [Order Details].OrderID join Products on [Order Details].ProductID = Products.ProductID

--�w.11	Wypisz nazwiska i imiona pracownik�w realizuj�cych najwi�cej zam�wie�. Wypisz imiona i nazwiska trzech 
--os�b realizuj�cych  najwi�cej zam�wie�.

select top(3) Employees.EmployeeID as 'Numer pracownika',Employees.LastName as 'Nazwisko', Employees.FirstName as 'Imi�', count(Orders.OrderID) as 'ilo��'
from Employees join Orders on Employees.EmployeeID = Orders.EmployeeID
group by Employees.EmployeeID,Employees.LastName,Employees.FirstName
order by count(Orders.OrderID) desc

--�w.12	Wypisz informacje  ilu podwa�adanych ma  ka�da z os�b. Wpisz  r�wnie� te osoby, kt�re nie maj� �adnych podw�adnych.
