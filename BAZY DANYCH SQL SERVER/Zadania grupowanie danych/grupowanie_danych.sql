use Northwind

--Æwiczenia do bazy: NorthWind – grupowanie 
--Æw.1	Oblicz œredni¹ cenê wszystkich produktów.

select avg(Products.UnitPrice) as 'Œrednia cena wszystkich produktów'
from Products

--Æw.2	Jaka ³¹czna iloœæ produktów zosta³a zamówiona?

select SUM([Order Details].Quantity) as 'Suma zamówionych produktów'
from [Order Details]

--Æw.3	Ilu jest pracowników?

select COUNT(Employees.EmployeeID) as 'Ilosc pracowników'
from Employees

--Æw.4	Ilu jest pracowników, którzy maj¹ szefa?

select count(Employees.EmployeeID) as 'Iloœæ pracowników którzy maj¹ szefa'
from Employees
where Employees.ReportsTo is not null

--Æw.5	Ilu jest klientów z poszczególnych pañstw? Dane posortuj tak, 
--by pañstwa gdzie jest najwiêcej klientów  by³y wymienione jako pierwsze.

select Customers.Country,count(Customers.CustomerID) as p
from Customers
group by Customers.Country
order by count(Customers.CustomerID) desc 

--Æw.6	Który z kurierów realizuje najwiêcej zamówieñ?

select Shippers.CompanyName, count(Orders.ShipVia)
from Shippers join Orders on Shippers.ShipperID = Orders.ShipVia
group by Shippers.CompanyName
order by Count(Orders.ShipVia) desc

--Æw.7	Jaka jest maksymalna cena produktu w ka¿dej kategorii?

select Categories.CategoryName,max(Products.UnitPrice) as 'Najwiêksza cena produktu'
from Products join Categories on Categories.CategoryID = Products.CategoryID
group by Categories.CategoryName
order by [Najwiêksza cena produktu] desc

--Æw.8	Zrób zestawienie pokazuj¹ce ³¹czn¹ wartoœæ poszczególnych zamówieñ. Wypisz  piêæ zamówieñ o najwiêkszej wartoœci.

select top(5) Orders.OrderID as 'ID zamówienia', sum([Order Details].Quantity*[Order Details].UnitPrice) as 'wartosc'
from Orders inner join [Order Details] on orders.OrderID = [Order Details].OrderID
group by Orders.OrderID
order by wartosc desc

--Æw.9	Zrób zestawienie pokazuj¹ce ³¹czn¹ wartoœæ poszczególnych zamówieñ. Wypisz  zamówienia przekraczaj¹ce kwotê 15000.

select Orders.OrderID as 'ID zamówienia', sum([Order Details].Quantity*[Order Details].UnitPrice) as 'wartosc'
from Orders join [Order Details] on orders.OrderID = [Order Details].OrderID
group by Orders.OrderID
order by wartosc desc

--Æw.10	Policz po ile ró¿nych produktów  jest na ka¿dym zamówieniu.

select Orders.OrderID as 'ID zamówienia', Products.ProductName as 'Nazwa produktu' , [Order Details].Quantity as 'iloœæ'
from Orders join [Order Details] on orders.OrderID = [Order Details].OrderID join Products on [Order Details].ProductID = Products.ProductID

--Æw.11	Wypisz nazwiska i imiona pracowników realizuj¹cych najwiêcej zamówieñ. Wypisz imiona i nazwiska trzech 
--osób realizuj¹cych  najwiêcej zamówieñ.

select top(3) Employees.EmployeeID as 'Numer pracownika',Employees.LastName as 'Nazwisko', Employees.FirstName as 'Imiê', count(Orders.OrderID) as 'iloœæ'
from Employees join Orders on Employees.EmployeeID = Orders.EmployeeID
group by Employees.EmployeeID,Employees.LastName,Employees.FirstName
order by count(Orders.OrderID) desc

--Æw.12	Wypisz informacje  ilu podwa³adanych ma  ka¿da z osób. Wpisz  równie¿ te osoby, które nie maj¹ ¿adnych podw³adnych.
