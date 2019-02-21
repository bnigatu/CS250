/*************************************************************************************************
* Author:	Biz Nigatu
*
* Description:	This script to demonstrate how to create tables in SQL Server
*
* Notes: Lecture 2- Create Tables and Constraints
**************************************************************************************************
* Change History
**************************************************************************************************
* Date:			Author:			Description:
* ----------    ---------- 		--------------------------------------------------
* 01/14/2019	BNigatu			initial version created
*************************************************************************************************
* Usage:
*************************************************************************************************
Execute each batch of the script sequentially
*************************************************************************************************/

/*==============================================================================================
 * 1) Drop table if it exists then create a table. 
 *==============================================================================================*/


-- Check if table exist then drop table
-- !WARNING! for a production code make sure you don't include a drop table code
IF OBJECT_ID('Student','U') IS NOT NULL
	DROP TABLE Student;
go

-- create table
CREATE TABLE Student(
	StudentID INT NOT NULL IDENTITY,
	FirstName VARCHAR(20),
	LastName  VARCHAR(20),
	Email	  VARCHAR(50),
	CONSTRAINT PK_Student PRIMARY KEY(StudentID)
);
go

/*==============================================================================================
 * 2) Create a table then alter the table and add constraints
 *==============================================================================================*/
IF OBJECT_ID('dbo.Class') IS NOT NULL
	DROP TABLE dbo.Class;
go
CREATE TABLE dbo.Class(
	ClassID		INT NOT NULL IDENTITY,
	Title		VARCHAR(50),
	[Date]		DATE,
	ClassRoom	VARCHAR(20),
	Capacity	INT,
	
);
go

ALTER TABLE  dbo.Class ADD CONSTRAINT PK_Class PRIMARY KEY(ClassID);
go

/*==============================================================================================
 * 3) Create a table that holds many-to-many relationship and alter and add foreign key
 *==============================================================================================*/

IF OBJECT_ID('StudentClass') IS NOT NULL
	DROP TABLE StudentClass;
go
CREATE TABLE StudentClass(
	ClassID INT,
	StudentID INT,
	CONSTRAINT PK_StudentClass PRIMARY KEY(ClassID,StudentID)
);
go

-- Add foreign key between StudentClass and Class tables
ALTER TABLE StudentClass ADD CONSTRAINT fk_StudentClass_Class 
	FOREIGN KEY (ClassID) REFERENCES Class (ClassID);

-- Add foreign key between StudentClass and Student tables
ALTER TABLE StudentClass ADD CONSTRAINT fk_StudentClass_Student 
	FOREIGN KEY (StudentID) REFERENCES Student (StudentID);


/*==============================================================================================
 * 4) Insert a record in a table
 *==============================================================================================*/
--insert 

INSERT INTO Student([FirstName],[LastName],[Email])
	VALUES('James','Bond', 'james.bond@colordotech.edu'),
	('Jason','Bourn','jason.bourn@coloradotech.edu'),
	('Jessica','Jones','jessica.jones@coloradotech.edu'),
	('Ethan','Hunt','ethan.hunt@coloradotech.edu');

INSERT INTO Class([Title],[Date],[ClassRoom],[Capacity])
	VALUES('Fundamental database','10/10/2018','R415',20),
	      ('SQL','10/10/2018','R415',10);

INSERT INTO StudentClass(StudentID,ClassID)
	VALUES(1,1),
		  (2,2),
		  (3,2),
		  (4,2),
		  (2,1),
		  (3,1);

/*==============================================================================================
 * 5) Query from a table/s exmaple
 *==============================================================================================*/
-- select from student table
select *
from Student;

-- select from class table
select *
from Class;

-- select from student table
select *
from StudentClass;

-- select from all table by joining them. Use AS key word to alias tables
select s.*,c.*
from StudentClass as sc 
join Class as c on c.ClassID = sc.ClassID
join Student as s on s.StudentID = sc.StudentID;


