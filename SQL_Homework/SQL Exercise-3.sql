use AdventureWorksDW2012;


/*1, 

Display 
number of orders and 
total sales amount(sum of SalesAmount) of 
Internet Sales 
in 1st quarter 
each year 
in each country. 

Note: your result set should produce a total of 18 rows. */

/**
	Using calendar date in this query because it returns the prescribed number of rows.
**/
select 
d.CalendarYear as "Calendar_Year",
d.CalendarQuarter as "Calendar_Quarter",
count(s.SalesOrderNumber) as Number_of_Orders, 
sum(s.SalesAmount) as Total_Sales, 
t.SalesTerritoryCountry as Country
from dbo.FactInternetSales s 
join dbo.DimDate d on d.DateKey = s.OrderDateKey
join dbo.DimSalesTerritory t on s.SalesTerritoryKey = t.SalesTerritoryKey 
where d.CalendarQuarter = 1
group by d.CalendarYear, d.CalendarQuarter, t.SalesTerritoryCountry
Order by d.CalendarYear ASC

/*2, Show 

total reseller sales amount (sum of SalesAmount), 
calendar quarter of order date, 
product category name and 
reseller’s business type 
by quarter 
by category and 
by business type 
in 2006. 
Note: your result set should produce a total of 44 rows. */

select d.CalendarYear as Calendar_Year, d.CalendarQuarter as Calendar_Quarter, sum(s.SalesAmount) as Sales_Total, c.EnglishProductCategoryName as Category_Name, r.BusinessType
from dbo.FactResellerSales s
join dbo.dimDate d on d.dateKey = s.OrderDateKey
join dbo.DimProduct p on p.ProductKey = s.ProductKey
join dbo.DimProductSubcategory sc on sc.ProductSubcategoryKey = p.ProductSubcategoryKey
join dbo.DimProductCategory c on c.ProductCategoryKey = sc.ProductCategoryKey
join dbo.DimReseller r on r.ResellerKey = s.ResellerKey
where d.CalendarYear = 2006
group by d.CalendarYear, d.CalendarQuarter, c.EnglishProductCategoryName, r.BusinessType
order by d.CalendarQuarter asc, c.EnglishProductCategoryName asc, r.BusinessType asc

/*3, Based on 2, perform an OLAP operation: slice. In comment, describe how you perform the slicing, 
i.e. what do you do to what dimension(s)? Why is it a operation of slicing?*/

/**
To perform a "slice" on the data in (2), I need to reduce the dimensionality of the results set.
This can be accomplished by adding an additional "WHERE" clause to the query.

I will "slice" the data by the business type, looking only for "Warehouse" sales, thereby removing the "BusinessType" dimension from my OLAP Cube
**/
select d.CalendarYear as Calendar_Year, d.CalendarQuarter as Calendar_Quarter, sum(s.SalesAmount) as Sales_Total, c.EnglishProductCategoryName as Category_Name, r.BusinessType
from dbo.FactResellerSales s
join dbo.dimDate d on d.dateKey = s.OrderDateKey
join dbo.DimProduct p on p.ProductKey = s.ProductKey
join dbo.DimProductSubcategory sc on sc.ProductSubcategoryKey = p.ProductSubcategoryKey
join dbo.DimProductCategory c on c.ProductCategoryKey = sc.ProductCategoryKey
join dbo.DimReseller r on r.ResellerKey = s.ResellerKey
where d.CalendarYear = 2006 and r.BusinessType like 'Warehouse'
group by d.CalendarYear, d.CalendarQuarter, c.EnglishProductCategoryName, r.BusinessType
order by d.CalendarQuarter asc, c.EnglishProductCategoryName asc, r.BusinessType asc

/*4, Based on 2, perform an OLAP operation: drill-down. In comment, describe how you perform the drill-down, 
i.e. what do you do to what dimension(s)? Why is it a operation of drilling-down?*/

/**
To perform a drill-down on the data in (2), I need to increase dimensionality of the results set and provide a higher level of granularity.
This can be accomplished by expanding the hierarchy of an existing dimension. 
In the query from (2) there are a few options for drill down, I will choose to drill-down into the product sub-category
**/

select 
d.CalendarYear as Calendar_Year, 
d.CalendarQuarter as Calendar_Quarter, 
sum(s.SalesAmount) as Sales_Total, 
c.EnglishProductCategoryName as Category_Name, 
sc.EnglishProductSubcategoryName as Sub_Category_Name, 
r.BusinessType
from dbo.FactResellerSales s
join dbo.dimDate d on d.dateKey = s.OrderDateKey
join dbo.DimProduct p on p.ProductKey = s.ProductKey
join dbo.DimProductSubcategory sc on sc.ProductSubcategoryKey = p.ProductSubcategoryKey
join dbo.DimProductCategory c on c.ProductCategoryKey = sc.ProductCategoryKey
join dbo.DimReseller r on r.ResellerKey = s.ResellerKey
where d.CalendarYear = 2006
group by d.CalendarYear, d.CalendarQuarter,sc.EnglishProductSubcategoryName, c.EnglishProductCategoryName, r.BusinessType
order by d.CalendarQuarter asc, c.EnglishProductCategoryName asc, r.BusinessType asc