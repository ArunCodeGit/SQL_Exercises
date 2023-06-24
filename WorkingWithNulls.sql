				-----------------------------
				----- WORKING WITH NULLS-----
				-----------------------------

--- Often we need to work with NULLs.
--- Aggregate Functions Ignore NULL Values.
--- Many default behaviors will change if NULL values are involved.
--- Equality with NULL (=) will give inconsistent results based on ANSI-NULLs property.
--- When ANSI-NULLs is ON(Default), Equality Operator(=) doesn't give True or False But NULL AS OUTPUT.
--- When ANSI-NULLs is OFF, Equality Operator (=) will give True or False as OUTPUT.
--- Lot of side effects for changing that setting.
--- This returns no rows unless you run.
--- SET ANSI_NULLs OFF
--- (It is on by default)


	SELECT CompanyName, City
		FROM dbo.Suppliers
		WHERE Region=NULL;

	SELECT * FROM Suppliers;

	--- Change the setting

	SET ANSI_NULLS OFF;

	--- Now run last Query again

	--- Restore ANSI-NULLs Setting

	SET ANSI_NULLS ON;

	--- BUT THIS WORKS RELIABLY

	SELECT CompanyName, City 
		FROM dbo.Suppliers
		WHERE Region IS NULL;

---- Using ISNULL to Replace Null values with other String.
---- Do not confuse with IS NULL Operator which is used to check NULL values.

	SELECT CompanyName, City, 
		ISNULL (Region,'???') AS Region
	FROM dbo.Suppliers;

---- Using NULLIF to Convert NULL Values.
---- The Converse of ISNULL is NULLIF, IT replaces Actual values with NULLS.
---- Useful to Eliminate Values from Aggregation Functions to make it accurate.

---- View the UnitsInStock Data

	SELECT UnitsInStock from dbo.Products;

---- Several Products are out of inventory 

	SELECT AVG(NULLIF(UnitsInStock, 0)) From dbo.Products;

---- This will produce different OUTPUT than usual because NULLIF returns NULL when it encounters 0
---- Instead of actual one which includes 0 in AVG Function.

	SELECT AVG(UnitsInStock) FROM dbo.Products;

---- Using COALESCE to Find.
---- The First Non-Null value.
---- In a series of expressions

---- Syntax 
---- COALESCE(expression1, expression2[,....n])

	SELECT COALESCE (3+ NULL, 2*NULL,5*2,7);

	SELECT CompanyName, Region, Country,
		City+', '+COALESCE (Region,country)
		AS Location FROM dbo.Suppliers;

---- Using ISNUMERIC

	SELECT Postalcode, ISNUMERIC (Postalcode)
		FROM dbo.Customers;

---- Some non-numeric Characters will Pass

	SELECT ISNUMERIC ('123e4'),ISNUMERIC('123d4'),
		CAST('123e4' AS FLOAT), CAST('123d4' AS FLOAT)

---- Using RAND
---- With an automatic Random Seed,
---- Different numbers every time.
---- Execute Multiple times.

	SELECT RAND(), RAND(), RAND();

---- With a Fixed Seed, 
---- The same series every time.
---- Execute Multiple Times.

	SELECT RAND(456),RAND(),RAND();

---- Using ROUND
---- Syntax
---- ROUND(expression, length[,function])

	SELECT UnitPrice,
		ROUND(UnitPrice, 0) AS RoundedDollars,
		ROUND(UnitPrice,0, 1) AS TruncatedDollars,
		ROUND(UnitPrice, 1) AS ToTensOfCents,
		ROUND(UnitPrice, -1) AS ToTensOfDollars
	FROM dbo.products;

	---- Combining RAND and ROUND

	DECLARE @minID int, @maxID int;
	
	SET @minID=(SELECT MIN(EmployeeID) FROM dbo.Employees);

	SET @maxID=(SELECT MAX(EmployeeID) FROM dbo.Employees);

	SELECT EmployeeID as LuckyID, LastName As LuckyName
		FROM dbo.Employees 
		WHERE EmployeeID=ROUND(@minID + RAND()* (@maxID - @minID)),0);

	------------------
	---- Using REPLACE
	------------------

	---- Syntax
	---- REPLACE (String_expression, String_pattern, String_replacement)

	SELECT QuantityPerUnit,
		REPLACE(QuantityPerUnit,'12','twelve')
			AS Twelve FROM dbo.Products;

	-------------------
	--- Using STUFF----
	-------------------

	--- Syntax
	--- STUFF (expr1, start, length, expr2)

	SELECT STUFF('123456',3,2 'xxxx');

	-------------------------------
	---Using LEN, LEFT and RIGHT---
	-------------------------------

	--- Syntax
	--- LEN (String_expression)
	--- LEFT (String_expression, integer_numchars)
	--- RIGHT (String_expression, integer_numchars)

	SELECT ProductName,
		LEFT(ProductName, LEN(ProductName)-3) AS Lefty,
		RIGHT(ProductName, LEN(ProductName)-3) AS Righty
	FROM dbo.Products;


	----------------------
	--- Using SUBSTRING---
	----------------------

	--- Syntax
	--- SUBSTRING (Value_expression, Start_expression, length_expression)

	SELECT SUBSTRING (FirstName,1,1)+'. '+LastName 
	FROM dbo.Employees;

	---------------------
	---Using CHARINDEX---
	---------------------

	--- Syntax
	--- CHARINDEX (expression1, expression2[, start_Location])

	SELECT HomePhone, 
		CHARINDEX(')',HomePhone) As Startpos
	From dbo.Employees;

	SELECT HomePhone,
		LEFT(HomePhone,CHARINDEX(')',HomePhone)) As AreaCode,
		SUBSTRING(HomePhone, CHARINDEX(')', HomePhone)+2,
		LEN(HomePhone)- CHARINDEX(')',HomePhone)+1) AS Number
	FROM dbo.Employees;

	SELECT ProductName AS TofuProducts
		FROM dbo.Products
		WHERE CHARINDEX('tofu',ProductName)>0;

	--------------------
	---Using PATINDEX---
	--------------------

	--- Syntax
	--- PATINDEX('%Pattern%',expression)
	--- PATINDEX supports wildcards.

	SELECT ProductName, QuantityPerUnit
		FROM dbo.Products
		WHERE PATINDEX('24 - %g pkgs.', QuantityPerUnit)>0;

	SELECT ProductName, QuantityPerUnit
		FROM dbo.Products
		WHERE PATINDEX('24 - __%g pkgs.', QuantityPerUnit)>0;

	--- Using Bracked Values.

	SELECT PostalCode
		FROM dbo.Customers
		WHERE PATINDEX ('%[^0-9]%', PostalCode)=0;

	--- PATINDEX can be used with text, ntext and image columns.

	SELECT CategoryName, Description,
		PATINDEX('%Sweet%',Description)
			AS SweetFoundAt
		FROM dbo.Categories
		WHERE PATINDEX ('%Sweet%',Description)>0;
