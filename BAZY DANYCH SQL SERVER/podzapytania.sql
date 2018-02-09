--Zadania podzapytania – baza NORTHWIND
use Northwind
--Æw.1	Wypisz nazwy produktów i ich ceny, ale tylko  tych  towarów, których cena jest  
--powy¿ej œredniej ceny wszystkich produktów.

select Products.ProductName, Products.UnitPrice
from Products
where Products.UnitPrice > (select AVG(Products.UnitPrice) from Products)
 
--Æw.2	Wypisz nazwiko i imie  pracowników, którzy  realizuj¹ wiêcej zamówieñ ni¿ Davolio Nancy?
--zagnie¿d¿one

select Employees.LastName,Employees.FirstName, count(orders.OrderID)
from Employees join Orders on Employees.EmployeeID = Orders.EmployeeID 
group by Employees.FirstName,Employees.LastName
having count(Orders.OrderID) > 
(
select count(Orders.OrderID) 
from Employees join Orders on Employees.EmployeeID = Orders.EmployeeID 
where Employees.FirstName like'Nancy' and Employees.LastName like 'Davolio'
)

--Æw.3	Podaj nazwisko i imiê oraz datê urodzenia najstarszego  pracownika (licz¹c rok urodzenia). Zadanie rozwi¹¿ dwoma 
--sposobam z podzapytaniem i bez.

select top(1) Employees.FirstName,Employees.LastName, YEAR(GETDATE())-YEAR(Employees.BirthDate) 
from Employees
where YEAR(getdate())-YEAR(Employees.BirthDate)=
	(select top(1)  YEAR(GETDATE())-YEAR(Employees.BirthDate) 
	from Employees
	order by YEAR(getdate())-YEAR(Employees.BirthDate) desc
	)

select top(1) Employees.FirstName,Employees.LastName, year(getdate())-year(Employees.BirthDate)
from Employees
Group by Employees.FirstName,Employees.LastName,year(getdate())-year(Employees.BirthDate)
order by year(getdate())-year(Employees.BirthDate) desc

--Æw.4	Podaj imiona  i nazwiska pracownków których wiek przekracaz œredni wiek pracowników.
--nie dzia³a
select Employees.FirstName, Employees.LastName, year(GETDATE())-year(Employees.BirthDate)
from Employees
where 
	year(GETDATE())-year(Employees.BirthDate)
	>
	(select avg(year(GETDATE())-year(Employees.BirthDate)) from Employees)

--Æw.5	Podaj nazwy firm które  s¹ z tego samego miasta co  klient Eastern Connection.
--chyba dzia³a

select distinct Suppliers.CompanyName
from Suppliers join Customers on Suppliers.City = Customers.City
where Suppliers.City = (select Customers.City from Customers where Customers.CompanyName like'Eastern Connection')
 
 select b.CompanyName
 from Customers as a 
 join Customers as b
 on a.CustomerID = b.CustomerID
 where a.City = (select b.City from Customers where Customers.CompanyName like 'Eastern Connection')

 select * from Customers where City like 'London'

--Æw.6	Wypisz  nazwy kategorii  produktów, których ³¹czna wartoœæ zamówieñ jest mniejsza ni¿ wartoœæ zamówieñ 
--wszystkich napojów. ( Beverages)
--nie dzia³a 

	select Categories.CategoryName
	from Categories 
	join Products 
	on Categories.CategoryID = Products.CategoryID
	join [Order Details]
	on Products.ProductID = [Order Details].ProductID
	group by CategoryName
	having 
	sum(Products.UnitPrice*Products.UnitsOnOrder) 
	<
	(
	select sum(Products.UnitPrice*[Order Details].Quantity)
	from Products join Categories
	on Categories.CategoryID = Products.CategoryID
	join [Order Details] 
	on Products.ProductID = [Order Details].ProductID
	where CategoryName like 'Beverages'
	) 


--Æw.7	Wypisz te kraje w których znajduje siê wiêcej klientów  ni¿ w Meksyku.
--nie dzia³a

select Customers.Country
from Customers
group by Customers.Country
having	Count(Customers.Country)>
		(
		select count(Customers.CompanyName)
		from Customers
		where  Customers.Country like 'Mexico'
		)

--Æw.8	Podaj nazwy produktów, iloœæ w jakich by³y zamówione oraz œredni¹ cenê wszystkich produktów. 
--Zestawienie ma obejmowaæ produkty  zamówione w kwietniu 1997 roku. 

select Products.ProductName,sum([Order Details].Quantity) as 'iloœæ w zamówieniach',avg([Order Details].UnitPrice) as 'œrednia cena'
from [Order Details] join Products  on Products.ProductID = [Order Details].ProductID
					 join Orders on Orders.OrderID = [Order Details].OrderID
where month(orders.OrderDate)=4 and year(orders.orderDate)=1997
group by  Products.ProductName

--Æw.9	Podaj nazwê  kategorii  która ma najwiêcej produktów. Zadanie rozwi¹¿ dwoma sposobami. 

select top(1) Categories.CategoryName, count(Products.CategoryID)
from Categories join Products on Categories.CategoryID = Products.CategoryID
group by Categories.CategoryName
order by count(Products.CategoryID)desc

--Æw.10	Podaj nazwê firmy które dostarczaj¹ wiêcej produktów ni¿ firma Mayumi's. 

select Suppliers.CompanyName, count(Products.SupplierID)
from Products join Suppliers on Products.SupplierID = Suppliers.SupplierID
group by Suppliers.CompanyName
having count(Products.SupplierID)
 > 
 (
 select count(Products.SupplierID)
 from Products join Suppliers on Products.SupplierID = Suppliers.SupplierID
 where Suppliers.CompanyName like 'Mayumi%'
 )

--Æw.11	Podaj nazwy wszystkich obszarów do których nie ma przypisanego ¿adnego pracownika. Zadanie rozwi¹¿  dwoma sposobami.

select Employees.FirstName,Employees.LastName,Region.RegionDescription
from Employees join EmployeeTerritories on Employees.EmployeeID = EmployeeTerritories.EmployeeID
			   join Territories on EmployeeTerritories.TerritoryID = Territories.TerritoryID
			   join Region on Territories.RegionID = Region.RegionID
group by Employees.FirstName,Employees.LastName,Region.RegionDescription

--Æw.12	Podaj klientów którzy nie z³o¿yli ¿adnego zamówienia. Zadanie rozwi¹¿ dwoma sposobami.

select *
from Customers left join Orders on Customers.CustomerID = Orders.CustomerID
where Orders.CustomerID is null

--Æw.13	Ilu kilentów kupi³o wiêcej ni¿ 30 ró¿nych produktów.

select  Customers.CompanyName,count(Customers.CustomerID)
from Orders join Customers on Orders.CustomerID = Customers.CustomerID
			join [Order Details] on Orders.OrderID = [Order Details].OrderID
where 30<(select sum([Order Details].Quantity) from [Order Details])
group by Customers.CompanyName