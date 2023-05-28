						-----------------------------
					-------TABLE CREATION--------
					-----------------------------

	CREATE TABLE Employee(EmpId INT PRIMARY KEY NOT NULL, EmpName VARCHAR(50) NOT NULL, EmpAge INT);
	
	INSERT INTO Employee VALUES(1,'Arun',22)
	INSERT INTO Employee VALUES(2,'Kumar',23)
	INSERT INTO Employee VALUES(3,'Jaga',25)

	SELECT * FROM Employee WHERE EmpId=3;

	SELECT * FROM Employee;

	CREATE TABLE Student(StudId INT IDENTITY(101,1) NOT NULL PRIMARY KEY, StudName VARCHAR(50),StudAge INT);
	
	INSERT INTO Student VALUES('Arun','19');
	INSERT INTO Student VALUES('Kumar','20');
	INSERT INTO Student VALUES('Yoga','26');
	
	SELECT * FROM Student;

	CREATE TABLE Customer(CustId INT PRIMARY KEY NOT NULL, CustName VARCHAR(50) NOT NULL, CustPhone VARCHAR(50), CustDOB DATETIME);
	
	INSERT INTO Customer VALUES(101,'Arun',9087535295,'19970515');
	INSERT INTO Customer VALUES(102,'Kumar',9087535296,'19870418');
	INSERT INTO Customer VALUES(103,'Jaga',9087535297,'19970226');
	
	SELECT * FROM Customer;

	CREATE TABLE studmark(studid INT NOT NULL, examtype VARCHAR(50) NOT NULL, examyear int NOT NULL, mark INT PRIMARY KEY(studid,examtype,examyear));
	INSERT INTO studmark VALUES(3301,'FirstMidTerm',2019,75);
	INSERT INTO studmark VALUES(3302,'FirstMidTerm',2019,55);
	INSERT INTO studmark VALUES(3303,'FirstMidTerm',2019,70);
	
	SELECT * FROM StudMark;

						-------------------
						----CONSTRAINTS----
						-------------------

	CREATE TABLE Cars(CarId VARCHAR(50) NOT NULL PRIMARY KEY, CarColor VARCHAR(20) NOT NULL DEFAULT 'White',CarPrice INT NOT NULL CHECK(CarPrice>100000),RegNo VARCHAR(50) NOT NULL UNIQUE)

	INSERT INTO Cars VALUES(121,'Red', 120000,'12345');
	INSERT INTO Cars(CarId,CarPrice,RegNo) values(123,150900,'12456');
	INSERT INTO Cars VALUES(125,'Grey', 900000,'13567');
	
	SELECT * FROM Cars;

						-------------
						---UPDATE----
						-------------
	
	UPDATE Cars SET CarPrice=168000 WHERE CarId=121;

	UPDATE Cars SET CarPrice=250000 WHERE CarId=123;

						----------------
						----DELETE------
						----------------

	DELETE FROM Cars WHERE CarId=123;

	DROP TABLE Cars;

	TRUNCATE TABLE Cars;