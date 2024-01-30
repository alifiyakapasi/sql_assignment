-- 1. Create a stored procedure in the Northwind database that will calculate the average 
value of Freight for a specified customer.Then, a business rule will be added that will 
be triggered before every Update and Insert command in the Orders controller,and 
will use the stored procedure to verify that the Freight does not exceed the average 
freight. If it does, a message will be displayed and the command will be cancelled.

USE [alifiyakapasi_db]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[CalculateAverageFreight]
    @CustomerID NVARCHAR(5)
AS
BEGIN
    SELECT AVG(Freight) AS AverageFreight
    FROM Orders
    WHERE CustomerID = @CustomerID;
END;


USE [alifiyakapasi_db];
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TRIGGER CheckFreightValue
ON Orders
AFTER INSERT, UPDATE
AS
BEGIN
    DECLARE @CustomerID NVARCHAR(5);
    DECLARE @Freight MONEY;
    DECLARE @AverageFreight MONEY;

    SELECT @CustomerID = CustomerID, @Freight = Freight
    FROM inserted;

    EXEC [dbo].[CalculateAverageFreight] @CustomerID='ALFKI';

    IF @Freight > @AverageFreight
    BEGIN
		RAISERROR ('Freight value exceeds the average freight for the customer.', -- Message text.
               16, -- Severity.
               1 -- State.
               );
        ROLLBACK TRANSACTION;
    END;
END;

select * from Orders

-- 2. write a SQL query to Create Stored procedure in the Northwind database to retrieve Employee Sales by Country

create procedure [dbo].[Employee Sales by Country]
@Beginning_Date DateTime, @Ending_Date DateTime AS
SELECT Employees.Country, Employees.LastName, Employees.FirstName, Orders.ShippedDate, Orders.OrderID, "Order Subtotals".Subtotal AS SaleAmount
FROM Employees INNER JOIN
	(Orders INNER JOIN "Order Subtotals" ON Orders.OrderID = "Order Subtotals".OrderID)
	ON Employees.EmployeeID = Orders.EmployeeID
WHERE Orders.ShippedDate Between @Beginning_Date And @Ending_Date


DECLARE	@return_value int
EXEC	@return_value = [dbo].[Employee Sales by Country]	
		@Beginning_Date = NULL,
		@Ending_Date = NULL
SELECT	'Return Value' = @return_value

select * from [dbo].[Orders]
select * from [dbo].[Employees]


-- 3. write a SQL query to Create Stored procedure in the Northwind database to retrieve Sales by Year

create procedure [dbo].[Sales by Year]
	@Beginning_Date DateTime, @Ending_Date DateTime AS
SELECT Orders.ShippedDate, Orders.OrderID, "Order Subtotals".Subtotal, DATENAME(yy,ShippedDate) AS Year
FROM Orders INNER JOIN "Order Subtotals" ON Orders.OrderID = "Order Subtotals".OrderID
WHERE Orders.ShippedDate Between @Beginning_Date And @Ending_Date


DECLARE @return_value int
EXEC @return_value = [dbo].[Sales by Year]
    @Beginning_Date = '1996-07-01',
    @Ending_Date = '1998-12-31'
SELECT 'Return Value' = @return_value


select * from [dbo].[Orders]


-- 4. write a SQL query to Create Stored procedure in the Northwind database to retrieve Sales By Category

CREATE PROCEDURE [dbo].[SalesByCategory]
    @CategoryName nvarchar(15), @OrdYear nvarchar(4) = '1998'
AS
IF @OrdYear != '1996' AND @OrdYear != '1997' AND @OrdYear != '1998'
BEGIN
	SELECT @OrdYear = '1998'
END

SELECT ProductName,
	TotalPurchase=ROUND(SUM(CONVERT(decimal(14,2), OD.Quantity * (1-OD.Discount) * OD.UnitPrice)), 0)
FROM [Order Details] OD, Orders O, Products P, Categories C
WHERE OD.OrderID = O.OrderID
	AND OD.ProductID = P.ProductID
	AND P.CategoryID = C.CategoryID
	AND C.CategoryName = @CategoryName
	AND SUBSTRING(CONVERT(nvarchar(22), O.OrderDate, 111), 1, 4) = @OrdYear
GROUP BY ProductName
ORDER BY ProductName


DECLARE	@return_value int
EXEC	@return_value = [dbo].[SalesByCategory]	
		 @CategoryName = 'Beverages',
		@OrdYear = '1998'
SELECT	'Return Value' = @return_value

select * from Categories
select * from Orders
select * from Products


-- 5. write a SQL query to Create Stored procedure in the Northwind database to retrieve Ten Most Expensive Products

