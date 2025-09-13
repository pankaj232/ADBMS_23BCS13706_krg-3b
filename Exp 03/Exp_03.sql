CREATE DATABASE EXP3_SUB_QUERIES;

USE EXP3_SUB_QUERIES;

-- EASY

CREATE TABLE TBL_EMPLOYEE (
	EMP_ID INT
);

INSERT INTO TBL_EMPLOYEE
VALUES
(2), (4), (4), (6), (6), (7), (8), (8);


SELECT * FROM TBL_EMPLOYEE;

SELECT MAX(EMP_ID)
FROM TBL_EMPLOYEE
WHERE EMP_ID IN 
(SELECT EMP_ID FROM TBL_EMPLOYEE GROUP BY EMP_ID HAVING COUNT(EMP_ID) = 1);


-- PRACTICE SET
CREATE TABLE TBL_PRODUCTS
(
	ID INT PRIMARY KEY IDENTITY,
	[NAME] NVARCHAR(50),
	[DESCRIPTION] NVARCHAR(250) 
)

CREATE TABLE TBL_PRODUCTSALES
(
	ID INT PRIMARY KEY IDENTITY,
	PRODUCTID INT FOREIGN KEY REFERENCES TBL_PRODUCTS(ID),
	UNITPRICE INT,
	QUALTITYSOLD INT
)

INSERT INTO TBL_PRODUCTS VALUES ('TV','52 INCH BLACK COLOR LCD TV')
INSERT INTO TBL_PRODUCTS VALUES ('LAPTOP','VERY THIIN BLACK COLOR ACER LAPTOP')
INSERT INTO TBL_PRODUCTS VALUES ('DESKTOP','HP HIGH PERFORMANCE DESKTOP')


INSERT INTO TBL_PRODUCTSALES VALUES (3,450,5)
INSERT INTO TBL_PRODUCTSALES VALUES (2,250,7)
INSERT INTO TBL_PRODUCTSALES VALUES (3,450,4)
INSERT INTO TBL_PRODUCTSALES VALUES (3,450,9)


SELECT *FROM TBL_PRODUCTS
SELECT *FROM TBL_PRODUCTSALES

-- TASK 01-> FIND THE ID, NAME, DESCRIPTION OF PRODUCT WHICH HAS NOT BEEN SOLD FOR ONCE.
-- OUTPUT1: ID , NAME, DESCRIPTION


SELECT ID, NAME, DESCRIPTION
FROM TBL_PRODUCTS
WHERE ID NOT IN
(SELECT B.PRODUCTID from TBL_PRODUCTSALES AS B
GROUP BY B.PRODUCTID 
HAVING COUNT(B.QUALTITYSOLD) >= 1)


-- or

select id, name, description
from TBL_PRODUCTS
where id not in 
(select distinct productid from TBL_PRODUCTSALES)



-- TASK02 -> FIND THE TOTAL QUANTITY SOLD FOR EACH RESPECTIVE PRODUCT
-- OUTPUT: NAME  QTY_SOLD (SUM)
--          A       15
-- YOU WILL USE SQ IN SELECT CLAUSE


SELECT A.NAME,(SELECT SUM(QUALTITYSOLD) FROM TBL_PRODUCTSALES WHERE PRODUCTID = A.ID) AS 'QTY SOLD'
FROM TBL_PRODUCTS AS A;




/*

---------------- SET OPERATIONS IN SQL ----------------

SET = TABLE

OPERATION:
1. UNION
2. UNION ALL
3. INTERSECT (INNER JOIN)
4. (A-B): EXCEPT



RULES:
1. WHICHEVER COLUMN INVOLVED IN THE OPERATION MUST HAVE SAME DATATYPE

select * from a
union
select * from b;

select id, name from a
union 
select name, id from b;

*/


-------------------------- Medium --------------------------------
CREATE TABLE department (
    id INT PRIMARY KEY,
    dept_name VARCHAR(50)
);

-- Create Employee Table
CREATE TABLE employee (
    id INT,
    name VARCHAR(50),
    salary INT,
    department_id INT,
    FOREIGN KEY (department_id) REFERENCES department(id)
);


-- Insert into Department Table
INSERT INTO department (id, dept_name) VALUES
(1, 'IT'),
(2, 'SALES');

-- Insert into Employee Table
INSERT INTO employee (id, name, salary, department_id) VALUES
(1, 'JOE', 70000, 1),
(2, 'JIM', 90000, 1),
(3, 'HENRY', 80000, 2),
(4, 'SAM', 60000, 2),
(5, 'MAX', 90000, 1);


Select d.dept_name, e.name, e.salary
from
employee as e
inner join 
department d
on e.department_id = d.id
where e.salary in 
(select max(salary) from
employee group by department_id);

-- or


Select e.name, d.dept_name, e.salary 
from
employee as e
inner join 
department d
on e.department_id = d.id
where e.salary in 
(Select max(salary) from 
employee where department_id = e.department_id)
order by d.dept_name;


-- HARD: GIVEN TWO TABLES OUTPUT THEM AS FOLLOWS:

CREATE TABLE TBL_A (
	EMP_ID INT PRIMARY KEY,
	E_NAME VARCHAR(20),
	SALARY INT
);

CREATE TABLE TBL_B (
	EMP_ID INT PRIMARY KEY,
	E_NAME VARCHAR(20),
	SALARY INT
);

INSERT INTO TBL_A
VALUES
	(1, 'AA', 1000),
	(2, 'BB', 300);

INSERT INTO TBL_B
VALUES
	(2, 'BB', 400),
	(3, 'CC', 100);

/*
OUTPUT- 
EMP_ID E_NAME SALARY
1       AA      1000
2       BB      300 (MIN)
3       CC      100
*/

SELECT EMP_ID, E_NAME, MIN(SALARY)
FROM(
SELECT * FROM TBL_A AS A
UNION ALL
SELECT * FROM TBL_B AS B
) AS RES
GROUP BY EMP_ID, E_NAME;