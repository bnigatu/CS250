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
 * Inserte data
 */
--==================================================================================--
-- simple insert
INSERT INTO Customer (CustomerID,FirstName,LastName,Email,[Address])
	VALUES(370,'John','Doe', 'jdoe@ctu.edu','1600 Pennsylvania Avenue');

-- insert for missing columns
INSERT INTO Customer (CustomerID,FirstName,LastName,Email,[Address])
	VALUES(371,'Jane','Doe', 'jadoe@ctu.edu','16th Street Mall');

-- insert with using insert-select
INSERT INTO Customer (CustomerID,FirstName,LastName,Email,[Address])
	SELECT 372,'Tom','Matt', 'tmatt@ctu.edu','156 Colorado blvd';

-- insert with duplicate id (will fail since we have 372)
INSERT INTO Customer (CustomerID,FirstName,LastName,Email,[Address])
	VALUES(372,'Ben','McCain', 'jdoe@ctu.edu','123 Colorado blvd');



-- insert multiple rows using insert values
INSERT INTO Customer (CustomerID,FirstName,LastName,Email,[Address])
	VALUES (373,'Ben','McCain', 'jdoe@ctu.edu','123'),
	       (374,'James','Smith', 'jsmith@ctu.edu','134'),
		   (375,'Nathon','Bond', 'nBond@ctu.edu','167');

-- insert multiple rows using insert values
INSERT INTO Customer (CustomerID,FirstName,LastName,Email,[Address])
	VALUES (373,'Ben','McCain', 'jdoe@ctu.edu','123'),
	       (374,'James','Smith', 'jsmith@ctu.edu','134'),
		   (375,'Nathon','Bond', 'nBond@ctu.edu','167');

-- insert with using insert-select
INSERT INTO Customer (CustomerID,FirstName,LastName,Email,[Address])
	SELECT 376,'Tom','Matt', 'tmatt@ctu.edu','156 Colorado blvd'
	UNION
	SELECT 377,'James','Smith', 'jsmith@ctu.edu','134'
	UNION
	SELECT 378,'Nathon','Bond', 'nBond@ctu.edu','167'

-- insert an order for customer = James Smith
INSERT INTO [Order](OrderID,[OrderDate], Quantity,TotalDue,CustomerID)
	VALUES  (110,'1/28/2019',11,1000,374);

/*
 * Update data
 */
--==================================================================================--

-- update order 110 total due to 2000
UPDATE [Order] SET TotalDue = 2000
WHERE OrderID = 110;


-- update order 110 total due to 3000 and Quantity 111
UPDATE [Order] SET TotalDue = 3000, Quantity=111
WHERE OrderID = 110;

/*
 * Delete data
 */
--==================================================================================--
-- delete customer id = 372
DELETE FROM Customer
WHERE CustomerID = 372;

-- delete customer id = 374
DELETE FROM Customer
WHERE CustomerID = 374;



--==================================================================================--
--- TEST---
select *
from Customer;

select *
from [Order];