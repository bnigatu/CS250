drop table [order];
go
drop table customer;
GO

CREATE TABLE Customer(
	CustomerID	INT NOT NULL,
	FirstName	VARCHAR(50),
	LastName	VARCHAR(50),
	Email	    VARCHAR(50),
	[Address]	VARCHAR(150), -- In actual design this has to be Street Address, City, State, Zip...
	--CONSTRAINT pk_Customer PRIMARY KEY (CustomerID)
	
);
go

-- Primary Key
ALTER TABLE Customer
	ADD CONSTRAINT pk_Customer PRIMARY KEY(CustomerID);
	go

-- Create order table
CREATE TABLE [Order](
	OrderID		INT NOT NULL,
	OrderDate	DATETIME,
	Quantity	INT,
	TotalDue	MONEY,
	CustomerID	INT
);
go

-- Primary Key
ALTER TABLE [Order]
ADD CONSTRAINT pk_Order PRIMARY KEY(OrderID);
go


-- Add FOREIGN KEY
ALTER TABLE [Order]   
	ADD CONSTRAINT FK_Order_Customer FOREIGN KEY (CustomerID)     
		REFERENCES Customer (CustomerID)     
		--ON DELETE CASCADE  -- optional  
		--ON UPDATE CASCADE;  -- optional    


/*
* Add test data
*/

INSERT INTO Customer (CustomerID,FirstName,LastName,Email,[Address])
	VALUES(367,	'Michelle','Blackwell','mblackwell@ctu.edu','Aurora'),
		  (368, 'Lynn','Allen','lallen@ctu.edu','Denver'),
		  (369, 'Lee','Stout','stout@ctu.edu','Colorado Sprints');
GO

INSERT INTO [Order](OrderID,[OrderDate], Quantity,TotalDue,CustomerID)
	VALUES  (101,'3/1/2011',17,340,367),
			(102,'3/2/2011',47,902,367),
			(103,'3/2/2011',104,1500,369);
GO

-- Let us see what we have so far
SELECT *
FROM Customer;

SELECT *
FROM [Order];

-- Try inserting the following order with order with none existing customer
INSERT INTO [Order](OrderID,[OrderDate], Quantity,TotalDue,CustomerID)
	VALUES  (104,'3/3/2011',22,440,388);

-- Let us now delete CustomerId = 367 and see what happens
DELETE
FROM Customer
WHERE CustomerID = 367;