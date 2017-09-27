select 
s.SalesOrderID, 
s.OrderQty, 
s.ProductID, 
p.Name as 'Product Name',
s.UnitPrice, 
s.LineTotal
 from [AdventureWorks2012].[Sales].[SalesOrderDetail] as s, 
 [AdventureWorks2012].[Production].[Product] as p
where s.ProductID = p.ProductID