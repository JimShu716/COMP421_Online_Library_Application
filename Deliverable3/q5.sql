/*
The function Read_a_random_book takes the category name as 
the input argument, and then return the name of a random book
from the given category to the customer.
*/
-- DROP FUNCTION Read_a_random_book(varchar(30));
CREATE OR REPLACE FUNCTION Read_a_random_book(cat varchar(30)) 
RETURNS varchar(100) AS $$
DECLARE
	n integer; -- the number of books of the given category.
	temp_row record;
	rand integer;
	rand_book record;
	book_name varchar(100);
	loop_handler integer;
	curs CURSOR for 
		SELECT bname, instore_bookid 
		FROM book WHERE book.category = cat;  
BEGIN
	-- Get n to set the range of the random number
	SELECT COUNT(*) AS n_cat INTO temp_row FROM book WHERE book.category = cat LIMIT 1;
	n = temp_row.n_cat;
	rand = trunc(random() * (n - 1));
	
	-- Loop to get the name of the random book at index rand
	OPEN curs;
	loop_handler = 0;
	LOOP
		FETCH curs INTO rand_book;
		IF loop_handler = rand 
		THEN book_name = rand_book.bname;
		END IF;
		EXIT WHEN (loop_handler >= rand);	
		loop_handler = loop_handler + 1;
	END LOOP;
	RETURN book_name;
END;
$$
LANGUAGE plpgsql;
              -- Function ends here.--
 
/* 
Data Output                            
++++++++++++++++++++++++++++++++++++++++++++++
+---------+
| QUERY 1 |
+---------+
cs421=> SELECT Read_a_random_book('Horror');
     read_a_random_book     
----------------------------
 Mollis Phasellus Institute
(1 row)

++++++++++++++++++++++++++++++++++++++++++++++
+-----------+
| QUERY 1.1 |
+-----------+
cs421=> SELECT Read_a_random_book('Horror');
 read_a_random_book 
--------------------
 Elit Ltd
(1 row)
*/