/*#1
USE myBooks;
SELECT  MIN(publish_date) AS 'Earliest Publication'
FROM Book;

#2
USE myBooks;
SELECT COUNT(pub_id) AS 'Publisher ID', pub_name AS 'Publisher Name'
FROM Publisher
JOIN Book ON Publisher.pub_id = Book.pu_id
GROUP BY pub_name;

#3
USE myBooks;
SELECT AVG(rating) as Rating
FROM Book;

#4
USE myBooks;
SELECT MAX(publish_date) AS 'Latest Publication'
FROM Book;
*/

