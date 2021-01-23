/* Please uncomment the line below if the table created in this funciton is not dropped due to previous tests. */
 DROP TABLE affordable_book;

/*
This function affordable_books takes an input parameter budget and create a new table named affordable_book.
The table affordable_book tells the names of all books whose price is lower than the input parameter budget 
on the marketplace. It also shows that the number of each book that is currently in stock (the sum of the number in all stores).
*/

CREATE OR REPLACE FUNCTION affordable_books(budget int)
RETURNS void AS $$
--cursor
DECLARE curs CURSOR FOR 
  	SELECT DISTINCT bname
  	FROM book WHERE price <= budget;

DECLARE  a_book  RECORD;
DECLARE temp_row RECORD;
DECLARE platform_stock INT;

BEGIN
	OPEN curs;
	CREATE TABLE affordable_book(
		bname VARCHAR(100) NOT NULL,
	    platform_stock INT NOT NULL,
		PRIMARY KEY(bname)
	);
	
	
	--Loop starts
	LOOP
    	FETCH curs INTO a_book;
    	EXIT WHEN NOT FOUND;
		platform_stock = 0;
		FOR temp_row IN SELECT * FROM book
		LOOP
			IF temp_row.price <= budget AND temp_row.bname = a_book.bname THEN
				platform_stock = platform_stock + temp_row.stock_status;
			END IF;
		END LOOP;
    	INSERT INTO "affordable_book" (bname,platform_stock) VALUES (a_book.bname, platform_stock);
	END LOOP;
	--Loop ends
	CLOSE curs;
END;
$$ LANGUAGE plpgsql;

/* 
Data Output
++++++++++++++++++++++++++++++++++++
+---------+
| QUERY 1 |
+---------+
cs421=> SELECT affordable_books(5);
 affordable_books 
------------------
 
(1 row)

+---------+
| QUERY 2 |
+---------+
cs421=> SELECT * FROM affordable_book;
          bname           | platform_stock 
--------------------------+----------------
 Elit Ltd                 |             10
 Feugiat Corporation      |             10
 Cursus Purus Corporation |             10
 Arcu Eu Odio Foundation  |             10
(4 rows)
*/