--Zadania podzapytania � baza NORTHWIND
use Northwind
--�w.1	Wypisz nazwy produkt�w i ich ceny, ale tylko  tych  towar�w, kt�rych cena jest  
--powy�ej �redniej ceny wszystkich produkt�w.

select Products.ProductName, Products.UnitPrice
from Products
where Products.UnitPrice > (select AVG(Products.UnitPrice) from Products)
 
--�w.2	Wypisz nazwiko i imie  pracownik�w, kt�rzy  realizuj� wi�cej zam�wie� ni� Davolio Nancy?
--zagnie�d�one

select Employees.LastName,Employees.FirstName, count(orders.OrderID)
from Employees join Orders on Employees.EmployeeID = Orders.EmployeeID 
group by Employees.FirstName,Employees.LastName
having count(Orders.OrderID) > 
(
select count(Orders.OrderID) 
from Employees join Orders on Employees.EmployeeID = Orders.EmployeeID 
where Employees.FirstName like'Nancy' and Employees.LastName like 'Davolio'
)

--�w.3	Podaj nazwisko i imi� oraz dat� urodzenia najstarszego  pracownika (licz�c rok urodzenia). Zadanie rozwi�� dwoma 
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

--�w.4	Podaj imiona  i nazwiska pracownk�w kt�rych wiek przekracaz �redni wiek pracownik�w.
--nie dzia�a
select Employees.FirstName, Employees.LastName, year(GETDATE())-year(Employees.BirthDate)
from Employees
where 
	year(GETDATE())-year(Employees.BirthDate)
	>
	(select avg(year(GETDATE())-year(Employees.BirthDate)) from Employees)

--�w.5	Podaj nazwy firm kt�re  s� z tego samego miasta co  klient Eastern Connection.
--chyba dzia�a

select distinct Suppliers.CompanyName
from Suppliers join Customers on Suppliers.City = Customers.City
where Suppliers.City = (select Customers.City from Customers where Customers.CompanyName like'Eastern Connection')
 
 select b.CompanyName
 from Customers as a 
 join Customers as b
 on a.CustomerID = b.CustomerID
 where a.City = (select b.City from Customers where Customers.CompanyName like 'Eastern Connection')

 select * from Customers where City like 'London'

--�w.6	Wypisz  nazwy kategorii  produkt�w, kt�rych ��czna warto�� zam�wie� jest mniejsza ni� warto�� zam�wie� 
--wszystkich napoj�w. ( Beverages)
--nie dzia�a 

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


--�w.7	Wypisz te kraje w kt�rych znajduje si� wi�cej klient�w  ni� w Meksyku.
--nie dzia�a

select Customers.Country
from Customers
group by Customers.Country
having	Count(Customers.Country)>
		(
		select count(Customers.CompanyName)
		from Customers
		where  Customers.Country like 'Mexico'
		)

--�w.8	Podaj nazwy produkt�w, ilo�� w jakich by�y zam�wione oraz �redni� cen� wszystkich produkt�w. 
--Zestawienie ma obejmowa� produkty  zam�wione w kwietniu 1997 roku. 

select Products.ProductName,sum([Order Details].Quantity) as 'ilo�� w zam�wieniach',avg([Order Details].UnitPrice) as '�rednia cena'
from [Order Details] join Products  on Products.ProductID = [Order Details].ProductID
					 join Orders on Orders.OrderID = [Order Details].OrderID
where month(orders.OrderDate)=4 and year(orders.orderDate)=1997
group by  Products.ProductName

--�w.9	Podaj nazw�  kategorii  kt�ra ma najwi�cej produkt�w. Zadanie rozwi�� dwoma sposobami. 

select top(1) Categories.CategoryName, count(Products.CategoryID)
from Categories join Products on Categories.CategoryID = Products.CategoryID
group by Categories.CategoryName
order by count(Products.CategoryID)desc

--�w.10	Podaj nazw� firmy kt�re dostarczaj� wi�cej produkt�w ni� firma Mayumi's. 

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

--�w.11	Podaj nazwy wszystkich obszar�w do kt�rych nie ma przypisanego �adnego pracownika. Zadanie rozwi��  dwoma sposobami.

select Employees.FirstName,Employees.LastName,Region.RegionDescription
from Employees join EmployeeTerritories on Employees.EmployeeID = EmployeeTerritories.EmployeeID
			   join Territories on EmployeeTerritories.TerritoryID = Territories.TerritoryID
			   join Region on Territories.RegionID = Region.RegionID
group by Employees.FirstName,Employees.LastName,Region.RegionDescription

--�w.12	Podaj klient�w kt�rzy nie z�o�yli �adnego zam�wienia. Zadanie rozwi�� dwoma sposobami.

select *
from Customers left join Orders on Customers.CustomerID = Orders.CustomerID
where Orders.CustomerID is null

--�w.13	Ilu kilent�w kupi�o wi�cej ni� 30 r�nych produkt�w.

select  Customers.CompanyName,count(Customers.CustomerID)
from Orders join Customers on Orders.CustomerID = Customers.CustomerID
			join [Order Details] on Orders.OrderID = [Order Details].OrderID
where 30<(select sum([Order Details].Quantity) from [Order Details])
group by Customers.CompanyName