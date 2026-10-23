CREATE DATABASE booksdb;

USE booksdb;

SELECT * FROM books
SELECT * FROM customers
SELECT * FROM orders

-- 1) Retrieve all books in the "Fiction" genre
SELECT title FROM books 
	WHERE genre = 'fiction'

--1.a)Retrieve number of fiction books
SELECT COUNT(*) AS fiction_books
FROM books
	WHERE genre = 'fiction'      

--2) Find books published after the year 1950 
SELECT * FROM books
	WHERE published_year > 1950

--3) List all customers from the Canada 
SELECT * FROM customers
	WHERE country = 'canada'

--4) Show orders placed in November 2023 
SELECT 
	DATENAME(MONTH, order_date) AS Month,
	DATEPART(YEAR,order_date) AS year,
	COUNT(order_id) AS orders_placed
FROM Orders
GROUP BY DATENAME(MONTH, order_date),
			DATEPART(YEAR,order_date) 
HAVING DATENAME(MONTH, order_date) = 'November' AND
			DATEPART(YEAR,order_date) = '2023'


--5) Retrieve the total stock of books available 
SELECT SUM(stock) AS Total_stock 
FROM books

--6) Find the details of the most expensive book 
SELECT TOP 1 * FROM books
	ORDER BY price DESC

SELECT * FROM books 
	WHERE price=(SELECT 
		MAX(price) FROM books)

--7) Show all customers who ordered more than 1 quantity of a book 
SELECT Customer_ID, quantity FROM orders
	WHERE quantity > 1

--8) Retrieve all orders where the total amount exceeds $20 
SELECT * FROM Orders
	WHERE total_amount > 20

--9) List all genres available in the Books table 
SELECT genre FROM books
	GROUP BY genre	

--10) Find the book with the lowest stock 
SELECT TOP 4 * FROM books
	ORDER BY stock ASC

--11) Calculate the total revenue generated from all orders
SELECT 
FORMAT(SUM(CONVERT(FLOAT,total_amount))/1000,'N2')+ 'k' AS revenue 
FROM Orders

-- Advanced queries 
--1)Retrieve the total number of books sold for each genre
SELECT b.genre, 
	SUM(o.quantity) AS books_sold
FROM orders o
	JOIN books b 
	ON b.book_id = o.book_id
GROUP BY b.genre
ORDER BY SUM(o.quantity) DESC

--2) Find the average price of books in the "Fantasy" genre 
SELECT genre,
	FORMAT(AVG(price),'N2') AS Avg_price
FROM books
GROUP BY genre
HAVING genre = 'Fantasy'

--3) List customers who have placed at least 2 orders 
SELECT c.customer_id, c.name ,
COUNT(o.order_id) AS order_count
FROM Orders o
	JOIN Customers c 
	ON c.Customer_ID=o.Customer_ID
GROUP BY c.customer_id, c.name
HAVING COUNT(o.order_id) >=2

--3.a) List customers who have placed orders more than four times
SELECT c.customer_id, c.name ,
COUNT(o.order_id) AS order_count
FROM Orders o
	JOIN Customers c 
	ON c.Customer_ID=o.Customer_ID
GROUP BY c.customer_id, c.name
HAVING COUNT(o.order_id) >4

--3.b) List customers who have placed orders BETWEEN 3  and 4 times
SELECT c.customer_id, c.name ,
COUNT(o.order_id) AS order_count
FROM Orders o
	JOIN Customers c 
	ON c.Customer_ID=o.Customer_ID
GROUP BY c.customer_id, c.name
HAVING COUNT(o.order_id) BETWEEN 3 AND 4

--4) Find the most frequently ordered book 
SELECT TOP 1 WITH TIES  b.title,b.genre, b.author,
COUNT(o.Order_id) AS purchased 
FROM orders o
	JOIN books b
	ON b.book_id=o.book_id
GROUP BY b.title,b.genre,b.author
ORDER BY COUNT(o.Order_id) DESC

