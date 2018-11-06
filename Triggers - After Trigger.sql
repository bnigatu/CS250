/*************************************************************************************************
* Author:	Biz Nigatu
*
* Description:	AFTER triggers in SQL Server can only be defined on tables. 
* They are called AFTER triggers because they only execute after a DML operation (INSERT, UPDATE, DELETE) 
* successfully passed all constraints on a table. If a DML statement fails those constraints an 
* AFTER trigger won’t get a chance to execute.Last time in our constraint blog we said that constraint 
* could help us for data validation. It is a good idea to use constraint but we can’t always have 
* the desired flexibility with constraint. Let us see how after triggers could help us to relax this 
* restriction by creating an after trigger to work as a primary key constraint.
* 
* In the next example we will see how we can use after triggers to capture audits logs on customer table.
*
* Notes: Trigers - After Triggers
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


IF object_id('customers', 'U') IS NOT NULL
	DROP TABLE customers;
GO

CREATE TABLE customers 
( -- create customer table
	 id INT
	,firstName VARCHAR(20)
	,lastName VARCHAR(20)
);
GO

IF object_id('customerAudit', 'U') IS NOT NULL
	DROP TABLE customerAudit;
GO

CREATE TABLE customerAudit 
( -- create customer audit table
	 id INT
	,firstName VARCHAR(20)
	,lastName VARCHAR(20)
	,lastUpdated DATETIME
	,operation VARCHAR(20)
	,update_by varchar(50)
);
GO



 
/*
 * Create after triger on all DML operations
 */
IF OBJECT_ID('tr_aft_ins_customers','TR') IS NOT NULL
	DROP TRIGGER tr_aft_ins_customers;
go
	
CREATE TRIGGER tr_aft_ins_customers 
ON dbo.customers
AFTER UPDATE, INSERT, DELETE -- List one or more DML operations separated by comma here
AS
BEGIN 
	if ( @@rowcount = 0 ) RETURN; -- This will exit the trigger if no row is updated by DML
    set nocount on;
	
		IF EXISTS (SELECT * FROM inserted) AND 
		   EXISTS (SELECT * FROM deleted) -- If we have values for both inserted and deleted that means this is UPDATE
		BEGIN
			insert into customerAudit(id,firstName, lastName,lastUpdated,operation,update_by)
				select id, firstName,lastName,GETDATE() AS lastUpdated, 'UPDATE' AS operation, SYSTEM_USER as update_by 
				from inserted;
		END	
		ELSE IF EXISTS (SELECT * FROM inserted) AND 
				NOT EXISTS (SELECT * FROM deleted) -- If we only have values for inserted that means this is INSERT
		BEGIN
			insert into customerAudit(id,firstName, lastName,lastUpdated,operation,update_by)
				select id, firstName,lastName,GETDATE() AS lastUpdated, 'INSERT' AS operation, SYSTEM_USER as update_by 
				from inserted;
		END	
		ELSE IF NOT EXISTS (SELECT * FROM inserted) AND 
				EXISTS (SELECT * FROM deleted) -- If we only have values for deleted that means this is INSERT
		BEGIN
			insert into customerAudit(id,firstName, lastName,lastUpdated,operation,update_by)
				select id, firstName,lastName,GETDATE() AS lastUpdated, 'DELETE' AS operation, SYSTEM_USER as update_by 
				from deleted;
		END	
	
	RETURN;
END
GO

--=======test1========
--assign values to customers for test
insert into customers (id,firstName, lastName)
	values(1,'John','Doe');
 
insert into customers (id,firstName, lastName)
	values(2,'Jane','Doe');

update customers set firstName='Johnny'
where id=1;

delete customers
where id=2;

-- check both tables here
select *
from customers;

select *
from customerAudit;

