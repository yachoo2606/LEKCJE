use Northwind

select*
from Employees
--�w.1
--Wypisz nazwy produkt�w mi�snych.
select Products.ProductName
from Products join Categories on Categories.CategoryID = Products.CategoryID
where CategoryName like '%meat%'

--�w.2 
--Wypisz nazwy produkt�w wraz z nazw� firmy dostarczaj�cej podukt. 
--We� pod uwag� tylko firmy japo�skie.
select ProductName,Suppliers.CompanyName
from Products join Suppliers on Suppliers.SupplierID = Products.SupplierID 
where Suppliers.Country like '%Japan%' 

--�w.3 
--Wypisz nazwy produkt�w, ich kategori� oraz nazw� firmy dostarczaj�cej towar. 
--We� pod uwag� tylko owoce morza i firmy japo�skie.
select ProductName,CategoryName,CompanyName
from Products join Categories on Categories.CategoryID=Products.CategoryID join Suppliers on Suppliers.SupplierID = Products.SupplierID
where Suppliers.Country like '%Japan%' and Categories.CategoryName like '%Seafood%'

--�w.4 Wypisz dane zam�wie�: numer, nazw� klienta, imi� i nazwisko pracownika 
--realizuj�cego zam�wienie, nazw� spedytora oraz dat� zam�wienia.
--Dane posortuj wed�ug klienta, a p�niej wed�ug pracownika.

select OrderID, Customers.ContactName,Employees.FirstName,Employees.LastName
from Orders join Customers on Customers.CustomerID = Orders.CustomerID join Employees on Orders.EmployeeID = Employees.EmployeeID
order by Customers.ContactName,Employees.LastName

--�w.5 Wypisz nazwiska i imiona tych pracownik�w, kt�rzy obs�uguj� regiony: 
--Boston, Orlando i Santa Cruz. Dane posortuj alfabetycznie.

select Employees.LastName,Employees.FirstName 
from Employees join EmployeeTerritories on Employees.EmployeeID = EmployeeTerritories.EmployeeID join Region on EmployeeTerritories.TerritoryID = Region.RegionID
where Region.RegionDescription like '%Boston%' or Region.RegionDescription like '%Orlando%' or Region.RegionDescription like '%Santa Cruz%'

--�w.6 Wypisz nazwy i adresy tych klient�w, kt�rych dane znajduj� sie w bazie, 
--ale nie dokonali jeszcze �adnego zam�wienia.

select Customers.ContactName,Customers.Address
from Customers left join Orders on Customers.CustomerID = Orders.CustomerID
where Orders.CustomerID is null

--�w.7 Wypisz nazwy produkt�w, ich kategorie i ceny. We� pod uwag� tylko 5 
--najdro�szych produkt�w.

select top (5) ProductName,CategoryName,UnitPrice
from Products join Categories on Products.CategoryID = Categories.CategoryID
order by UnitPrice desc

--�w.8 Wypisz te produkty, kt�re maj� najwi�kszy rabat. Posortuj je alfabetycznie 
--i nie dopu�� do powt�rze� nazw produkt�w.

select distinct ProductName,[Order Details].Discount
from Products join [Order Details] on Products.ProductID = [Order Details].ProductID
order by [Order Details].Discount desc,ProductName
--�w.9 Wypisz imiona i nazwiska pracownik�w ��cznie z danymi ich szef�w.

select A.FirstName as 'Pracownik imie', A.LastName as 'Pracownik Nazwisk', B.FirstName as 'Szef imie', B.LastName as 'Szef Nazwisko'
from Employees as A join Employees as B on B.EmployeeID = A.ReportsTo


--�w.10 Wypisz imiona i nazwiska pracownik�w ��cznie z danymi ich szef�w. 
--We� pod uwag� r�wnie� tych pracownik�w kt�rzy nie maj� szefa.

select A.FirstName as 'Pracownik imie', A.LastName as 'Pracownik Nazwisk', B.FirstName as 'Szef imie', B.LastName as 'Szef Nazwisko'
from Employees as A left join Employees as B on B.EmployeeID = A.ReportsTo
