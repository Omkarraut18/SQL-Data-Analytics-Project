
-- ADVANCED SQL QUESTIONS & ANSWERS

-- 1) Retrieve the total number of books sold for each genre:

SELECT 
    books.genre,
    SUM(orders.quantity) AS total_books_sold
FROM books
INNER JOIN orders 
ON books.book_id = orders.book_id
GROUP BY books.genre;


-- 2) Find the average price of books in the "Fantasy" genre:

SELECT 
    AVG(price) AS average_fantasy_price
FROM books
WHERE genre = 'Fantasy';


-- 3) List customers who have placed at least 2 orders:

SELECT 
    customers.customer_id,
    customers.name,
    COUNT(orders.order_id) AS total_orders
FROM customers
INNER JOIN orders
ON customers.customer_id = orders.customer_id
GROUP BY customers.customer_id, customers.name
HAVING COUNT(orders.order_id) >= 2;


-- 4) Find the most frequently ordered book:

SELECT 
    books.book_id,
    books.title,
    COUNT(orders.order_id) AS order_count
FROM books
INNER JOIN orders
ON books.book_id = orders.book_id
GROUP BY books.book_id, books.title
ORDER BY order_count DESC
LIMIT 1;


-- 5) Show the top 3 most expensive books of 'Fantasy' Genre:

SELECT 
    book_id,
    title,
    price
FROM books
WHERE genre = 'Fantasy'
ORDER BY price DESC
LIMIT 3;


-- 6) Retrieve the total quantity of books sold by each author:

SELECT 
    books.author,
    SUM(orders.quantity) AS total_books_sold
FROM books
INNER JOIN orders
ON books.book_id = orders.book_id
GROUP BY books.author;


-- 7) List the cities where customers who spent over $30 are located:

SELECT DISTINCT
    customers.city
FROM customers
INNER JOIN orders
ON customers.customer_id = orders.customer_id
GROUP BY customers.city
HAVING SUM(orders.total_amount) > 30;


-- 8) Find the customer who spent the most on orders:

SELECT 
    customers.customer_id,
    customers.name,
    SUM(orders.total_amount) AS total_spent
FROM customers
INNER JOIN orders
ON customers.customer_id = orders.customer_id
GROUP BY customers.customer_id, customers.name
ORDER BY total_spent DESC
LIMIT 1;


-- 9) Calculate the stock remaining after fulfilling all orders:

SELECT 
    books.book_id,
    books.title,
    books.stock,
    COALESCE(SUM(orders.quantity),0) AS sold_quantity,
    books.stock - COALESCE(SUM(orders.quantity),0) AS remaining_stock
FROM books
LEFT JOIN orders
ON books.book_id = orders.book_id
GROUP BY books.book_id, books.title, books.stock;