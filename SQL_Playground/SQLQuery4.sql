/*
Using the HumanResource.Employee table, provide a count of the number of employees by job title.  
The query should consider only current employees (the CurrentFlag must equal 1).  

*/

use AdventureWorks2012

select JobTitle as Job_Title, count(BusinessEntityID) as Total
from HumanResources.Employee where CurrentFlag = 1 
Group By JobTitle having count(BusinessEntityID) > 1
order by Total desc

/*
For each product, show its ProductID and Name (from the ProductionProduct table) 
and the location of its inventory (from the Product.Location table) 
and amount of inventory held at that location (from the Production.ProductInventory table). 
*/

Select P.ProductID, P.Name as Product_Name, L.Name as Product_Location, I.Quantity
from Production.Product as P
inner Join Production.ProductInventory as I on P.ProductID = I.ProductID
inner Join Production.Location as L on L.LocationID = I.LocationID

 /*

 Find the product model IDs that have no product associated with them.  

To do this, first do an outer join between the Production.Product table and the Production.ProductModel 
table in such a way that the ID from the ProductModel table always shows, even if there is no product associate with it.  

Then, add a WHERE clause to specify that the ProductID IS NULL

 */

 Select M.ProductModelID, P.ProductID 
 from Production.ProductModel as M 
 Left Outer Join Production.Product as P on P.ProductModelID = M.ProductModelID 
 where ProductID is null 
 

 Select M.ProductModelID, P.ProductID 
 from Production.Product as P 
 Left Outer Join Production.ProductModel as M on P.ProductModelID = M.ProductModelID 

 select * from Production.Product where ProductID = 1