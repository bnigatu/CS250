





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
--1) Find a book with the highest book price
--2) List a book with the highest price for each publisher