create procedure [dbo].[Ten Most Expensive Products] AS
SET ROWCOUNT 10
SELECT Products.ProductName AS TenMostExpensiveProducts, Products.UnitPrice
FROM Products
ORDER BY Products.UnitPrice DESC


DECLARE	@return_value int
EXEC	@return_value = [dbo].[Ten Most Expensive Products]
SELECT	'Return Value' = @return_value


-- 6. write a SQL query to Create Stored procedure in the Northwind database to insert Customer Order Details 

CREATE PROCEDURE [insert_Order Details_1]
(@OrderID_1 [int],
@ProductID_2 [int],
@UnitPrice_3 [money] = NULL,
@Quantity_4 [smallint],
@Discount_5 [real] = 0)
AS
INSERT INTO [dbo].[Order Details]
( [OrderID], [ProductID], [UnitPrice], [Quantity], [Discount])
VALUES ( @OrderID_1, @ProductID_2, @UnitPrice_3, @Quantity_4, @Discount_5)
GO


DECLARE	@return_value int
EXEC	@return_value = [dbo].[insert_Order Details_1]
		@OrderID_1 = 10251,
		@ProductID_2 = 20,
		@UnitPrice_3 = 15.00,
		@Quantity_4 = 7,
		@Discount_5 = 0.10
SELECT	'Return Value' = @return_value


select * from [dbo].[Order Details]

-- 7. write a SQL query to Create Stored procedure in the Northwind database to update Customer Order Details


CREATE PROCEDURE [update_Order Details_1]
(@OrderID_1 [int],
@ProductID_2 [int],
@NewQuantity_4 [smallint]= NULL,
@NewUnitPrice_3 [money] = NULL,
@NewDiscount_5 [real] = NULL)
AS

UPDATE [dbo].[Order Details]
SET [Quantity] = @NewQuantity_4, [UnitPrice] = @NewUnitPrice_3, [Discount]
= @NewDiscount_5
WHERE ( [OrderID] = @OrderID_1 AND [ProductID] = @ProductID_2)


DECLARE	@return_value int
EXEC	@return_value = [dbo].[update_Order Details_1]
		@OrderID_1 = 10248,
		@ProductID_2 = 11,
		@NewQuantity_4 = 15,
		@NewUnitPrice_3 = 15.00,
		@NewDiscount_5 = 0.15
SELECT	'Return Value' = @return_value


select * from [dbo].[Order Details]


SET IDENTITY_INSERT Orders OFF
SET IDENTITY_INSERT Orders ON


-- FOR ORDER TABLE
CREATE PROCEDURE [insert_Order]
(@OrderID_1 [int],
@CustomerID_2 [varchar],
@EmployeeID_3[int],
@OrderDate_4[datetime],
@RequiredDate_5[datetime],
@ShippedDate_6[datetime],
@ShipVia_7[int],
@Freight_8[decimal],
@ShipName_9[varchar],
@ShipAddress_10[varchar],
@ShipCity_11[varchar],
@ShipRegion_12[varchar],
@ShipPostalCode_13[int],
@ShipCountry_14[varchar])
AS
INSERT INTO [dbo].[Orders]
( [OrderID],[CustomerID],[EmployeeID],[OrderDate],[RequiredDate],[ShippedDate],[ShipVia],[Freight],[ShipName],[ShipAddress],[ShipCity],[ShipRegion],[ShipPostalCode],[ShipCountry])
VALUES ( @OrderID_1,
@CustomerID_2 ,
@EmployeeID_3,
@OrderDate_4,
@RequiredDate_5,
@ShippedDate_6,
@ShipVia_7,
@Freight_8,
@ShipName_9,
@ShipAddress_10,
@ShipCity_11,
@ShipRegion_12,
@ShipPostalCode_13,
@ShipCountry_14)

DECLARE	@return_value int
EXEC	@return_value = [dbo].[insert_Order]
		@OrderID_1 = 11078,
		@CustomerID_2 = VINET ,
		@EmployeeID_3 = 7,
		@OrderDate_4 = '1996-07-08 00:00:00.000',
		@RequiredDate_5 = '1996-08-06 00:00:00.000',
		@ShippedDate_6 = '1996-07-11 00:00:00.000',
		@ShipVia_7 = 3,
		@Freight_8 = 30.77,
		@ShipName_9 =' Vins et alcools Chevalier',
		@ShipAddress_10 = '59 rue de l Abbaye',
		@ShipCity_11 = 'Reims' ,
		@ShipRegion_12 = RJ,
		@ShipPostalCode_13 = 51100,
		@ShipCountry_14 = France 
SELECT	'Return Value' = @return_value