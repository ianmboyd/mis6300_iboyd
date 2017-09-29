use AdventureWorks2012;

/*a.	
Show First name and last name of employees 
whose job title is “Sales Representative”, 
ranking from oldest to youngest. 
You may use HumanResources.Employee table 
and Person.Person table. 
(14 rows)*/

select 
p.firstName, 
p.lastName
from HumanResources.Employee e 
join Person.Person p on e.BusinessEntityID = p.BusinessEntityID
where e.JobTitle like '%Sales Representative%'
Order by e.BirthDate ASC 


/*b.	
Find out all the products which sold more than $5000 in total. 
Show product ID and 
name and 
total amount collected after selling the products. 
You may use LineTotal from Sales.SalesOrderDetail table 
and Production.Product table. 
(254 rows)*/

Select 
p.ProductID, 
p.Name, 
sum(d.LineTotal) as TotalSales
from Production.Product p 
join Sales.SalesOrderDetail d on d.ProductID = p.ProductID
group by 
p.Name, 
p.ProductID
having sum(d.LineTotal) > 5000


/*c.	
Show BusinessEntityID, 
territory name and 
SalesYTD 
of all sales persons 
whose SalesYTD is greater than $500,000, regardless of whether they are assigned a territory. 
You may use Sales.SalesPerson table 
and Sales.SalesTerritory table. 
(16 rows)*/

select 
sp.BusinessEntityID, 
st.Name, 
sp.SalesYTD
from Sales.SalesPerson sp     
left join Sales.SalesTerritory st on sp.TerritoryID = st.TerritoryID
where sp.SalesYTD  > 500000            


/*d.	
Show the sales order ID 
of those orders in the year 2008 
of which the total due is great than the average total due 
of all the orders 
of the same year. 
(3200 rows)*/


Select 
h.salesorderID
from Sales.SalesOrderHeader h 
where h.orderDate between '1/1/2008' and '12/31/2008'
AND h.TotalDue > 
(
	select AVG(h.TotalDue) 
	from Sales.SalesOrderHeader h 
	where h.OrderDate between '1/1/2008' and '12/31/2008'
)
