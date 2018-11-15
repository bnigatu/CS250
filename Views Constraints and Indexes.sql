
/*==============================================================================================
 * 1) Constraints in SQL
 *==============================================================================================*/
 -- In SQL Server Constraints help us to maintain integrity of our data by embedding 
 -- those data validation method in the declaration of our table.
/*
 * Primary Key constraint
 * Source: http://blog.reckonedforce.com/primary-key-constraints/
 */
	CREATE TABLE Table1
	(
		Col1 INT IDENTITY,
		Col2 VARCHAR(20)
		--CONSTRAINT pk_table1_col1 PRIMARY KEY (Col1
	);
	go
	--To create a primary key constraint for an existing table
	ALTER TABLE Table1 ADD CONSTRAINT pk_table1_col1 PRIMARY KEY (Col1);

/*
 *Foreign Key constraint
 *Source: http://blog.reckonedforce.com/foreign-key-constraints/
 */
	-- create two new tables
CREATE TABLE tblCourse(
	CourseNumber VARCHAR(20),
	CourseTitle  VARCHAR(100),
	CONSTRAINT pk_Course PRIMARY KEY (CourseNumber)
);
go

-- DROP TABLE tblStudentCourse;
CREATE TABLE tblStudentCourse(	
	StudentID	 INT,
	CourseNumber VARCHAR(20)
);
go

-- Add FOREIGN KEY
ALTER TABLE tblStudentCourse   
ADD CONSTRAINT FK_StudentCourse_Student FOREIGN KEY (StudentID)     
    REFERENCES tblStudent (StudentID); 

-- You can also use SSMS functionality to add relationship   
ALTER TABLE tblStudentCourse   
ADD CONSTRAINT FK_StudentCourse_Course FOREIGN KEY (CourseNumber)     
    REFERENCES tblCourse (CourseNumber)     
    ON DELETE CASCADE  -- optional  
    ON UPDATE CASCADE  -- optional    
;  
go

/*
 * Unique Key constraint
 * Source: http://blog.reckonedforce.com/unique-constraints/
 */
	create TABLE Table5
	(
		Col1 int identity ,
		SSN INT,
		Col2 VARCHAR(20),
		CONSTRAINT uq_SSN UNIQUE (SSN),
		Constraint pk_Col1 Primary Key (Col1)
	);

	-- To add unique key constraint on existing table
	ALTER TABLE Table5 ADD CONSTRAINT uq_col1 UNIQUE (Col1);
	go

	alter table Table5 add Constraint pk_Col1 Primary Key (Col1);
	go
/*
 * Check constraint
 * Source: http://blog.reckonedforce.com/check-constraints/
 */
	CREATE TABLE Table6 
	( 
		Col1 INT identity, 
		Sales int,
		Col2 VARCHAR(20), 
		CONSTRAINT chk_Sales check (Sales>0) 
	); 
	go

	-- To add check constraint on existing table
	ALTER TABLE Table6 ADD CONSTRAINT Chk_Col1 check (Col1>0); 
	go

/*
 * Default constraint
 * Source: http://blog.reckonedforce.com/default-constraints/
 */
	CREATE TABLE Table7
	(
		Col1 INT,
		Col2 VARCHAR(20),
		Col3 BIT NOT NULL
		CONSTRAINT df_col3 DEFAULT (0)
	);

	--To add default constraint on an existing table
	ALTER TABLE Table7 
		ADD CONSTRAINT DF_Col3  DEFAULT (0) FOR Col3;
	go


/*==============================================================================================
 * 2) Indexes
 *==============================================================================================*/

 --There are two major types of Indexes based on on-disk structure (Clustered and Nonclustered).
 --* Clustered indexes sort and store the data rows in the table or view based on their key values. 
 --* Nonclustered index contains key values, and each key-value entry has a pointer to the data row.

 -- A heap is a table without a clustered index. Adding an index to a table optimize a query by reducing I/O operations,
 -- avoiding table scans, 
 --Source: https://docs.microsoft.com/en-us/sql/relational-databases/indexes/clustered-and-nonclustered-indexes-described?view=sql-server-2017

	-- To create a clustered index
	CREATE CLUSTERED INDEX  table7_cal2_3_idx1 
		ON Table7(Col2, Col3);
	go

	-- To create a clustered index
	CREATE NONCLUSTERED INDEX table7_cal1_idx1 
		ON Table7(Col1);
	go

	-- To drop an index
	DROP INDEX table7_cal1_idx1 
		ON Table7;
	GO

	
/*==============================================================================================
 * 3) Create Virtual Tables or VIEWs
 *==============================================================================================*/
 CREATE VIEW View1
 as 
	  SELECT Table6.Col1,
			 Table7.Col2
	  FROM Table6 
	  JOIN Table7 on Table6.Col1 = Table7.Col1;
GO

-- Select from view same way as a table
SELECT *
FROM View1;

