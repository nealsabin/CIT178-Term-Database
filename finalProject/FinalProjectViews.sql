/*Final Project Views 
View #1
USE myBooks;
GO
-- updatable view --
CREATE VIEW BookRatings
AS
SELECT bk_id, title,rating
FROM Book;
GO

SELECT * FROM BookRatings;

GO UPDATE BookRatings
SET rating = 6
WHERE bk_id = 1;
GO

USE myBooks;
SELECT * FROM BookRatings;

View #2
GO 
CREATE VIEW BookPublishers
AS 
SELECT bk_id,title,pub_id,pub_name
FROM Book JOIN Publisher ON Book.pu_id = Publisher.pub_id;
GO

SELECT * FROM BookPublishers;

View #3
GO 
CREATE VIEW OldBooks
AS
SELECT * FROM Book
WHERE publish_date < '1970';
GO

SELECT * FROM OldBooks;

View #4
GO 
CREATE VIEW BookGenresVIEW
AS 
SELECT title,Genres.genre AS Genre
FROM Book JOIN BookGenres ON Book.bk_id = BookGenres.bk_id
			JOIN Genres ON Genres.gn_id = BookGenres.gn_id;
GO

SELECT * FROM BookGenresVIEW;*/

