/*************************************************************************************************
* Author:	Biz Nigatu
*
* Description:	INSTEAD Of triggers in SQL Server fires instead of the DML event (INSERT, UPDATE, DELETE) 
* it is associated with. It only executes once per one each DML statement no matter how many rows are 
* going to be affected. It is possible to create INSTEAD OF triggers on tables and views, but they are 
* commonly used with view. The reason for this is it helps us to curb the restrictions on view that we 
* could only update on base table or no table at all if there are some aggregations used in the view.
* Triggers are part of a transition they are executed under and rolling back of a transaction reset all 
* changes made by triggers. Since triggers are a special form of stored procedure they support RETURN 
* statement to exit from trigger.
*
* Notes: Trigers - Instead Of Triggers
**************************************************************************************************
* Change History
**************************************************************************************************
* Date:			Author:			Description:
* ----------    ---------- 		--------------------------------------------------
* 11/05/2018	BNigatu			initial version created
*************************************************************************************************
* Usage:
*************************************************************************************************
Execute each batch of the script sequentially
*************************************************************************************************/

/*
 * Original MySQL script https://github.com/phpcontrols/inventory-manager/blob/master/db/InventoryManager_2017-06-22.sql
 */
use master;
DROP DATABASE IF EXISTS inventory;
CREATE DATABASE inventory;
GO

use inventory;
GO

/*
 * Products
 */

DROP TABLE

IF EXISTS Products;
CREATE TABLE Products (
	id INT NOT NULL
	,ProductName VARCHAR(255) 
	,PartNumber VARCHAR(255) 
	,ProductLabel VARCHAR(255) 
	,StartingInventory INT 
	,InventoryReceived INT 
	,InventoryShipped INT 
	,InventoryOnHand INT 
	,MinimumRequired INT 
	,PRIMARY KEY (id)
);

INSERT INTO Products (
	 id
	,ProductName
	,PartNumber
	,ProductLabel
	,StartingInventory
	,InventoryReceived
	,InventoryShipped
	,InventoryOnHand
	,MinimumRequired
	)
VALUES
	(1,'Dell Server','XP 2000','Dell Server- XP 2000',100007,35,25,100,15),
	(2,'Google Chromebooks','1','Google Chromebooks- 1.0',100,75,654,479,20),
	(3,'Cisco Router','10X','Cisco Router- 10X',45,143,76,89,88),
	(4,'Hitachi Compute Blade 2500 GG-RE4xx','21','sadasd- 21',25,0,0,25,10),
	(5,'Compaq Proliant ML350 ','37','Semih- 37',1,12,5,8,5),
	(6,'Crazy horse router','123DF5','crazy horse router- 123DF5',5,23,0,28,1),
	(7,'Monitors','','Monitors - 999',0,0,0,0,0),
	(8,'LaserJet 2055dn','123','TEST- 123',10,0,0,10,10),
	(9,'LaserJet 4250tn','bob-1','bob- bob-1',500,412,267,6450,400),
	(10,'Multimeter','c345','Multimeter- c345',3,28,29,4,4),
	(11,'ImageRunner 4570','54334','dfgdf- 54334',0,0,300,300,0),
	(12,'UniBox','1','UniBox- 1',200,0,0,400,300),
	(13,'MX-5001N','123456','Test 1- 123456',50,1234,0,1284,10),
	(14,'QuickBooks Pro','57456','Toby- 57456',567,22,12,56467,577),
	(15,'Office Standard','sdsdsad','sdsad- sdsdsad',12,0,0,12,12),
	(16,'Acme Switch','55555','test- 55555',500,12,0,512,25),
	(17,'Firewalls','362436','Firewalls- 362436',5,33,900,862,10),
	(18,'Cables','7734','Cables- 7734',9,475,9000,100,16),
	(19,'Dell OS10','1','Test- 001',25,0,0,222,25);


/*
 * Orders
 */
DROP TABLE

IF EXISTS Orders;
CREATE TABLE Orders (
	 id INT NOT NULL
	,Title VARCHAR(255) 
	,[First] VARCHAR(255) 
	,Middle VARCHAR(255) 
	,[Last] VARCHAR(255) 
	,ProductId INT NOT NULL
	,NumberShipped INT 
	,OrderDate DATE 
	,PRIMARY KEY (id)
	,CONSTRAINT order_product_fk FOREIGN KEY (ProductId) REFERENCES Products(id)
);


INSERT INTO Orders (
	 id
	,Title
	,[First]
	,Middle
	,[Last]
	,ProductId
	,NumberShipped
	,OrderDate
	)
VALUES

	(1,'','Suzy','','Customer',3,10,'2014-04-01'),
	(2,'','Suzy','','Customer',3,20,'2014-04-22'),
	(3,'','Ben','','Thomas',1,5,'2014-04-11'),
	(4,'','Johnny','','Test',3,10,'2014-04-02'),
	(5,'','Steve','','Smith',1,20,'2014-04-15'),
	(6,'','Steve','','Palmer',3,3,'2014-02-22'),
	(7,'','Tim','','Scott',3,5,'2014-03-22'),
	(8,'','Dave','','Boyd',3,10,'2014-01-22'),
	(9,'','Suzy','','Customer',2,30,'2014-01-21'),
	(10,'','Dylan','','Test',3,5,'2014-04-23'),
	(11,'','Betty','','Fryar',3,12,'2014-04-22'),
	(12,'','Jerry','','Sellers',2,124,'2014-04-22'),
	(13,'','BOB','','SMITH',2,500,'2014-05-11'),
	(14,'','Suzy','','Customer',5,5,'2015-04-07'),
	(15,'','Suzy','','Customer',9,50,'2015-04-07'),
	(16,'','Suzy','','Customer',3,1,'2015-04-07'),
	(17,'','Suzy','','Customer',10,5,'2015-09-09'),
	(18,'','john','','lemeasure',10,12,'2016-02-05'),
	(19,'','Suzy','','Customer',9,2,'2017-02-25'),
	(20,'','','','',9,1,'2017-01-15'),
	(21,'','llkjh','','kjlkh',11,250,'2017-02-15'),
	(22,'','Suzy','','Customer',16,14,'2017-04-05'),
	(23,'','Suzy','','Customer',11,50,'2017-06-05'),
	(24,'','Suzy','','Customer',9,200,'2017-06-05'),
	(25,'','Test','','Cowley',14,12,'2017-11-05'),
	(26,'','Elvis','','P',17,900,'2017-04-05'),
	(27,'','Elvis','','P',18,9000,'2017-06-05'),
	(28,'','','','',4,0,'2017-04-05');

