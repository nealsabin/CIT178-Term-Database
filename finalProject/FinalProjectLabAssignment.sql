/* Final Project Procedures 
-- Retrieves and displays data
USE myBooks;	
GO
CREATE PROC spAuthors
AS
SELECT * FROM Author
ORDER BY au_lname;
GO

EXEC spAuthors;

--Takes an input parameter
USE myBooks;
GO
ALTER PROC spFindBookTitle
	@Title varchar(50) = '%'
AS
BEGIN
	SELECT title AS Title,YEAR(publish_date) AS 'Year Published',rating AS Rating
	FROM Book
	WHERE title LIKE @Title;
END 
GO

EXEC spFindBookTitle '%Dun%';

--One input, multiple outputs
USE myBooks;
GO
CREATE PROC spBookInfo
	@BookId int,
	@Title varchar(50) OUTPUT,
	@PubDate datetime OUTPUT,
	@Publisher varchar(50) OUTPUT
AS SELECT @BookId = bk_id, @Title = title, @PubDate = publish_date, @Publisher = pub_name
FROM Book JOIN Publisher ON Book.pu_id = Publisher.pub_id
WHERE bk_id = @BookId;
GO

DECLARE @BookId int;
DECLARE @Title varchar(50);
DECLARE @PubDate datetime;
DECLARE @Publisher varchar(50);
EXEC spBookInfo 2, @Title OUTPUT, @PubDate OUTPUT, @Publisher OUTPUT;
SELECT @Title AS 'Book Title', YEAR(@PubDate) AS 'Year Published', @Publisher AS Publisher;

-- Stored procedure that has a return value 
USE myBooks;
GO
CREATE PROC spBookCount
AS 
DECLARE @BookCount int;
SELECT @BookCount = COUNT(*)
FROM Book
RETURN @BookCount;
GO

DECLARE @BookCount int;
EXEC @BookCount = spBookCount;
PRINT 'Current book count is ' + CONVERT(varchar, @BookCount) + '.';
GO
*/
/* Final Project User Defined Functions 
USE myBooks;
GO
CREATE FUNCTION fnGetTitle
	(@Title varchar(50) = '%')
	RETURNS int
BEGIN
	RETURN (SELECT bk_id FROM Book WHERE title LIKE @Title);
END;

GO 
SELECT bk_id,title, rating FROM Book
WHERE bk_id = dbo.fnGetTitle('%Lord%');

--Table function
USE myBooks;
GO
CREATE FUNCTION fnBook
		(@BookID int)
		RETURNS table
RETURN
		(SELECT * FROM Book WHERE @BookID = Book.bk_id);

select * FROM dbo.fnBook(2);
*/
/* Final Project Triggers 
USE myBooks;
SELECT bk_id,title INTO BookArchive
FROM Book;

CREATE TABLE BookLog(
	bk_id int,
	status varchar(30)
);

--Delete Trigger
CREATE TRIGGER Book_DELETE ON Book
	AFTER DELETE
AS
BEGIN
	SET NOCOUNT ON;
	DECLARE @bk_id int
	DECLARE @title varchar(30)
	SELECT @bk_id = DELETED.bk_id, @title = DELETED.title
	FROM DELETED

	INSERT INTO BookArchive
	VALUES(@bk_id,@title,'Deleted')
END

--inserting record to be deleted
--INSERT INTO Book(bk_id,title,publish_date,pu_id,rating) VALUES(30,'Test',NULL,1,0);
--DELETE FROM Book WHERE bk_id = 30;
USE myBooks;
select * from BookArchive;

--Insert Trigger
CREATE TRIGGER Book_INSERT ON Book
	AFTER INSERT
AS
BEGIN	
	SET NOCOUNT ON;
	DECLARE @bk_id int
	DECLARE @title varchar(30)
	SELECT @bk_id = INSERTED.bk_id, @title = INSERTED.title
	FROM INSERTED

	INSERT INTO BookArchive
	VALUES(@bk_id,@title,'Inserted')
END

--Testing insert
--INSERT INTO Book(bk_id,title,publish_date,pu_id,rating) VALUES(31,'Test',NULL,1,0);
--DELETE FROM Book WHERE bk_id = 31;
--select * from BookArchive;

--Update Trigger
CREATE TRIGGER Book_UPDATE ON Book
	AFTER UPDATE
AS
BEGIN	
	SET NOCOUNT ON;
	DECLARE @bk_id int
	DECLARE @title varchar(30)
	SELECT @bk_id = INSERTED.bk_id, @title = INSERTED.title
	FROM INSERTED

	INSERT INTO BookArchive
	VALUES(@bk_id,@title,'Updated')
END

--Testing update
INSERT INTO Book(bk_id,title,publish_date,pu_id,rating) VALUES(32,'Test',NULL,1,0);
--DELETE FROM Book WHERE bk_id = 31;

GO
UPDATE Book
Set bk_id = 33
WHERE title = '32';
GO 
select * from BookArchive;
*/
