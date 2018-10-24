USE books;
go

/* SELECT clause */
-- select from all columns
SELECT *
FROM dbo.employees;

-- select specific column
SELECT emp_id,emp_name
FROM dbo.employees;

-- mathematical operations
SELECT (2+3) * 5 AS math;

/* ORDER clause */
-- ASC = ascending
-- DESC = descending
SELECT [au_id]
      ,[au_fname]
      ,[au_lname]
      ,[phone]
      ,[address]
      ,[city]
      ,[state]
      ,[zip]
FROM [dbo].[authors]
ORDER BY au_lname DESC, au_fname ASC;

/* WHERE clause */
--  =, >, <, >=, <=, (<> !=) different from
SELECT [au_id]
      ,[au_fname]
      ,[au_lname]
      ,[phone]
      ,[address]
      ,[city]
      ,[state]
      ,[zip]
FROM [dbo].[authors]
WHERE [state] != 'CO';

-- BOOLEAN operators AND, OR, NOT
SELECT [au_id]
      ,[au_fname]
      ,[au_lname]
      ,[phone]
      ,[address]
      ,[city]
      ,[state]
      ,[zip]
FROM [dbo].[authors]
WHERE [state] = 'CA' OR
	  [state]='CO';

--WHERE [state] = 'CA' AND
--	  [city]='San Francisco';
-- null in where clause
SELECT *
FROM dbo.employees
WHERE boss_id IS NOT NULL;
-- boss_id IS NULL


-- LIKE operator in a WHERE clause
SELECT [au_id]
      ,[au_fname]
      ,[au_lname]
      ,[phone]
      ,[address]
      ,[city]
      ,[state]
      ,[zip]
FROM [dbo].[authors]
WHERE [au_fname] LIKE '%H';
-- LIKE '____H';


SELECT * 
FROM authors
where au_fname = ''



-- BETWEEN operators
SELECT TOP 1000 [title_id]
      ,[title_name]
      ,[type]
      ,[pub_id]
      ,[pages]
      ,[price]
      ,[sales]
      ,[pubdate]
      ,[contract]
  FROM [books].[dbo].[titles]
  WHERE [pubdate] BETWEEN '01-01-2000' AND '12-31-2000'

/* GROUP BY */

-- Aggregate
SELECT COUNT([au_id]) AS [count_of_authors]
FROM [dbo].[authors];

-- COUNT BY STATE

SELECT [state], COUNT([au_id]) AS [count_of_authors]
FROM [dbo].[authors]
GROUP BY [state];


/* HAVING*/

SELECT [state], COUNT([au_id]) AS [count_of_authors]
FROM [dbo].[authors]
GROUP BY [state]
HAVING COUNT([au_id]) >=2;


/* Questions*/


-- Find books that have more than 500 pages
SELECT [title_id]
      ,[title_name]
      ,[type]
      ,[pub_id]
      ,[pages]
      ,[price]
      ,[sales]
      ,[pubdate]
      ,[contract]
FROM [dbo].[titles]
where [pages] >500;
-- Find history books
SELECT [title_id]
      ,[title_name]
      ,[type]
      ,[pub_id]
      ,[pages]
      ,[price]
      ,[sales]
      ,[pubdate]
      ,[contract]
FROM [dbo].[titles]
where [type] = 'history';
-- Find books that was published between 2000 and 2001
SELECT [title_id]
      ,[title_name]
      ,[type]
      ,[pub_id]
      ,[pages]
      ,[price]
      ,[sales]
      ,[pubdate]
      ,[contract]
FROM [dbo].[titles]
where [pubdate] BETWEEN '01-01-2000' AND '12-31-2001';

-- Find count of books that was published by year
SELECT YEAR([pubdate]) AS pub_year,
	   COUNT([title_id]) AS count_of_books
FROM [dbo].[titles]
GROUP BY YEAR([pubdate]) ;

-- find the top saling book
SELECT 
      [title_name],      
      [sales] AS top_sales_book_dollar
      
FROM [dbo].[titles]
WHERE [sales] = (SELECT max([sales]) AS top_sales_book_dollar
				 FROM [dbo].[titles]
				 );


-- Find books that their number of pages are unknown

SELECT [title_id]
      ,[title_name]
      ,[type]
      ,[pub_id]
      ,[pages]
      ,[price]
      ,[sales]
      ,[pubdate]
      ,[contract]
FROM [dbo].[titles]
where [pages] is null;

-- Find the cheapest and most expensive books
SELECT *
FROM [dbo].[titles]
where price = (select max(price) FROM [dbo].[titles]) or
	  price = (select min(price) FROM [dbo].[titles]) ;

