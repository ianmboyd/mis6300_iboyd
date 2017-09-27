
use AdventureWorks2012

Select JobTitle, count(BusinessEntityId) as Nunber_of_Employees
from HumanResources.Employee 
where CurrentFlag = 1
Group By JobTitle
Having count(BusinessEntityID) > 1
Order by count(BusinessEntityId) DESC

/*Examp1e of Having*/ 
SELECT TerritoryID, 
OrderDate, 
Count(SalesOrderID) AS Number_of_Orders, 
SUM(TotalDue) AS Total_Amount 
FROM Sales.SalesOrderHeader 
WHERE orderDate < '2007-01-01' 
GROUP BY TerritoryID, OrderDate 
HAVING SUM(TotalDue) > 5000
ORDER BY SUM(TotalDue) DESC 