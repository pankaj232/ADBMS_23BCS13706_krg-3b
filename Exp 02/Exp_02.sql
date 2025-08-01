--------------------------------------------------Medium Question--------------------------------------
CREATE TABLE EMPLOYEE(
EMP_ID INT primary key,
EMP_NAME VARCHAR(25),
DEPARTMENT VARCHAR(25),
MANAGER_ID INT);

INSERT INTO EMPLOYEE (EMP_ID,EMP_NAME,DEPARTMENT,MANAGER_ID) 
VALUES 
    (1, 'alice', 'hr', NULL),
    (2, 'bob', 'finance', 1),
    (3, 'charlie', 'it', 1),
    (4, 'david', 'finance', 2),
    (5, 'eve', 'it', 3),
    (6, 'frank', 'hr', 1);

SELECT E1.EMP_NAME AS [EMPLOYEE NAME], E2.EMP_NAME AS [MANAGER NAME],
E1.DEPARTMENT AS [EMPLOYEE_DEPT], E2.DEPARTMENT AS [MANAGER_DEPT]
FROM EMPLOYEE AS E1
LEFT OUTER JOIN 
EMPLOYEE AS E2
ON
E1.MANAGER_ID = E2.EMP_ID;

-------------------------------------------------Hard Question---------------------------------------------
CREATE TABLE Year_tbl (
    ID INT,
    YEAR INT,
    NPV INT
);


CREATE TABLE Queries (
    ID INT,
    YEAR INT
);

INSERT INTO Year_tbl (ID, YEAR, NPV)
VALUES
(1, 2018, 100),
(7, 2020, 30),
(13, 2019, 40),
(1, 2019, 113),
(2, 2008, 121),
(3, 2009, 12),
(11, 2020, 99),
(7, 2019, 0);

INSERT INTO Queries (ID, YEAR)
VALUES
(1, 2019),
(2, 2008),
(3, 2009),
(7, 2018),
(7, 2019),
(7, 2020),
(13, 2019);

SELECT y1.ID,y1.YEAR,isnull(y2.NPV,0 )
from Queries as y1
left outer join 
Year_tbl as y2 
on
y1.ID=y2.ID and y1.YEAR=y2.YEAR 