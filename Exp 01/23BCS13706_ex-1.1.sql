--/Problem Title: Author-Book Relationship Using Joins and Basic SQL Operations
--/Design two tables — one for storing author details and the other for book details.
--/Ensure a foreign key relationship from the book to its respective author.Insert at 
--/least three records in each table.
--/Perform an INNER JOIN to link each book with its author using the common author ID.
--/Select the book title, author name, and author’s country.

CREATE TABLE TBL_AUTHOR
(
	AUTHOR_ID INT PRIMARY KEY,
	AUTHOR_NAME VARCHAR(MAX),
	COUNTRY VARCHAR(MAX)
)

CREATE TABLE TBL_BOOKS
(
	BOOK_ID INT PRIMARY KEY,
	BOOK_TITLE VARCHAR(MAX),
	AUTHORID INT  
	FOREIGN KEY (AUTHORID) REFERENCES TBL_AUTHOR(AUTHOR_ID)
)

INSERT INTO TBL_AUTHOR (AUTHOR_ID, AUTHOR_NAME, COUNTRY) VALUES
(1, 'George Orwell', 'United Kingdom'),
(2, 'Haruki Murakami', 'Japan'),
(3, 'J.K. Rowling', 'United Kingdom');

INSERT INTO TBL_BOOKS (BOOK_ID, BOOK_TITLE, AUTHORID) VALUES
(101, '1984', 1),
(102, 'Kafka on the Shore', 2),
(103, 'Harry Potter', 3);

SELECT B.BOOK_TITLE AS 'BOOK TITLE' , A.AUTHOR_NAME, A.COUNTRY
FROM TBL_BOOKS AS B
INNER JOIN 
TBL_AUTHOR AS A
ON 
B.AUTHORID = A.AUTHOR_ID