/* 
 * Suppliers 
 */
DROP TABLE

IF EXISTS Suppliers;
	CREATE TABLE Suppliers (
		id INT NOT NULL
		,supplier VARCHAR(255) NOT NULL DEFAULT ''
		,PRIMARY KEY (id)
		);


INSERT INTO Suppliers (
	 id
	,supplier
	)
VALUES
	(1,'ShockWave Tech'),
	(2,'CDW'),
	(3,'ACME Tech Supplies');

/* 
 * Purchases 
 */
DROP TABLE IF EXISTS Purchases;

CREATE TABLE Purchases (
	 id INT NOT NULL
	,SupplierId INT NOT NULL
	,ProductId INT NOT NULL
	,NumberReceived INT NOT NULL
	,PurchaseDate DATE NOT NULL
	,PRIMARY KEY (id)
	,CONSTRAINT purchase_product_fk FOREIGN KEY (ProductId) REFERENCES Products(id)
	,CONSTRAINT purchase_supplier_fk FOREIGN KEY (SupplierId) REFERENCES Suppliers(id)
);


INSERT INTO Purchases (id, SupplierId, ProductId, NumberReceived, PurchaseDate)
VALUES
	(1,2,2,50,'2014-11-02'),
	(2,2,1,15,'2014-09-02'),
	(3,3,3,10,'2014-11-12'),
	(4,2,2,25,'2014-01-02'),
	(5,2,3,20,'2014-02-22'),
	(6,1,1,5,'2015-11-02'),
	(7,3,3,3,'2014-01-02'),
	(8,1,3,20,'2015-11-11'),
	(9,2,1,0,'2014-11-02'),
	(10,1,1,5,'2016-11-02'),
	(11,2,5,12,'2016-11-02'),
	(12,2,3,90,'2016-11-02'),
	(13,1,6,23,'2016-08-02'),
	(14,2,10,25,'2017-11-02'),
	(15,2,10,3,'2017-11-02'),
	(16,1,10,0,'2017-01-02'),
	(17,1,2,0,'2017-02-22'),
	(18,2,1,10,'2017-03-02'),
	(19,2,9,12,'2017-03-03'),
	(20,2,13,1234,'2017-05-12'),
	(21,1,12,0,'2017-05-22'),
	(22,1,13,0,'2017-06-12'),
	(23,2,3,0,'2017-08-02'),
	(24,3,9,400,'2017-10-02'),
	(25,1,14,0,'2017-11-02'),
	(26,2,16,12,'2017-11-30'),
	(27,1,3,0,'2017-07-02'),
	(28,3,17,33,'2017-07-12'),
	(29,1,18,453,'2017-07-23'),
	(30,2,18,22,'2017-11-02');
GO

/*
 * Check Constraint example
 */

select
	 o.id 
	,o.Title 
	,o.[First] 
	,o.Middle 
	,o.[Last] 
	,p.ProductName 
	,o.NumberShipped 
	,o.OrderDate
from Orders as o
join Products as p on o.ProductId = p.id;



-- check inventory on hand is greater than minumum required
ALTER TABLE Products 
	ADD CONSTRAINT chkInventoryOnHand CHECK (InventoryOnHand >= MinimumRequired);

-- Assume we have an order for two Cisco routers a sale and update the InventoryOnHand
-- products table
select * 
from Products;
-- orders table
select * 
from Orders;

INSERT INTO Orders (
	 id
	,Title
	,[First]
	,Middle
	,[Last]
	,ProductId
	,NumberShipped
	,OrderDate
	)
VALUES
	(29,'MR.','John','Doe','Customer',3,2,GETDATE());

UPDATE Products SET InventoryOnHand = (InventoryOnHand-2)
WHERE ID = 3; -- ID = 3 is 'Cisco Router'

/*
 * Instead Of Triger example
 */

-- Now let us do the previous two operations safely using one operation using the help
-- of Instead of Triggers.


-- Create inistead of INSERT trigger on Orders table
if object_id('tr_in_of_in_orders','TR') is not null
	drop trigger tr_in_of_in_orders;
go	
create trigger tr_in_of_in_orders 
on dbo.Orders
instead of insert
as
begin
     set nocount on; 
     if exists( select 1 from inserted)
	 begin
		-- Operation 1
		insert into Orders
			select * from inserted;

		-- Operation 2
		update p set p.InventoryOnHand = (p.InventoryOnHand - i.NumberShipped)
		from inserted i join Products p
			on i.ProductId = p.id
	end
	return;
end
go

-- Now, assume we sold 10 Dell Servers


INSERT INTO Orders (
	 id
	,Title
	,[First]
	,Middle
	,[Last]
	,ProductId
	,NumberShipped
	,OrderDate
	)
VALUES
	(30,'MR.','John','Doe','Customer',1,10,GETDATE());
go
-- products table
select * 
from Products;
-- orders table
select * 
from Orders;