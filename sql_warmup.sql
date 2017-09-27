use AdventureWorks2012

/*List info of all the sales order details */

SELECT * 
FROM SALES.SalesOrderDetail

/* Find out th esales infor about Prodict (ID== 843 */

Select * from Sales.SalesOrderDetail where UnitPrice between 100 and 200


Select distinct s.Name from Sales.store as s where s.name like '%bike%' 


