/***
SQL Homework Assighment for Ian Boyd
Exercise2 
Information Technology, Week 3 
***/

USE AdventureWorks2012; /*Set current database*/


/*1. Display the total amount collected from the orders for each order date. */

select H.OrderDate, Sum(D.LineTotal) as TotalSales
From Sales.SalesOrderHeader as H
Join Sales.SalesOrderDetail as D on H.SalesOrderId = D.SalesOrderId
group by H.OrderDate
order by H.OrderDate asc
 

/*2. Display the total amount collected after selling the products, 774 and 777. */

Select sum(D.LineTotal) as Sales_774_777 
from Sales.SalesOrderDetail as D where D.ProductId in (774, 777)

/*3. Write a query to display the sales person ID of all the sales persons and the name of the territory to which they belong.*/


/***
 I'm using a left join here because I believe it's important to show salespeople which arent assigned a territory 
 ***/
select P.BusinessEntityID as SalesPerson_ID, T.Name as Territory_Name
from sales.salesperson P
left Join sales.SalesTerritory as T on T.TerritoryID = P.TerritoryID


/*4. Write a query to display the Business Entities of the customers that have the 'Vista' credit card.*/

select PCC.BusinessEntityID, P.FirstName, P.LastName
from Sales.PersonCreditCard as PCC 
Join Sales.CreditCard as C on C.CreditCardID = PCC.CreditCardID
Join Person.Person as P on P.BusinessEntityID = PCC.BusinessEntityID
Where C.CardType like 'Vista' 
Order by P.LastName asc, P.FirstName asc

/*5, Write a query to display all the country region codes along with their corresponding territory IDs*/

Select CountryRegionCode, TerritoryID
From Sales.SalesTerritory

/*6. Find out the average of the total dues of all the orders.*/

Select sum(TotalDue) / 
	( 
		Select count(*) from Sales.SalesOrderHeader as S
		where S.TotalDue > 0 /*Dont through off the avg if balance was paid*/
	) as AVG_Outstanding_Due
from Sales.SalesOrderHeader

/**
OR
**/

Select AVG(TotalDue) as AVG_DUE from Sales.SalesOrderHeader

/*7. Write a query to report the sales order ID of those orders 
where the total value is greater than the average of the total 
value of all the orders.*/

Select H.SalesOrderId, H.TotalDue
from Sales.SalesOrderHeader as H 
where H.TotalDue > ( select AVG(TotalDue) from sales.SalesOrderHeader)
order by TotalDue asc

					











