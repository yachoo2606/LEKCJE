use Northwind

select*
from Employees
--Æw.1
--Wypisz nazwy produktów miêsnych.
select Products.ProductName
from Products join Categories on Categories.CategoryID = Products.CategoryID
where CategoryName like '%meat%'

--Æw.2 
--Wypisz nazwy produktów wraz z nazw¹ firmy dostarczaj¹cej podukt. 
--WeŸ pod uwagê tylko firmy japoñskie.
select ProductName,Suppliers.CompanyName
from Products join Suppliers on Suppliers.SupplierID = Products.SupplierID 
where Suppliers.Country like '%Japan%' 

--Æw.3 
--Wypisz nazwy produktów, ich kategoriê oraz nazwê firmy dostarczaj¹cej towar. 
--WeŸ pod uwagê tylko owoce morza i firmy japoñskie.
select ProductName,CategoryName,CompanyName
from Products join Categories on Categories.CategoryID=Products.CategoryID join Suppliers on Suppliers.SupplierID = Products.SupplierID
where Suppliers.Country like '%Japan%' and Categories.CategoryName like '%Seafood%'

--Æw.4 Wypisz dane zamówieñ: numer, nazwê klienta, imiê i nazwisko pracownika 
--realizuj¹cego zamówienie, nazwê spedytora oraz datê zamówienia.
--Dane posortuj wed³ug klienta, a póŸniej wed³ug pracownika.

select OrderID, Customers.ContactName,Employees.FirstName,Employees.LastName
from Orders join Customers on Customers.CustomerID = Orders.CustomerID join Employees on Orders.EmployeeID = Employees.EmployeeID
order by Customers.ContactName,Employees.LastName

--Æw.5 Wypisz nazwiska i imiona tych pracowników, którzy obs³uguj¹ regiony: 
--Boston, Orlando i Santa Cruz. Dane posortuj alfabetycznie.

select Employees.LastName,Employees.FirstName 
from Employees join EmployeeTerritories on Employees.EmployeeID = EmployeeTerritories.EmployeeID join Region on EmployeeTerritories.TerritoryID = Region.RegionID
where Region.RegionDescription like '%Boston%' or Region.RegionDescription like '%Orlando%' or Region.RegionDescription like '%Santa Cruz%'

--Æw.6 Wypisz nazwy i adresy tych klientów, których dane znajduj¹ sie w bazie, 
--ale nie dokonali jeszcze ¿adnego zamówienia.

select Customers.ContactName,Customers.Address
from Customers left join Orders on Customers.CustomerID = Orders.CustomerID
where Orders.CustomerID is null

--Æw.7 Wypisz nazwy produktów, ich kategorie i ceny. WeŸ pod uwagê tylko 5 
--najdro¿szych produktów.

select top (5) ProductName,CategoryName,UnitPrice
from Products join Categories on Products.CategoryID = Categories.CategoryID
order by UnitPrice desc

--Æw.8 Wypisz te produkty, które maj¹ najwiêkszy rabat. Posortuj je alfabetycznie 
--i nie dopuœæ do powtórzeñ nazw produktów.

select distinct ProductName,[Order Details].Discount
from Products join [Order Details] on Products.ProductID = [Order Details].ProductID
order by [Order Details].Discount desc,ProductName
--Æw.9 Wypisz imiona i nazwiska pracowników ³¹cznie z danymi ich szefów.

select A.FirstName as 'Pracownik imie', A.LastName as 'Pracownik Nazwisk', B.FirstName as 'Szef imie', B.LastName as 'Szef Nazwisko'
from Employees as A join Employees as B on B.EmployeeID = A.ReportsTo


--Æw.10 Wypisz imiona i nazwiska pracowników ³¹cznie z danymi ich szefów. 
--WeŸ pod uwagê równie¿ tych pracowników którzy nie maj¹ szefa.

select A.FirstName as 'Pracownik imie', A.LastName as 'Pracownik Nazwisk', B.FirstName as 'Szef imie', B.LastName as 'Szef Nazwisko'
from Employees as A left join Employees as B on B.EmployeeID = A.ReportsTo
