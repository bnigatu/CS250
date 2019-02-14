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



-- Patern matching
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
where pub_id like 'p0[2-3]'


-- concatination
select [title_name]
      ,[type]
	  ,[title_name]+' ' + [type] as using_plus
	  ,concat([title_name],[type]) as using_concat
from titles

-- substring
select substring([title_name],2,5),[title_name]
from titles;

-- trim
select rtrim(ltrim([title_name]))
from titles;


-- position
SELECT CHARINDEX('A',[title_name]),[title_name]
FROM titles;



/* more examples */

/* To get all rows and columns from authors table*/

SELECT *
FROM [dbo].[authors];


/* Fist name and phone number of the authors*/
SELECT au_fname,phone
FROM [dbo].[authors];


/* Provide the top 3 authors*/
SELECT TOP(3) au_fname,phone
FROM [dbo].[authors];

/* We can do some computation in select clause like find full name */
SELECT au_fname+' '+au_lname as full_name
FROM [dbo].[authors];


/* Find a book/s an author wrote in the past
   we need to join multiple tables to get this information */

SELECT a.au_fname,a.au_lname,t.title_name
FROM dbo.authors as a
join dbo.title_authors as ta on a.au_id = ta.au_id
join dbo.titles as t on t.title_id = ta.title_id


/* Filter only rows for authors that has last name = Hull*/
SELECT a.au_fname,a.au_lname,t.title_name
FROM dbo.authors as a
join dbo.title_authors as ta on a.au_id = ta.au_id
join dbo.titles as t on t.title_id = ta.title_id
WHERE a.au_lname = 'Hull'


/* Find a total number books each publishers published */
SELECT p.pub_id,p.pub_name,COUNT(*) AS count_of_books
FROM [dbo].[publishers] AS p
JOIN [dbo].[titles] AS t ON p.pub_id = t.pub_id
GROUP BY p.pub_id,p.pub_name

/* Display all authors and books  then sort author name 
   in descending and title ascending */
SELECT a.au_fname,a.au_lname,t.title_name
FROM dbo.authors as a
join dbo.title_authors as ta on a.au_id = ta.au_id
join dbo.titles as t on t.title_id = ta.title_id
ORDER BY a.au_lname DESC, t.title_name ASC;

/* Find a publisher that has the most books published */
SELECT TOP(1) p.pub_id,p.pub_name,COUNT(*) AS count_of_books
FROM [dbo].[publishers] AS p
JOIN [dbo].[titles] AS t ON p.pub_id = t.pub_id
GROUP BY p.pub_id,p.pub_name
ORDER BY count_of_books DESC;

--Question
--1) Find a book with the highest book price?
--2) List a book with the highest price for each publisher?
--3) Give the total amount of book prices per a publisher?
--4) List all managers in the organizational stracture that 
--   employee 'E06' reports to?


--Answer
--1)
--2)
SELECT p.pub_id,p.pub_name, max(t.price) as MAX_PRICE
FROM [dbo].[publishers] AS p
JOIN [dbo].[titles] AS t ON p.pub_id = t.pub_id
GROUP BY p.pub_id,p.pub_name