--4.a) Find the book with the highest total quantity purchased
SELECT TOP 1 b.title,b.genre,b.author, 
SUM(o.quantity) AS purchased 
FROM orders o
	JOIN books b
	ON b.book_id=o.book_id
GROUP BY b.title,b.genre,b.author
ORDER BY SUM(o.quantity) DESC 

--5) Show the top 3 most expensive books of 'Fantasy' Genre
WITH expensivebook AS (
	SELECT title,genre,FORMAT(price,'N2') AS Cost,
	DENSE_RANK() OVER (PARTITION BY genre ORDER BY price DESC) AS Ranking
	FROM books)
SELECT * FROM expensivebook
WHERE Ranking <= 3 AND genre = 'Fantasy'

--6)Retrieve the total quantity of books sold by each author
SELECT  b.Author,
SUM(o.Quantity) AS purchased 
FROM orders o
	JOIN books b
	ON b.book_id=o.book_id
GROUP BY b.Author
ORDER BY SUM(o.Quantity) DESC

--6.a)Retrieve the author with the most book sold 
SELECT TOP 1 WITH TIES b.Author,
SUM(o.Quantity) AS purchased 
FROM orders o
	JOIN books b
	ON b.book_id=o.book_id
GROUP BY b.Author
ORDER BY SUM(o.Quantity) DESC

--7) List the cities where customers who spent over $30 are located 
SELECT C.Customer_ID,c.city,FORMAT(o.total_amount, 'N2') AS spending
FROM Orders o
	JOIN Customers c 
	ON c.Customer_ID = o.Order_ID
WHERE total_amount >= 30

--8) Find the customer who spent the most on orders 
SELECT TOP 1 c.name,ROUND(o.total_amount, 2)AS spending
FROM Orders o
	JOIN Customers c 
	ON c.Customer_ID = o.Order_ID
ORDER BY spending DESC

--9) Calculate the stock remaining after fulfilling all orders
SELECT b.book_id, b.title,b.stock, COALESCE(SUM(o.quantity),0) AS sold,
b.stock-COALESCE(SUM(o.quantity),0) AS remaining_stock
FROM books b
LEFT JOIN Orders o 
ON o.Book_ID=b.Book_ID
GROUP BY b.book_id,b.stock,b.Title
ORDER BY b.book_id


--10) Calculate monthly sales performance
SELECT 
DATENAME(MONTH,order_date) AS months,
ROUND(SUM(total_amount), 2)AS revenue,
COUNT(order_id) AS orders,
SUM(quantity) AS books_sold
FROM Orders
GROUP BY DATENAME(MONTH,order_date)
ORDER BY SUM(total_amount) DESC;
		

--11) books at risk of running out of stock
WITH stock_details AS ( 
	SELECT b.book_id, b.title,b.stock, COALESCE(SUM(o.quantity),0) AS sold,
	b.stock-COALESCE(SUM(o.quantity),0) AS remaining_stock
	FROM books b
LEFT JOIN Orders o 
ON o.Book_ID=b.Book_ID
GROUP BY b.book_id,b.stock,b.Title),
--SELECT * FROM books_at_risk
stocks_needed AS (
	SELECT s.book_id,s.title,s.stock,s.sold,s.remaining_stock,
		CASE 
			WHEN s.remaining_stock <= 0 THEN 'Out of stock'
			WHEN s.remaining_stock <= 10 THEN 'Less stock'
		ELSE 'Sufficient stock'
	END AS stocksdetails
	FROM stock_details s)
SELECT * FROM stocks_needed;

--12) Find the highest-spending customer in each country 
WITH Country_spending AS (	
	SELECT c.country,c.name,
	FORMAT(SUM(total_amount),'N2') AS spending, 
	DENSE_RANK() OVER (PARTITION BY c.country ORDER BY SUM(total_amount) DESC) AS ranking
	FROM orders
		JOIN Customers c 
		ON c.Customer_ID=Order_ID
	GROUP BY
	c.country,c.name)
SELECT * FROM Country_spending
WHERE ranking = 1

