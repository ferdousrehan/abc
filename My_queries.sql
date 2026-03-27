/*
Ans: 1 
-----------*/

SELECT * FROM employee
WHERE `salary` =  (SELECT DISTINCT(`salary`) FROM employee ORDER BY `salary` DESC  LIMIT 1 OFFSET 1) LIMIT 3;

-- Formatted
SELECT *
FROM   employee
WHERE  `salary` = (SELECT DISTINCT( `salary` )
                   FROM   employee
                   ORDER  BY `salary` DESC
                   LIMIT  1 offset 1)
LIMIT 3;


/*
Ans: 2 
-----------*/ 

SELECT *
FROM   employee
WHERE  salary = (SELECT DISTINCT salary
                 FROM   employee
                 ORDER  BY salary DESC
                 LIMIT  1 offset 1)
LIMIT  1;


/*
Ans: 3
-----------*/

SELECT AVG(PENDING_BALANCE) AS `Average Pending Balance`, OPEN_BRANCH_ID AS `Open Branch ID`
FROM `account`
WHERE STATUS = 'ACTIVE' && PENDING_BALANCE < 4300
GROUP BY OPEN_BRANCH_ID;

-- Formatted.
SELECT   Avg(pending_balance) AS `Average Pending Balance`,
         open_branch_id       AS `Open Branch ID`
FROM     `account`
WHERE    status = 'ACTIVE' && pending_balance < 4300
GROUP BY open_branch_id;




/*
Ans: D
-----------*/
# Offset-Based Pagination.
SELECT * FROM users ORDER BY id LIMIT 10 OFFSET 10;

# Cursor-Based Paginatio.
SELECT * FROM users WHERE id > 50 ORDER BY id LIMIT 10;

# There are two kinds of pagination in SQL.

  1. Offset-Based Pagination / Page-Based.
  2. Cursor-Based Pagination / Keyset Pagination / Seek Pagination.

1. SQL OFFSET Pagination (Skip and Take)
OFFSET in SQL is a common pagination method that displays data by skipping a certain number of rows, but it can be slow on large datasets.

How it works:
It works using OFFSET and LIMIT. LIMIT 10 means showing the next 10 records and OFFSET 20 means skipping the first 20 records.

Advantages:
It is simple and easy to implement.

Disadvantages:
When we use Offset Paginatio, the database has to scan all the previous records according to Offset number. So if the value of offset is very large for example 1 million records, it slows down the application.

Example:
SELECT * FROM users
ORDER BY id
LIMIT 10 OFFSET 50;

This query shows the next 10 records, skipping first 50 records.


2. Keyset Pagination (Seek Method)
Keyset Pagination (or Seek Method) is an advanced and faster method that loads data using a unique key (ID) of the last viewed record, which improves performance on large tables.

How it works:
The ID of the last seen record or an indexed column is used in the WHERE clause to reach the specified location.

Advantages:
It is very fast even in very large datasets, because it directly uses the index to reach the specified location. It reduces the pressure on the database and speeds up page loading.

Disadvantages:
It is a bit complicated to implement. It only works on unique columns.

Example:

SELECT * FROM users
WHERE id > 50
ORDER BY id
LIMIT 10;

This query shows 10 records which id is greater than 50.



/*
Ans: E
-----------*/

SELECT COUNT(DISTINCT OPEN_BRANCH_ID) AS `Total Branch Number` FROM `account`;