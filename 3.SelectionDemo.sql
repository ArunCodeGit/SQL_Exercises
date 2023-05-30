--Selection Demo
--General Format for Naming a Database Object
--Server.database.schema.object
--To refer to Employees table in Northwind Database

SELECT * FROM Employees;  --Specify its location

SELECT * FROM Northwind.dbo.Employees;

-- Don't Specify Server name for local System 
-- Use it in a network

Use Northwind
GO

-- Difference between GO and;

-- ; is used for terminates a SQL Statement Separator

-- GO is used to terminate or close a SQL Batch (ALL declared local variables will retain their values within a batch)

SELECT FirstName, LastName from dbo.Employees;  -- Convenient for accessing Attributes

SELECT * FROM dbo.Employees;

--Concatenating

SELECT LastName+', '+FirstName FROM dbo.Employees;

--Aliasing column names

SELECT LastName+', '+FirstName AS [Full Name] FROM dbo.Employees;

--As is Optional

SELECT LastName+', '+FirstName FullName FROM dbo.Employees;

--Another Aliasing Option

SELECT FullName=LastName+', '+FirstName FROM dbo.Employees;


--This is deprecated

SELECT 'FullName'=LastName+', '+FirstName FROM dbo.Employees;

--Select and Select Distinct Avoids Redudant values

SELECT Title FROM dbo.Employees;

SELECT DISTINCT Title FROM dbo.Employees;

--WHERE

SELECT CompanyName, City FROM dbo.Customers WHERE City='Paris';

--Like and Wildcard Characters

SELECT CompanyName FROM dbo.Customers WHERE CompanyName LIKE 'S%';

SELECT CompanyName FROM dbo.Customers WHERE CompanyName LIKE '%S';

SELECT CompanyName FROM dbo.Customers WHERE CompanyName LIKE '%S%';

--Matching Single Characters

SELECT * FROM dbo.Customers;

SELECT CustomerID FROM dbo.Customers WHERE CustomerID LIKE 'B___P';

--Matching from a list

SELECT CustomerID FROM dbo.Customers WHERE CustomerID LIKE 'FRAN[RK]';

--Specify a Range

SELECT CustomerID FROM dbo.Customers WHERE CustomerID LIKE 'FRAN[A-S]';

--Not Containing 

SELECT CustomerID FROM dbo.Customers WHERE CustomerID LIKE 'FRAN[^R]';

--BETWEEN

SELECT LastName, FirstName, PostalCode FROM dbo.Employees WHERE PostalCode BETWEEN '98103' AND '98999';

--Testing for NULL

SELECT LastName, FirstName, Region FROM dbo.Employees WHERE Region='WA';

SELECT LastName, FirstName, Region FROM dbo.Employees WHERE Region='NULL';


--Three level logic (True, False, NULL)

SELECT LastName, FirstName, Region FROM dbo.Employees WHERE Region IS NULL;

--AND requires both conditions to be True

SELECT LastName, City, PostalCode FROM dbo.Employees WHERE City='Seattle' AND PostalCode LIKE '9%';

--OR Only requires one condition to be True

SELECT LastName, City, PostalCode FROM dbo.Employees WHERE City='Seattle' OR PostalCode LIKE '9%';

--NOT negates the Expression

SELECT LastName, City, PostalCode FROM dbo.Employees WHERE City NOT LIKE 'Seattle';

--Operator Precedence NOT, AND, OR

SELECT LastName, FirstName, City FROM dbo.Employees WHERE LastName LIKE '%S%' AND City NOT LIKE 'Seattle';

SELECT LastName, FirstName, City FROM dbo.Employees WHERE (LastName LIKE '%S%') AND (City NOT LIKE 'Seattle');


--In Clause
--One way to do it

SELECT CustomerID, Country FROM dbo.Customers WHERE Country='France' OR Country ='Spain';

SELECT CustomerID, Country FROM dbo.Customers WHERE Country LIKE 'U%';

--Using IN-- to match in a list of elements 

SELECT CustomerID, Country FROM dbo.Customers WHERE Country IN ('France','Spain');

--NESTED SUBQUERY

SELECT CustomerID, Country FROM dbo.Customers WHERE Country IN (SELECT DISTINCT Country FROM dbo.Customers WHERE Country LIKE 'U%');

--In With a subquery (that returns a list of elements)

SELECT CustomerID FROM dbo.Customers WHERE CustomerID NOT IN (SELECT DISTINCT CustomerID FROM dbo.orders);