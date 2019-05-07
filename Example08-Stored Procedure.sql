/*************************************************************************************************
* Author:	Biz Nigatu
*
* Description:	This script is created tables and stored procedures to show data insert.
*
* Notes: Stored Procedure
**************************************************************************************************
* Change History
**************************************************************************************************
* Date:			Author:			Description:
* ----------    ---------- 		--------------------------------------------------
* 11/19/2018	BNigatu			initial version created
*************************************************************************************************
* Usage:

EXEC pr_InsertEmployee @fName = 'John', 
                       @lName = 'Doe', 
					   @positon = 'Manager', 
					   @streetAddress= '123 E Aurora St', 
					   @countryName= 'USA' ;
go

SELECT *
FROM employee;

SELECT *
FROM location;

SELECT *
FROM country;

*************************************************************************************************
Execute each batch of the script sequentially
*************************************************************************************************/

--CREATE DATABASE Sample
--go

use test;
go

/*==============================================================================================
 * 1) Create three tables to capture employee info
 *==============================================================================================*/
IF OBJECT_ID('employee','U') IS NULL
CREATE TABLE employee 
  ( 
     employee_id INT PRIMARY KEY NOT NULL IDENTITY, 
     first_name  VARCHAR(50), 
     last_name   VARCHAR(50), 
     position VARCHAR(50) 
  ); 
go 

IF OBJECT_ID('location','U') IS NULL
CREATE TABLE [location] 
  ( 
     location_id     INT PRIMARY KEY NOT NULL IDENTITY, 
     street_address VARCHAR(100), 
     e_id     INT FOREIGN KEY REFERENCES employee(employee_id) 
  ); 
go

IF OBJECT_ID('country','U') IS NULL
CREATE TABLE country 
  ( 
     country_id      INT PRIMARY KEY NOT NULL IDENTITY, 
     country_name	 VARCHAR(50), 
     l_id            INT FOREIGN KEY REFERENCES [location](location_id) 
  ) 
go

/*==============================================================================================
 * 2) Create Stored Procedure
 *==============================================================================================*/
IF OBJECT_ID('pr_InsertEmployee','P') IS NOT NULL
	DROP PROCEDURE pr_InsertEmployee;
GO
CREATE PROCEDURE pr_InsertEmployee   (@fName          VARCHAR(50), 
									  @lName          VARCHAR(50),
									  @positon		 VARCHAR(50), 
									  @streetAddress  VARCHAR(100), 
									  @countryName	 VARCHAR(50)) 
AS 
	-- Declare variables
	DECLARE @Employee_ID INT =0;
	DECLARE @Location_ID INT =0;
BEGIN 
      -- Insert into employee table
	  INSERT INTO employee(first_name,
						   last_name,
						   position) 
      VALUES     (@fName, 
                  @lName,				 
				  @positon); 
	  
	  -- caputre the new identity value
      --set @Employee_ID = @@identity; 
	  set @Employee_ID  =  IDENT_CURRENT('dbo.employee')
	  
	  -- Insert into location table
      INSERT INTO [location] (street_address, e_id)
      VALUES     (@streetAddress, 
                  @Employee_ID) 
	  
	  -- caputre the new identity value
      --set @Location_ID  = SCOPE_IDENTITY(); 
	  set @Location_ID  =  IDENT_CURRENT('dbo.location')
	  -- Insert into location table
      INSERT INTO country (country_name, l_id)
      VALUES     (@countryName, 
                  @Location_ID) 
  END 
go


-- Exercise 

--write a stored procedure that will accept publisher name
--and return all title names that were published by that publisher


IF OBJECT_ID('pr_SelectPublisherTitles','P') IS NOT NULL
	DROP PROCEDURE pr_SelectPublisherTitles;
go
CREATE PROCEDURE pr_SelectPublisherTitles (@pub_name varchar(20))
AS
	SELECT t.title_name
	FROM [dbo].[publishers] as p
	JOIN [dbo].[titles] as t on p.pub_id = t.pub_id
	WHERE p.pub_name = @pub_name;
go

exec pr_SelectPublisherTitles @pub_name='Schadenfreude Press';

-- Exercise 2
-- create a procedure that will insert a value to a publisher table


IF OBJECT_ID('pr_InsertPublisher','P') IS NOT NULL
	DROP PROCEDURE pr_InsertPublisher;
go
CREATE PROCEDURE pr_InsertPublisher (@pub_name varchar(20),
								     @city varchar(15),
									 @state char(2),
									 @country varchar(15))
AS
	DECLARE @pub_id varchar(10);
	select top 1 @pub_id = 'P'+ cast(right(pub_id,len(pub_id)-1) + 1 as varchar(9))
	from publishers
	order by pub_id desc;

	INSERT INTO [dbo].[publishers] (pub_id,pub_name,city,state,country)
	VALUES(@pub_id, @pub_name,@city,@state,@country);
go

exec pr_InsertPublisher @pub_name='CTU',
					    @city='Aurora',
						@state='CO',
						@country='USA';