
--Q2--

CREATE TABLE Customer(
	email VARCHAR(100) NOT NULL UNIQUE,
	address VARCHAR(100) NOT NULL UNIQUE,
	cname VARCHAR(30) NOT NULL UNIQUE,
	phone_number VARCHAR(100) NOT NULL UNIQUE,
	PRIMARY KEY(email)
);
/*

           Table "cs421g06.customer"
    Column    |          Type          | Modifiers
--------------+------------------------+-----------
 email        | character varying(100) | not null
 address      | character varying(100) | not null
 cname        | character varying(30)  | not null
 phone_number | character varying(100) | not null
Indexes:
    "customer_pkey" PRIMARY KEY, btree (email)
    "customer_address_key" UNIQUE CONSTRAINT, btree (address)
    "customer_cname_key" UNIQUE CONSTRAINT, btree (cname)
    "customer_phone_number_key" UNIQUE CONSTRAINT, btree (phone_number)
Referenced by:
    TABLE "bill" CONSTRAINT "bill_email_fkey" FOREIGN KEY (email) REFERENCES customer(email)
    TABLE "cart" CONSTRAINT "cart_email_fkey" FOREIGN KEY (email) REFERENCES customer(email)
    TABLE "member" CONSTRAINT "member_address_fkey" FOREIGN KEY (address) REFERENCES customer(address)
    TABLE "member" CONSTRAINT "member_cname_fkey" FOREIGN KEY (cname) REFERENCES customer(cname)
    TABLE "member" CONSTRAINT "member_email_fkey" FOREIGN KEY (email) REFERENCES customer(email)
    TABLE "member" CONSTRAINT "member_phone_number_fkey" FOREIGN KEY (phone_number) REFERENCES customer(phone_number)
    TABLE "savedlist" CONSTRAINT "savedlist_email_fkey" FOREIGN KEY (email) REFERENCES customer(email)
*/

CREATE TABLE Member(
	email VARCHAR(100) NOT NULL UNIQUE,
	address VARCHAR(100) NOT NULL,
	cname VARCHAR(30) NOT NULL,
	phone_number VARCHAR(100) NOT NULL,
	username VARCHAR(100) NOT NULL,
	password VARCHAR(100) NOT NULL,
	PRIMARY KEY(email),
	
	FOREIGN KEY (email) REFERENCES Customer(email),
	FOREIGN KEY (address)REFERENCES Customer(address),
	FOREIGN KEY (cname)REFERENCES Customer(cname),
	FOREIGN KEY (phone_number)REFERENCES Customer(phone_number)
);

/*
          Table "cs421g06.member"
    Column    |          Type          | Modifiers
--------------+------------------------+-----------
 email        | character varying(100) | not null
 address      | character varying(100) | not null
 cname        | character varying(30)  | not null
 phone_number | character varying(100) | not null
 username     | character varying(100) | not null
 password     | character varying(100) | not null
Indexes:
    "member_pkey" PRIMARY KEY, btree (email)
Foreign-key constraints:
    "member_address_fkey" FOREIGN KEY (address) REFERENCES customer(address)
    "member_cname_fkey" FOREIGN KEY (cname) REFERENCES customer(cname)
    "member_email_fkey" FOREIGN KEY (email) REFERENCES customer(email)
    "member_phone_number_fkey" FOREIGN KEY (phone_number) REFERENCES customer(phone_number)


*/

CREATE TABLE SavedList(
	savedlist_id SERIAL NOT NULL UNIQUE,
	email VARCHAR(100) NOT NULL UNIQUE,
	PRIMARY KEY(savedlist_id),
	FOREIGN KEY (email)REFERENCES Customer(email)
	
);

/*

                                        Table "cs421g06.savedlist"
    Column    |          Type          |                            Modifiers
--------------+------------------------+------------------------------------------------------------------
 savedlist_id | integer                | not null default nextval('savedlist_savedlist_id_seq'::regclass)
 email        | character varying(100) | not null
Indexes:
    "savedlist_pkey" PRIMARY KEY, btree (savedlist_id)
    "savedlist_email_key" UNIQUE CONSTRAINT, btree (email)
Foreign-key constraints:
    "savedlist_email_fkey" FOREIGN KEY (email) REFERENCES customer(email)
Referenced by:
    TABLE "cart" CONSTRAINT "cart_savedlist_id_fkey" FOREIGN KEY (savedlist_id) REFERENCES savedlist(savedlist_id)


*/

CREATE TABLE cart(
	cartId SERIAL NOT NULL UNIQUE ,
	savedlist_id INTEGER NOT NULL,
	total_cost INTEGER NOT NULL ,
	email VARCHAR(100) NOT NULL UNIQUE,
	
	PRIMARY KEY(cartId),
	FOREIGN KEY (email)REFERENCES Customer(email),
	FOREIGN KEY (savedlist_id)REFERENCES SavedList(savedlist_id)
	
);

/*

                                     Table "cs421g06.cart"
    Column    |          Type          |                       Modifiers
--------------+------------------------+-------------------------------------------------------
 cartid       | integer                | not null default nextval('cart_cartid_seq'::regclass)
 savedlist_id | integer                | not null
 total_cost   | integer                | not null
 email        | character varying(100) | not null
Indexes:
    "cart_pkey" PRIMARY KEY, btree (cartid)
    "cart_email_key" UNIQUE CONSTRAINT, btree (email)
Foreign-key constraints:
    "cart_email_fkey" FOREIGN KEY (email) REFERENCES customer(email)
    "cart_savedlist_id_fkey" FOREIGN KEY (savedlist_id) REFERENCES savedlist(savedlist_id)


*/

CREATE TABLE Bill(
	payment_id SERIAL NOT NULL UNIQUE,
	payment_type VARCHAR(100) NOT NULL ,
	final_amount_paid INTEGER NOT NULL ,
	email VARCHAR(100) NOT NULL ,
	cartId INTEGER NOT NULL,
	PRIMARY KEY(payment_id),
	FOREIGN KEY (cartId) REFERENCES cart(cartId),
	FOREIGN KEY (email) REFERENCES Customer(email)
);


/*
                                         Table "cs421g06.bill"
      Column       |          Type          |                         Modifiers
-------------------+------------------------+-----------------------------------------------------------
 payment_id        | integer                | not null default nextval('bill_payment_id_seq'::regclass)
 payment_type      | character varying(100) | not null
 final_amount_paid | integer                | not null
 email             | character varying(100) | not null
 cartid            | integer                | not null
Indexes:
    "bill_pkey" PRIMARY KEY, btree (payment_id)
Foreign-key constraints:
    "bill_email_fkey" FOREIGN KEY (email) REFERENCES customer(email)


*/

CREATE TABLE Warehouse(
	
	warehouse_id SERIAL NOT NULL UNIQUE,
	address VARCHAR(100) NOT NULL ,
	phone VARCHAR(100) NOT NULL ,
	PRIMARY KEY (warehouse_id)

);

/*
    Table "cs421g06.warehouse"
    Column    |          Type          |                            Modifiers
--------------+------------------------+------------------------------------------------------------------
 warehouse_id | integer                | not null default nextval('warehouse_warehouse_id_seq'::regclass)
 address      | character varying(100) | not null
 phone        | character varying(100) | not null
Indexes:
    "warehouse_pkey" PRIMARY KEY, btree (warehouse_id)

*/


CREATE TABLE Store
(
	sid SERIAL NOT NULL UNIQUE,
	sname VARCHAR(100) NOT NULL,
	location VARCHAR(100) NOT NULL,
	PRIMARY KEY (sid)
);

/*

                                 Table "cs421g06.store"
  Column  |          Type          |                      Modifiers
----------+------------------------+-----------------------------------------------------
 sid      | integer                | not null default nextval('store_sid_seq'::regclass)
 sname    | character varying(100) | not null
 location | character varying(100) | not null
Indexes:
    "store_pkey" PRIMARY KEY, btree (sid)
Referenced by:
    TABLE "book" CONSTRAINT "book_sid_fkey" FOREIGN KEY (sid) REFERENCES store(sid)


*/



CREATE TABLE Book(
	sid INTEGER NOT NULL,	
	instore_bookId SERIAL NOT NULL UNIQUE,
	bname VARCHAR(100) NOT NULL,
	category VARCHAR(30) NOT NULL ,
	author VARCHAR(100) NOT NULL,
	publisher VARCHAR(100) NOT NULL,
	stock_status INTEGER NOT NULL,
	price INTEGER NOT NULL,
	ISBN VARCHAR(100) NOT NULL,
	

	PRIMARY KEY (instore_bookId),
	FOREIGN KEY (sid) REFERENCES Store(sid)
	
);

/*
                                          Table "cs421g06.book"
     Column     |          Type          |                           Modifiers
----------------+------------------------+---------------------------------------------------------------
 sid            | integer                | not null
 instore_bookid | integer                | not null default nextval('book_instore_bookid_seq'::regclass)
 bname          | character varying(100) | not null
 category       | character varying(30)  | not null
 author         | character varying(100) | not null
 publisher      | character varying(100) | not null
 stock_status   | integer                | not null
 price          | integer                | not null
 isbn           | character varying(100) | not null
Indexes:
    "book_pkey" PRIMARY KEY, btree (instore_bookid)
Foreign-key constraints:
    "book_sid_fkey" FOREIGN KEY (sid) REFERENCES store(sid)

*/

CREATE TABLE Review(
	sid INTEGER NOT NULL,
	instore_bookId INTEGER NOT NULL,
	review_id INTEGER NOT NULL ,
	rate INTEGER NOT NULL,
	comment VARCHAR NOT NULL,

	PRIMARY KEY (review_id,instore_bookID),
	FOREIGN KEY (sid) REFERENCES Store(sid),
	FOREIGN KEY (instore_bookID) REFERENCES Book(instore_bookID)
	
);

/*
            Table "cs421g06.review"
     Column     |       Type        | Modifiers
----------------+-------------------+-----------
 sid            | integer           | not null
 instore_bookid | integer           | not null
 review_id      | integer           | not null
 rate           | integer           | not null
 comment        | character varying | not null
Indexes:
    "review_pkey" PRIMARY KEY, btree (review_id, instore_bookid)

*/

CREATE TABLE added(

	sid INTEGER NOT NULL,
	cartId INTEGER NOT NULL,
	instore_bookId INTEGER NOT NULL,
	quantity INTEGER NOT NULL,
	cost INTEGER NOT NULL,
	
	PRIMARY KEY (sid,cartId,instore_bookId),
	FOREIGN KEY (sid) REFERENCES Store(sid),
	FOREIGN KEY(cartId) REFERENCES cart(cartId),
	FOREIGN KEY (instore_bookId) REFERENCES Book(instore_bookID)
	
);

/*
        Table "cs421g06.added"
     Column     |  Type   | Modifiers
----------------+---------+-----------
 sid            | integer | not null
 cartid         | integer | not null
 instore_bookid | integer | not null
 quantity       | integer | not null
 cost           | integer | not null
Indexes:
    "added_pkey" PRIMARY KEY, btree (sid, cartid, instore_bookid)

*/


CREATE TABLE contain(

	savedList_id INTEGER NOT NULL,
	instore_bookId INTEGER NOT NULL,
	sid INTEGER NOT NULL,

	
	PRIMARY KEY (savedList_id,instore_bookId,sid),
	FOREIGN KEY (sid) REFERENCES Store(sid),
	FOREIGN KEY(savedList_id) REFERENCES SavedList(savedList_id),
	FOREIGN KEY (instore_bookId) REFERENCES Book(instore_bookID)
	
);

/*
       Table "cs421g06.contain"
     Column     |  Type   | Modifiers
----------------+---------+-----------
 savedlist_id   | integer | not null
 instore_bookid | integer | not null
 sid            | integer | not null
Indexes:
    "contain_pkey" PRIMARY KEY, btree (savedlist_id, instore_bookid, sid)

*/

CREATE TABLE stock(

	warehouse_id INTEGER NOT NULL,
	sid INTEGER NOT NULL,

	
	PRIMARY KEY (sid,warehouse_id),
	FOREIGN KEY (sid) REFERENCES Store(sid),
	FOREIGN KEY (warehouse_id) REFERENCES Warehouse(warehouse_id)
	
);
/*
       Table "cs421g06.stock"
    Column    |  Type   | Modifiers
--------------+---------+-----------
 warehouse_id | integer | not null
 sid          | integer | not null
Indexes:
    "stock_pkey" PRIMARY KEY, btree (sid, warehouse_id)

*/



--Q3--
INSERT INTO "review" (sid,instore_bookId,review_id,rate,comment) VALUES (1,1,1,1,'Morbi accumsan laoreet ipsum. Curabitur consequat, lectus sit amet luctus vulputate, nisi sem');
-- INSERT 0 1 --
INSERT INTO "review" (sid,instore_bookId,review_id,rate,comment) VALUES (1,1,2,1,'Nunc ac');
-- INSERT 0 1 -- 
INSERT INTO "review" (sid,instore_bookId,review_id,rate,comment) VALUES (1,1,3,3,'erat');
-- INSERT 0 1 --
INSERT INTO "review" (sid,instore_bookId,review_id,rate,comment) VALUES (1,1,4,1,'at pretium aliquet, metus urna convallis erat, eget tincidunt dui augue eu tellus. Phasellus elit pede,');
-- INSERT 0 1 --
INSERT INTO "review" (sid,instore_bookId,review_id,rate,comment) VALUES (1,2,5,3,'Etiam vestibulum massa rutrum magna. Cras convallis convallis dolor. Quisque tincidunt pede ac urna. Ut tincidunt');
-- INSERT 0 1 --
SELECT * FROM Review;
/*
 sid | instore_bookid | review_id | rate |                                                      comment                                                      
-----+----------------+-----------+------+-------------------------------------------------------------------------------------------------------------------
   1 |              1 |         1 |    1 | Morbi accumsan laoreet ipsum. Curabitur consequat, lectus sit amet luctus vulputate, nisi sem
   1 |              1 |         2 |    1 | Nunc ac
   1 |              1 |         3 |    3 | erat
   1 |              1 |         4 |    1 | at pretium aliquet, metus urna convallis erat, eget tincidunt dui augue eu tellus. Phasellus elit pede,
   1 |              2 |         5 |    3 | Etiam vestibulum massa rutrum magna. Cras convallis convallis dolor. Quisque tincidunt pede ac urna. Ut tincidunt
*/



--Q4--
-- customer
INSERT INTO "customer" (email,address,cname,phone_number) VALUES ('vulputate.mauris.sagittis@enimcommodo.net','131-5431 Elit, Street','Ulla Lynch','1-384-294-9288'),('sit@vulputate.org','Ap #217-2875 Pede. Street','Travis Stevens','1-687-986-3101'),('fames.ac.turpis@risus.ca','P.O. Box 463, 6955 Convallis Rd.','Wyoming Fox','1-749-181-1217'),('Cras.vulputate.velit@pede.com','P.O. Box 840, 1044 Quam. Street','Kelsie Roberson','1-102-338-7354'),('urna@velit.net','P.O. Box 164, 4428 Diam. Av.','TaShya Slater','1-474-351-0977');
INSERT INTO "customer" (email,address,cname,phone_number) VALUES ('massa.Quisque@risus.net','P.O. Box 544, 9698 Tempus Ave','Danielle Franks','1-372-216-1521'),('et@pharetraNam.net','316-4244 Volutpat. Avenue','Desirae Fields','1-134-418-7097'),('nibh.sit.amet@quamCurabiturvel.co.uk','198 Vel Road','Darius Ray','1-399-942-6870'),('eleifend.non@dui.net','810-1269 Aenean Av.','Carly Higgins','1-981-637-0881'),('dignissim.magna.a@lectusrutrumurna.net','142-9715 Non, St.','Cody Lynch','1-898-461-1138');
INSERT INTO "customer" (email,address,cname,phone_number) VALUES ('eu.augue.porttitor@variusultrices.co.uk','Ap #596-833 Vivamus St.','Hayden Baldwin','1-916-234-0731'),('commodo@adipiscingMauris.ca','2816 Turpis St.','Martena Higgins','1-670-544-9379'),('libero@mollisIntegertincidunt.co.uk','268-7364 At Avenue','Bernard Jenkins','1-261-162-8365'),('non@luctusut.ca','2297 Id, Road','Maggie Callahan','1-176-307-4120'),('nec@sed.org','1474 Eget Ave','Tamara Rosa','1-840-105-7344');
INSERT INTO "customer" (email,address,cname,phone_number) VALUES ('nec@lacus.edu','P.O. Box 747, 9814 Vehicula. St.','Yardley Hull','1-161-203-8181'),('Nunc@eu.edu','295-9122 Amet St.','Philip Dotson','1-176-745-4119'),('magna@nec.org','175-1901 Ligula St.','Scott Pratt','1-320-240-9964'),('eu@ipsumprimis.edu','P.O. Box 875, 4628 Molestie. St.','Quon Hensley','1-759-360-7252'),('ipsum@Duis.net','P.O. Box 845, 2939 Tincidunt St.','Fulton Curry','1-970-572-3879');
INSERT INTO "customer" (email,address,cname,phone_number) VALUES ('venenatis.lacus.Etiam@neque.edu','Ap #152-9854 Dictum Rd.','Wylie Kirkland','1-385-237-1689'),('mattis@ante.net','516-3767 Vitae, Rd.','Isaac Finch','1-673-944-5335'),('ligula.Aliquam@eget.edu','Ap #697-8481 Erat Avenue','Guinevere Pennington','1-606-854-9919'),('ipsum@pedeSuspendisse.edu','820-2274 Dui. Ave','Brenden Anthony','1-895-808-3709'),('eu.nibh@cursus.ca','Ap #175-960 In, Av.','Sharon Medina','1-578-952-7074');
INSERT INTO "customer" (email,address,cname,phone_number) VALUES ('dis.parturient.montes@ac.co.uk','1007 Ut, Rd.','Stephen Witt','1-481-955-5175'),('amet.consectetuer@facilisisegetipsum.org','Ap #525-3083 Scelerisque St.','Nyssa Graves','1-142-475-1121'),('enim@odio.edu','773-9773 Ipsum. Street','Daniel Slater','1-236-119-9049'),('feugiat@acfeugiatnon.net','998 Eu St.','Ava Hess','1-306-651-9812'),('ante.Vivamus.non@amalesuadaid.ca','Ap #610-7970 Dis Rd.','Olivia Stephenson','1-225-267-9478');
INSERT INTO "customer" (email,address,cname,phone_number) VALUES ('Aenean.euismod.mauris@vitaesemper.ca','150-3772 Eget Av.','Jonah Conway','1-853-520-4816'),('Sed.et@blanditenimconsequat.co.uk','2140 Eleifend, Avenue','Aristotle Jefferson','1-721-178-0772'),('mauris@volutpat.ca','1510 Pellentesque St.','Alec Love','1-540-717-4768'),('semper.pretium.neque@dolorelitpellentesque.net','140-830 Ac Av.','Desiree Lucas','1-165-856-3396'),('ipsum.ac.mi@libero.co.uk','P.O. Box 266, 7306 A St.','Emmanuel Holloway','1-839-209-4684');
INSERT INTO "customer" (email,address,cname,phone_number) VALUES ('sapien.Aenean@semperrutrum.com','Ap #605-4421 Metus Rd.','Rajah Newton','1-969-664-1259'),('Etiam.gravida@AeneanmassaInteger.org','3378 Bibendum Rd.','Ulysses Horton','1-610-805-6973'),('eu.dolor.egestas@ultricesposuere.ca','Ap #714-6254 Eleifend Av.','Rana Short','1-858-220-1713'),('adipiscing.enim.mi@loremloremluctus.ca','Ap #266-6467 Etiam St.','Jasmine Bullock','1-722-996-7627'),('dolor@nuncidenim.ca','164-9077 Donec Rd.','Mohammad Sanchez','1-269-648-2117');
INSERT INTO "customer" (email,address,cname,phone_number) VALUES ('arcu@Proinvelnisl.co.uk','132-2118 Est. Ave','Nayda Hendrix','1-551-196-8803'),('Quisque.nonummy@nequeetnunc.edu','8384 Fusce Rd.','Oleg Mann','1-716-109-6171'),('Nunc@dolorvitae.com','4290 Fringilla Rd.','Micah Bruce','1-566-772-5098'),('arcu.et@magna.org','P.O. Box 766, 8280 Dictum Road','Maggy Potter','1-492-934-4639'),('libero.Donec@tellusSuspendisse.edu','P.O. Box 129, 9852 Eleifend, Avenue','Shaine Forbes','1-680-615-2236');
INSERT INTO "customer" (email,address,cname,phone_number) VALUES ('cursus.et.eros@Cumsociis.org','Ap #609-6634 Faucibus St.','Ashely Buckner','1-114-677-8202'),('sit.amet.metus@arcuSedeu.co.uk','Ap #912-1941 Parturient Street','Keith Mccarthy','1-616-947-9405'),('convallis@feugiatmetussit.org','3909 Elit Rd.','Avye Mitchell','1-530-147-4843'),('non.bibendum@Phasellus.org','P.O. Box 339, 2450 Interdum Rd.','Adrian House','1-883-821-7916'),('ullamcorper@Nunclaoreetlectus.org','P.O. Box 801, 7447 Augue Road','Nichole Hale','1-373-702-7009');
INSERT INTO "customer" (email,address,cname,phone_number) VALUES ('nec.ligula.consectetuer@loremipsum.org','Ap #236-4490 Mus. Road','Cullen Faulkner','1-922-912-7520'),('fermentum.risus@libero.org','Ap #307-4189 Cursus, Ave','John Moses','1-143-982-5149'),('tempus@Praesent.edu','P.O. Box 645, 8486 Et, Ave','Eliana Fleming','1-362-260-8899'),('Quisque.varius@nibhenim.co.uk','671-9620 Lectus Avenue','Judah Sweet','1-587-572-1204'),('libero@Morbi.com','Ap #454-6965 Velit Av.','Hilel Irwin','1-136-288-9348');
INSERT INTO "customer" (email,address,cname,phone_number) VALUES ('Morbi@iaculisenim.ca','P.O. Box 667, 7979 Velit Avenue','Rudyard Flores','1-278-594-4812'),('sit.amet.diam@non.edu','P.O. Box 894, 2010 Quis, Av.','Joan Downs','1-480-718-4656'),('lobortis.quis@nulla.org','P.O. Box 407, 5046 Nunc St.','Vladimir Best','1-669-304-3626'),('erat.semper.rutrum@amet.org','8342 Eget Ave','Sharon Cabrera','1-215-206-9021'),('Duis.volutpat.nunc@purusactellus.edu','1313 Auctor St.','Reece Craft','1-577-580-6049');
INSERT INTO "customer" (email,address,cname,phone_number) VALUES ('Etiam.vestibulum.massa@Nullamvelit.edu','6093 Placerat, St.','Burton Crosby','1-724-478-8533'),('lobortis.quam.a@anteNuncmauris.com','886-1088 Curabitur St.','Hamish Jennings','1-415-232-9756'),('dictum@turpisnec.net','P.O. Box 358, 2131 Eu Rd.','Leo Mendoza','1-652-800-4771'),('vitae.odio.sagittis@sedturpisnec.org','763-5969 Eu, Rd.','Lev Sweeney','1-860-130-1801'),('molestie.dapibus@malesuada.net','822-5698 Cursus Street','Dean Shannon','1-664-330-8943');
INSERT INTO "customer" (email,address,cname,phone_number) VALUES ('faucibus@pedeCrasvulputate.com','Ap #566-8383 Natoque Street','Jared Jenkins','1-125-944-1166'),('ultricies@magnaSed.com','P.O. Box 168, 8175 Amet Road','Cassidy Sampson','1-102-735-3863'),('eget.varius.ultrices@Maecenas.com','1260 Augue Av.','Linda Cohen','1-691-177-7421'),('conubia@nonvestibulumnec.ca','P.O. Box 258, 4330 Pellentesque Avenue','Willa Weaver','1-286-978-0948'),('placerat@egestas.co.uk','P.O. Box 608, 814 Vitae Street','Rogan Norton','1-685-597-1181');
INSERT INTO "customer" (email,address,cname,phone_number) VALUES ('turpis.egestas.Aliquam@lectuspedeultrices.com','P.O. Box 292, 621 Etiam Road','Zachery Buckley','1-334-771-5563'),('gravida.sit@vulputatenisi.net','Ap #130-9597 Urna Street','Ariel Sutton','1-923-733-8415'),('euismod@varius.co.uk','5841 Quam. St.','Camille Sellers','1-182-513-1813'),('ac.mi@habitantmorbi.net','Ap #283-3504 Egestas St.','Ray Munoz','1-124-616-6141'),('gravida.nunc.sed@erosProinultrices.co.uk','496-4592 Quisque Ave','Leandra Stafford','1-105-694-1292');
INSERT INTO "customer" (email,address,cname,phone_number) VALUES ('cursus@a.edu','Ap #294-8870 Suspendisse St.','Mark Hicks','1-842-977-4036'),('pretium@metus.edu','383-5491 Nec, Ave','Elton Lindsay','1-427-535-2432'),('interdum@tempusscelerisquelorem.org','206-1359 Dolor. Avenue','Walter Johns','1-578-337-5582'),('nisl.arcu.iaculis@nislelementum.com','P.O. Box 907, 7445 Convallis Road','Ocean Ortiz','1-605-721-4347'),('leo.Cras@esttempor.edu','P.O. Box 284, 833 Sagittis Av.','Omar Fletcher','1-840-273-8803');
INSERT INTO "customer" (email,address,cname,phone_number) VALUES ('ut.pellentesque@tinciduntadipiscingMauris.edu','Ap #737-5113 Orci, Street','Richard Cantrell','1-472-134-0620'),('vitae.mauris.sit@Suspendissealiquetsem.com','P.O. Box 968, 9181 Nullam Road','Erin Robertson','1-717-871-8319'),('semper@Aeneansedpede.net','3112 Morbi Ave','Brenda Molina','1-895-206-9958'),('rutrum.lorem@necurnasuscipit.org','P.O. Box 149, 1242 Nisl St.','Brynne Bartlett','1-258-313-6035'),('elit.pede.malesuada@magna.org','969-4851 Sit Rd.','Dillon Kirk','1-149-193-6303');
INSERT INTO "customer" (email,address,cname,phone_number) VALUES ('convallis.ante@estNuncullamcorper.org','532-1308 Enim, Street','Suki Wolfe','1-439-537-6185'),('enim.mi.tempor@imperdietdictummagna.ca','P.O. Box 842, 5602 Dictum Street','Carter Mcfarland','1-188-719-0343'),('dolor.dolor.tempus@Maurisquisturpis.co.uk','P.O. Box 447, 3072 Rutrum Rd.','Mason Frost','1-123-345-4881'),('nulla.at.sem@porttitorinterdum.org','7771 Phasellus St.','Orson Delaney','1-144-624-3948'),('non.feugiat@augue.org','P.O. Box 712, 5625 Etiam Road','Magee Waller','1-573-767-0801');

INSERT INTO "customer" (email,address,cname,phone_number) VALUES ('lorem.eget.mollis@dui.ca','P.O. Box 470, 7990 Mi, Rd.','Piper Lester','1-286-557-5048'),('nunc.sed@arcuMorbisit.edu','Ap #522-5994 Ac Road','Kelsie Shepherd','1-427-902-6096'),('in.faucibus@Quisqueimperdiet.co.uk','523-8121 Sit Rd.','Haley Dillon','1-702-294-4145'),('Cras.pellentesque@acrisusMorbi.com','P.O. Box 350, 6330 Odio. Road','Gregory Olsen','1-422-923-0757'),('nec.ante@necmetusfacilisis.net','2853 Iaculis Av.','William Rowe','1-303-776-3262'),('non.quam.Pellentesque@odio.co.uk','P.O. Box 294, 9976 Lorem. Rd.','Rhona Duncan','1-189-304-6249'),('ante.iaculis.nec@in.co.uk','Ap #698-3641 Sociis Av.','Benjamin Tucker','1-236-259-4716'),('tempus@aliquamenimnec.net','958-2042 Eleifend Rd.','Rudyard Reynolds','1-665-946-5760'),('nec@enimCurabiturmassa.ca','P.O. Box 407, 413 Iaculis Rd.','Veda Graves','1-712-639-4057'),('nec.euismod.in@vitaeposuereat.co.uk','P.O. Box 682, 4305 Etiam St.','Colorado Barrett','1-918-946-9884');

-- member

INSERT INTO "member" (email,address,cname,phone_number,username,password) VALUES ('lorem.eget.mollis@dui.ca','P.O. Box 470, 7990 Mi, Rd.','Piper Lester','1-286-557-5048','Ferdinand','6736'),('nunc.sed@arcuMorbisit.edu','Ap #522-5994 Ac Road','Kelsie Shepherd','1-427-902-6096','Claudia','7212'),('in.faucibus@Quisqueimperdiet.co.uk','523-8121 Sit Rd.','Haley Dillon','1-702-294-4145','Dante','7917'),('Cras.pellentesque@acrisusMorbi.com','P.O. Box 350, 6330 Odio. Road','Gregory Olsen','1-422-923-0757','Leo','7778'),('nec.ante@necmetusfacilisis.net','2853 Iaculis Av.','William Rowe','1-303-776-3262','Perry','3966'),('non.quam.Pellentesque@odio.co.uk','P.O. Box 294, 9976 Lorem. Rd.','Rhona Duncan','1-189-304-6249','Lacey','5712'),('ante.iaculis.nec@in.co.uk','Ap #698-3641 Sociis Av.','Benjamin Tucker','1-236-259-4716','Michael','8974'),('tempus@aliquamenimnec.net','958-2042 Eleifend Rd.','Rudyard Reynolds','1-665-946-5760','Camilla','7650'),('nec@enimCurabiturmassa.ca','P.O. Box 407, 413 Iaculis Rd.','Veda Graves','1-712-639-4057','Levi','5697'),('nec.euismod.in@vitaeposuereat.co.uk','P.O. Box 682, 4305 Etiam St.','Colorado Barrett','1-918-946-9884','Slade','2942');

--savedlist
INSERT INTO "savedlist" (email) VALUES ('vulputate.mauris.sagittis@enimcommodo.net');
INSERT INTO "savedlist" (email) VALUES ('sit@vulputate.org');
INSERT INTO "savedlist" (email) VALUES ('fames.ac.turpis@risus.ca');
INSERT INTO "savedlist" (email) VALUES ('Cras.vulputate.velit@pede.com');
INSERT INTO "savedlist" (email) VALUES ('urna@velit.net');
INSERT INTO "savedlist" (email) VALUES ('massa.Quisque@risus.net');
INSERT INTO "savedlist" (email) VALUES ('et@pharetraNam.net');
INSERT INTO "savedlist" (email) VALUES ('nibh.sit.amet@quamCurabiturvel.co.uk');
INSERT INTO "savedlist" (email) VALUES ('eleifend.non@dui.net');
INSERT INTO "savedlist" (email) VALUES ('dignissim.magna.a@lectusrutrumurna.net');
INSERT INTO "savedlist" (email) VALUES ('eu.augue.porttitor@variusultrices.co.uk');
INSERT INTO "savedlist" (email) VALUES ('commodo@adipiscingMauris.ca');
INSERT INTO "savedlist" (email) VALUES ('libero@mollisIntegertincidunt.co.uk');
INSERT INTO "savedlist" (email) VALUES ('non@luctusut.ca');
INSERT INTO "savedlist" (email) VALUES ('nec@sed.org');
INSERT INTO "savedlist" (email) VALUES ('nec@lacus.edu');
INSERT INTO "savedlist" (email) VALUES ('Nunc@eu.edu');
INSERT INTO "savedlist" (email) VALUES ('magna@nec.org');
INSERT INTO "savedlist" (email) VALUES ('eu@ipsumprimis.edu');
INSERT INTO "savedlist" (email) VALUES ('ipsum@Duis.net');
INSERT INTO "savedlist" (email) VALUES ('venenatis.lacus.Etiam@neque.edu');
INSERT INTO "savedlist" (email) VALUES ('mattis@ante.net');
INSERT INTO "savedlist" (email) VALUES ('ligula.Aliquam@eget.edu');
INSERT INTO "savedlist" (email) VALUES ('ipsum@pedeSuspendisse.edu');
INSERT INTO "savedlist" (email) VALUES ('eu.nibh@cursus.ca');
INSERT INTO "savedlist" (email) VALUES ('dis.parturient.montes@ac.co.uk');
INSERT INTO "savedlist" (email) VALUES ('amet.consectetuer@facilisisegetipsum.org');
INSERT INTO "savedlist" (email) VALUES ('enim@odio.edu');
INSERT INTO "savedlist" (email) VALUES ('feugiat@acfeugiatnon.net');
INSERT INTO "savedlist" (email) VALUES ('ante.Vivamus.non@amalesuadaid.ca');
INSERT INTO "savedlist" (email) VALUES ('Aenean.euismod.mauris@vitaesemper.ca');
INSERT INTO "savedlist" (email) VALUES ('Sed.et@blanditenimconsequat.co.uk');
INSERT INTO "savedlist" (email) VALUES ('mauris@volutpat.ca');
INSERT INTO "savedlist" (email) VALUES ('semper.pretium.neque@dolorelitpellentesque.net');
INSERT INTO "savedlist" (email) VALUES ('ipsum.ac.mi@libero.co.uk');
INSERT INTO "savedlist" (email) VALUES ('sapien.Aenean@semperrutrum.com');
INSERT INTO "savedlist" (email) VALUES ('Etiam.gravida@AeneanmassaInteger.org');
INSERT INTO "savedlist" (email) VALUES ('eu.dolor.egestas@ultricesposuere.ca');
INSERT INTO "savedlist" (email) VALUES ('adipiscing.enim.mi@loremloremluctus.ca');
INSERT INTO "savedlist" (email) VALUES ('dolor@nuncidenim.ca');
INSERT INTO "savedlist" (email) VALUES ('arcu@Proinvelnisl.co.uk');
INSERT INTO "savedlist" (email) VALUES ('Quisque.nonummy@nequeetnunc.edu');
INSERT INTO "savedlist" (email) VALUES ('Nunc@dolorvitae.com');
INSERT INTO "savedlist" (email) VALUES ('arcu.et@magna.org');
INSERT INTO "savedlist" (email) VALUES ('libero.Donec@tellusSuspendisse.edu');
INSERT INTO "savedlist" (email) VALUES ('cursus.et.eros@Cumsociis.org');
INSERT INTO "savedlist" (email) VALUES ('sit.amet.metus@arcuSedeu.co.uk');
INSERT INTO "savedlist" (email) VALUES ('convallis@feugiatmetussit.org');
INSERT INTO "savedlist" (email) VALUES ('non.bibendum@Phasellus.org');
INSERT INTO "savedlist" (email) VALUES ('ullamcorper@Nunclaoreetlectus.org');
INSERT INTO "savedlist" (email) VALUES ('nec.ligula.consectetuer@loremipsum.org');
INSERT INTO "savedlist" (email) VALUES ('fermentum.risus@libero.org');
INSERT INTO "savedlist" (email) VALUES ('tempus@Praesent.edu');
INSERT INTO "savedlist" (email) VALUES ('Quisque.varius@nibhenim.co.uk');
INSERT INTO "savedlist" (email) VALUES ('libero@Morbi.com');
INSERT INTO "savedlist" (email) VALUES ('Morbi@iaculisenim.ca');
INSERT INTO "savedlist" (email) VALUES ('sit.amet.diam@non.edu');
INSERT INTO "savedlist" (email) VALUES ('lobortis.quis@nulla.org');
INSERT INTO "savedlist" (email) VALUES ('erat.semper.rutrum@amet.org');
INSERT INTO "savedlist" (email) VALUES ('Duis.volutpat.nunc@purusactellus.edu');
INSERT INTO "savedlist" (email) VALUES ('Etiam.vestibulum.massa@Nullamvelit.edu');
INSERT INTO "savedlist" (email) VALUES ('lobortis.quam.a@anteNuncmauris.com');
INSERT INTO "savedlist" (email) VALUES ('dictum@turpisnec.net');
INSERT INTO "savedlist" (email) VALUES ('vitae.odio.sagittis@sedturpisnec.org');
INSERT INTO "savedlist" (email) VALUES ('molestie.dapibus@malesuada.net');
INSERT INTO "savedlist" (email) VALUES ('faucibus@pedeCrasvulputate.com');
INSERT INTO "savedlist" (email) VALUES ('ultricies@magnaSed.com');
INSERT INTO "savedlist" (email) VALUES ('eget.varius.ultrices@Maecenas.com');
INSERT INTO "savedlist" (email) VALUES ('conubia@nonvestibulumnec.ca');
INSERT INTO "savedlist" (email) VALUES ('placerat@egestas.co.uk');
INSERT INTO "savedlist" (email) VALUES ('turpis.egestas.Aliquam@lectuspedeultrices.com');
INSERT INTO "savedlist" (email) VALUES ('gravida.sit@vulputatenisi.net');
INSERT INTO "savedlist" (email) VALUES ('euismod@varius.co.uk');
INSERT INTO "savedlist" (email) VALUES ('ac.mi@habitantmorbi.net');
INSERT INTO "savedlist" (email) VALUES ('gravida.nunc.sed@erosProinultrices.co.uk');
INSERT INTO "savedlist" (email) VALUES ('cursus@a.edu');
INSERT INTO "savedlist" (email) VALUES ('pretium@metus.edu');
INSERT INTO "savedlist" (email) VALUES ('interdum@tempusscelerisquelorem.org');
INSERT INTO "savedlist" (email) VALUES ('nisl.arcu.iaculis@nislelementum.com');
INSERT INTO "savedlist" (email) VALUES ('leo.Cras@esttempor.edu');
INSERT INTO "savedlist" (email) VALUES ('ut.pellentesque@tinciduntadipiscingMauris.edu');
INSERT INTO "savedlist" (email) VALUES ('vitae.mauris.sit@Suspendissealiquetsem.com');
INSERT INTO "savedlist" (email) VALUES ('semper@Aeneansedpede.net');
INSERT INTO "savedlist" (email) VALUES ('rutrum.lorem@necurnasuscipit.org');
INSERT INTO "savedlist" (email) VALUES ('elit.pede.malesuada@magna.org');
INSERT INTO "savedlist" (email) VALUES ('convallis.ante@estNuncullamcorper.org');
INSERT INTO "savedlist" (email) VALUES ('enim.mi.tempor@imperdietdictummagna.ca');
INSERT INTO "savedlist" (email) VALUES ('dolor.dolor.tempus@Maurisquisturpis.co.uk');
INSERT INTO "savedlist" (email) VALUES ('nulla.at.sem@porttitorinterdum.org');
INSERT INTO "savedlist" (email) VALUES ('non.feugiat@augue.org');
INSERT INTO "savedlist" (email) VALUES ('lorem.eget.mollis@dui.ca');
INSERT INTO "savedlist" (email) VALUES ('nunc.sed@arcuMorbisit.edu');
INSERT INTO "savedlist" (email) VALUES ('in.faucibus@Quisqueimperdiet.co.uk');
INSERT INTO "savedlist" (email) VALUES ('Cras.pellentesque@acrisusMorbi.com');
INSERT INTO "savedlist" (email) VALUES ('nec.ante@necmetusfacilisis.net');
INSERT INTO "savedlist" (email) VALUES ('non.quam.Pellentesque@odio.co.uk');
INSERT INTO "savedlist" (email) VALUES ('ante.iaculis.nec@in.co.uk');
INSERT INTO "savedlist" (email) VALUES ('tempus@aliquamenimnec.net');
INSERT INTO "savedlist" (email) VALUES ('nec@enimCurabiturmassa.ca');
INSERT INTO "savedlist" (email) VALUES ('nec.euismod.in@vitaeposuereat.co.uk');


--cart 

INSERT INTO "cart" (savedlist_id,total_cost,email) VALUES (1,0,'vulputate.mauris.sagittis@enimcommodo.net');
INSERT INTO "cart" (savedlist_id,total_cost,email) VALUES (2,0,'sit@vulputate.org');
INSERT INTO "cart" (savedlist_id,total_cost,email) VALUES (3,0,'fames.ac.turpis@risus.ca');
INSERT INTO "cart" (savedlist_id,total_cost,email) VALUES (4,0,'Cras.vulputate.velit@pede.com');
INSERT INTO "cart" (savedlist_id,total_cost,email) VALUES (5,0,'urna@velit.net');
INSERT INTO "cart" (savedlist_id,total_cost,email) VALUES (6,0,'massa.Quisque@risus.net');
INSERT INTO "cart" (savedlist_id,total_cost,email) VALUES (7,0,'et@pharetraNam.net');
INSERT INTO "cart" (savedlist_id,total_cost,email) VALUES (8,0,'nibh.sit.amet@quamCurabiturvel.co.uk');
INSERT INTO "cart" (savedlist_id,total_cost,email) VALUES (9,0,'eleifend.non@dui.net');
INSERT INTO "cart" (savedlist_id,total_cost,email) VALUES (10,0,'dignissim.magna.a@lectusrutrumurna.net');
INSERT INTO "cart" (savedlist_id,total_cost,email) VALUES (11,0,'eu.augue.porttitor@variusultrices.co.uk');
INSERT INTO "cart" (savedlist_id,total_cost,email) VALUES (12,0,'commodo@adipiscingMauris.ca');
INSERT INTO "cart" (savedlist_id,total_cost,email) VALUES (13,0,'libero@mollisIntegertincidunt.co.uk');
INSERT INTO "cart" (savedlist_id,total_cost,email) VALUES (14,0,'non@luctusut.ca');
INSERT INTO "cart" (savedlist_id,total_cost,email) VALUES (15,0,'nec@sed.org');
INSERT INTO "cart" (savedlist_id,total_cost,email) VALUES (16,0,'nec@lacus.edu');
INSERT INTO "cart" (savedlist_id,total_cost,email) VALUES (17,0,'Nunc@eu.edu');
INSERT INTO "cart" (savedlist_id,total_cost,email) VALUES (18,0,'magna@nec.org');
INSERT INTO "cart" (savedlist_id,total_cost,email) VALUES (19,0,'eu@ipsumprimis.edu');
INSERT INTO "cart" (savedlist_id,total_cost,email) VALUES (20,0,'ipsum@Duis.net');
INSERT INTO "cart" (savedlist_id,total_cost,email) VALUES (21,0,'venenatis.lacus.Etiam@neque.edu');
INSERT INTO "cart" (savedlist_id,total_cost,email) VALUES (22,0,'mattis@ante.net');
INSERT INTO "cart" (savedlist_id,total_cost,email) VALUES (23,0,'ligula.Aliquam@eget.edu');
INSERT INTO "cart" (savedlist_id,total_cost,email) VALUES (24,0,'ipsum@pedeSuspendisse.edu');
INSERT INTO "cart" (savedlist_id,total_cost,email) VALUES (25,0,'eu.nibh@cursus.ca');
INSERT INTO "cart" (savedlist_id,total_cost,email) VALUES (26,0,'dis.parturient.montes@ac.co.uk');
INSERT INTO "cart" (savedlist_id,total_cost,email) VALUES (27,0,'amet.consectetuer@facilisisegetipsum.org');
INSERT INTO "cart" (savedlist_id,total_cost,email) VALUES (28,0,'enim@odio.edu');
INSERT INTO "cart" (savedlist_id,total_cost,email) VALUES (29,0,'feugiat@acfeugiatnon.net');
INSERT INTO "cart" (savedlist_id,total_cost,email) VALUES (30,0,'ante.Vivamus.non@amalesuadaid.ca');
INSERT INTO "cart" (savedlist_id,total_cost,email) VALUES (31,0,'Aenean.euismod.mauris@vitaesemper.ca');
INSERT INTO "cart" (savedlist_id,total_cost,email) VALUES (32,0,'Sed.et@blanditenimconsequat.co.uk');
INSERT INTO "cart" (savedlist_id,total_cost,email) VALUES (33,0,'mauris@volutpat.ca');
INSERT INTO "cart" (savedlist_id,total_cost,email) VALUES (34,0,'semper.pretium.neque@dolorelitpellentesque.net');
INSERT INTO "cart" (savedlist_id,total_cost,email) VALUES (35,0,'ipsum.ac.mi@libero.co.uk');
INSERT INTO "cart" (savedlist_id,total_cost,email) VALUES (36,0,'sapien.Aenean@semperrutrum.com');
INSERT INTO "cart" (savedlist_id,total_cost,email) VALUES (37,0,'Etiam.gravida@AeneanmassaInteger.org');
INSERT INTO "cart" (savedlist_id,total_cost,email) VALUES (38,0,'eu.dolor.egestas@ultricesposuere.ca');
INSERT INTO "cart" (savedlist_id,total_cost,email) VALUES (39,0,'adipiscing.enim.mi@loremloremluctus.ca');
INSERT INTO "cart" (savedlist_id,total_cost,email) VALUES (40,0,'dolor@nuncidenim.ca');
INSERT INTO "cart" (savedlist_id,total_cost,email) VALUES (41,0,'arcu@Proinvelnisl.co.uk');
INSERT INTO "cart" (savedlist_id,total_cost,email) VALUES (42,0,'Quisque.nonummy@nequeetnunc.edu');
INSERT INTO "cart" (savedlist_id,total_cost,email) VALUES (43,0,'Nunc@dolorvitae.com');
INSERT INTO "cart" (savedlist_id,total_cost,email) VALUES (44,0,'arcu.et@magna.org');
INSERT INTO "cart" (savedlist_id,total_cost,email) VALUES (45,0,'libero.Donec@tellusSuspendisse.edu');
INSERT INTO "cart" (savedlist_id,total_cost,email) VALUES (46,0,'cursus.et.eros@Cumsociis.org');
INSERT INTO "cart" (savedlist_id,total_cost,email) VALUES (47,0,'sit.amet.metus@arcuSedeu.co.uk');
INSERT INTO "cart" (savedlist_id,total_cost,email) VALUES (48,0,'convallis@feugiatmetussit.org');
INSERT INTO "cart" (savedlist_id,total_cost,email) VALUES (49,0,'non.bibendum@Phasellus.org');
INSERT INTO "cart" (savedlist_id,total_cost,email) VALUES (50,0,'ullamcorper@Nunclaoreetlectus.org');
INSERT INTO "cart" (savedlist_id,total_cost,email) VALUES (51,0,'nec.ligula.consectetuer@loremipsum.org');
INSERT INTO "cart" (savedlist_id,total_cost,email) VALUES (52,0,'fermentum.risus@libero.org');
INSERT INTO "cart" (savedlist_id,total_cost,email) VALUES (53,0,'tempus@Praesent.edu');
INSERT INTO "cart" (savedlist_id,total_cost,email) VALUES (54,0,'Quisque.varius@nibhenim.co.uk');
INSERT INTO "cart" (savedlist_id,total_cost,email) VALUES (55,0,'libero@Morbi.com');
INSERT INTO "cart" (savedlist_id,total_cost,email) VALUES (56,0,'Morbi@iaculisenim.ca');
INSERT INTO "cart" (savedlist_id,total_cost,email) VALUES (57,0,'sit.amet.diam@non.edu');
INSERT INTO "cart" (savedlist_id,total_cost,email) VALUES (58,0,'lobortis.quis@nulla.org');
INSERT INTO "cart" (savedlist_id,total_cost,email) VALUES (59,0,'erat.semper.rutrum@amet.org');
INSERT INTO "cart" (savedlist_id,total_cost,email) VALUES (60,0,'Duis.volutpat.nunc@purusactellus.edu');
INSERT INTO "cart" (savedlist_id,total_cost,email) VALUES (61,0,'Etiam.vestibulum.massa@Nullamvelit.edu');
INSERT INTO "cart" (savedlist_id,total_cost,email) VALUES (62,0,'lobortis.quam.a@anteNuncmauris.com');
INSERT INTO "cart" (savedlist_id,total_cost,email) VALUES (63,0,'dictum@turpisnec.net');
INSERT INTO "cart" (savedlist_id,total_cost,email) VALUES (64,0,'vitae.odio.sagittis@sedturpisnec.org');
INSERT INTO "cart" (savedlist_id,total_cost,email) VALUES (65,0,'molestie.dapibus@malesuada.net');
INSERT INTO "cart" (savedlist_id,total_cost,email) VALUES (66,0,'faucibus@pedeCrasvulputate.com');
INSERT INTO "cart" (savedlist_id,total_cost,email) VALUES (67,0,'ultricies@magnaSed.com');
INSERT INTO "cart" (savedlist_id,total_cost,email) VALUES (68,0,'eget.varius.ultrices@Maecenas.com');
INSERT INTO "cart" (savedlist_id,total_cost,email) VALUES (69,0,'conubia@nonvestibulumnec.ca');
INSERT INTO "cart" (savedlist_id,total_cost,email) VALUES (70,0,'placerat@egestas.co.uk');
INSERT INTO "cart" (savedlist_id,total_cost,email) VALUES (71,0,'turpis.egestas.Aliquam@lectuspedeultrices.com');
INSERT INTO "cart" (savedlist_id,total_cost,email) VALUES (72,0,'gravida.sit@vulputatenisi.net');
INSERT INTO "cart" (savedlist_id,total_cost,email) VALUES (73,0,'euismod@varius.co.uk');
INSERT INTO "cart" (savedlist_id,total_cost,email) VALUES (74,0,'ac.mi@habitantmorbi.net');
INSERT INTO "cart" (savedlist_id,total_cost,email) VALUES (75,0,'gravida.nunc.sed@erosProinultrices.co.uk');
INSERT INTO "cart" (savedlist_id,total_cost,email) VALUES (76,0,'cursus@a.edu');
INSERT INTO "cart" (savedlist_id,total_cost,email) VALUES (77,0,'pretium@metus.edu');
INSERT INTO "cart" (savedlist_id,total_cost,email) VALUES (78,0,'interdum@tempusscelerisquelorem.org');
INSERT INTO "cart" (savedlist_id,total_cost,email) VALUES (79,0,'nisl.arcu.iaculis@nislelementum.com');
INSERT INTO "cart" (savedlist_id,total_cost,email) VALUES (80,0,'leo.Cras@esttempor.edu');
INSERT INTO "cart" (savedlist_id,total_cost,email) VALUES (81,0,'ut.pellentesque@tinciduntadipiscingMauris.edu');
INSERT INTO "cart" (savedlist_id,total_cost,email) VALUES (82,0,'vitae.mauris.sit@Suspendissealiquetsem.com');
INSERT INTO "cart" (savedlist_id,total_cost,email) VALUES (83,0,'semper@Aeneansedpede.net');
INSERT INTO "cart" (savedlist_id,total_cost,email) VALUES (84,0,'rutrum.lorem@necurnasuscipit.org');
INSERT INTO "cart" (savedlist_id,total_cost,email) VALUES (85,0,'elit.pede.malesuada@magna.org');
INSERT INTO "cart" (savedlist_id,total_cost,email) VALUES (86,0,'convallis.ante@estNuncullamcorper.org');
INSERT INTO "cart" (savedlist_id,total_cost,email) VALUES (87,0,'enim.mi.tempor@imperdietdictummagna.ca');
INSERT INTO "cart" (savedlist_id,total_cost,email) VALUES (88,0,'dolor.dolor.tempus@Maurisquisturpis.co.uk');
INSERT INTO "cart" (savedlist_id,total_cost,email) VALUES (89,0,'nulla.at.sem@porttitorinterdum.org');
INSERT INTO "cart" (savedlist_id,total_cost,email) VALUES (90,0,'non.feugiat@augue.org');
INSERT INTO "cart" (savedlist_id,total_cost,email) VALUES (91,0,'lorem.eget.mollis@dui.ca');
INSERT INTO "cart" (savedlist_id,total_cost,email) VALUES (92,0,'nunc.sed@arcuMorbisit.edu');
INSERT INTO "cart" (savedlist_id,total_cost,email) VALUES (93,0,'in.faucibus@Quisqueimperdiet.co.uk');
INSERT INTO "cart" (savedlist_id,total_cost,email) VALUES (94,0,'Cras.pellentesque@acrisusMorbi.com');
INSERT INTO "cart" (savedlist_id,total_cost,email) VALUES (95,0,'nec.ante@necmetusfacilisis.net');
INSERT INTO "cart" (savedlist_id,total_cost,email) VALUES (96,0,'non.quam.Pellentesque@odio.co.uk');
INSERT INTO "cart" (savedlist_id,total_cost,email) VALUES (97,0,'ante.iaculis.nec@in.co.uk');
INSERT INTO "cart" (savedlist_id,total_cost,email) VALUES (98,0,'tempus@aliquamenimnec.net');
INSERT INTO "cart" (savedlist_id,total_cost,email) VALUES (99,0,'nec@enimCurabiturmassa.ca');
INSERT INTO "cart" (savedlist_id,total_cost,email) VALUES (100,0,'nec.euismod.in@vitaeposuereat.co.uk');


--warehouse 


INSERT INTO "warehouse" (address,phone) VALUES ('Ap #695-2540 Magnis Avenue','1-912-299-1282');
INSERT INTO "warehouse" (address,phone) VALUES ('1450 Nonummy Road','1-834-440-6766');
INSERT INTO "warehouse" (address,phone) VALUES ('495-2714 At Av.','1-606-904-2105');
INSERT INTO "warehouse" (address,phone) VALUES ('633-8506 Velit. Av.','1-675-382-8390');
INSERT INTO "warehouse" (address,phone) VALUES ('Ap #122-8958 Nibh Rd.','1-542-564-3536');



--store 

INSERT INTO "store" (sname,location) VALUES ('Netus Et Malesuada Incorporated','4223 Sed Avenue');
INSERT INTO "store" (sname,location) VALUES ('At LLP','813-3201 Interdum Ave');
INSERT INTO "store" (sname,location) VALUES ('Nunc Ullamcorper Velit Corporation','P.O. Box 693, 1400 Ut Rd.');
INSERT INTO "store" (sname,location) VALUES ('Montes LLP','835-6567 Ante Rd.');
INSERT INTO "store" (sname,location) VALUES ('Sed Pharetra Felis Ltd','3351 A St.');


--book 
    -- the category is labelled as 
        -- 1: fiction
        -- 2: horror
        -- 3: educational
        -- 4: children 
        -- 5: manga 



-- for store 1 

INSERT INTO "book" (sid,bname,category,author,publisher,stock_status,price,isbn) VALUES (1,'Urna Company','Horror','Jena Chase','Sed Dolor Fusce Incorporated',10,6,'(236) 597-2003');
INSERT INTO "book" (sid,bname,category,author,publisher,stock_status,price,isbn) VALUES (1,'Elit Ltd','Horror','Sharon Marsh','Nascetur Ridiculus Mus Inc.',6,5,'(506) 356-4353');
INSERT INTO "book" (sid,bname,category,author,publisher,stock_status,price,isbn) VALUES (1,'Etiam Incorporated','Memoir','Jayme Giles','Phasellus Dolor Company',7,6,'(306) 219-2961');
INSERT INTO "book" (sid,bname,category,author,publisher,stock_status,price,isbn) VALUES (1,'Ultricies Sem Company','Mystery','Jameson Bartlett','Sagittis Nullam Foundation',4,8,'(306) 300-4885');
INSERT INTO "book" (sid,bname,category,author,publisher,stock_status,price,isbn) VALUES (1,'Primis In Ltd','Textbook','Nigel Norton','Neque Sed Dictum Foundation',20,8,'(403) 468-9550');
-- for store 2
INSERT INTO "book" (sid,bname,category,author,publisher,stock_status,price,isbn) VALUES (2,'Phasellus Company','Horror','Aurora Holt','Malesuada Foundation',35,7,'(782) 668-2485');
INSERT INTO "book" (sid,bname,category,author,publisher,stock_status,price,isbn) VALUES (2,'Cursus Purus Corporation','Textbook','Hamish Huber','Parturient Montes Incorporated',50,5,'(902) 768-5263');
INSERT INTO "book" (sid,bname,category,author,publisher,stock_status,price,isbn) VALUES (2,'Arcu Vel Quam Corp.','Textbook','Signe Torres','Neque Non Quam Inc.',48,10,'(428) 157-4203');
INSERT INTO "book" (sid,bname,category,author,publisher,stock_status,price,isbn) VALUES (2,'Feugiat Nec Diam Inc.','Memoir','Miranda Moreno','Nec Ligula Consectetuer Consulting',72,9,'(581) 187-2326');
INSERT INTO "book" (sid,bname,category,author,publisher,stock_status,price,isbn) VALUES (2,'Primis In Ltd','Religion','Nigel Norton','Neque Sed Dictum Foundation',37,8,'(403) 468-9550');

-- for store 3
INSERT INTO "book" (sid,bname,category,author,publisher,stock_status,price,isbn) VALUES (3,'Arcu Eu Odio Foundation','Horror','Hilary Clay','Tincidunt Tempus Risus Inc.',46,5,'(343) 268-0989');
INSERT INTO "book" (sid,bname,category,author,publisher,stock_status,price,isbn) VALUES (3,'Magna Ut Tincidunt Associates','Religion','Amelia Mcmillan','Ac Fermentum Vel Associates',52,9,'(705) 587-4893');
INSERT INTO "book" (sid,bname,category,author,publisher,stock_status,price,isbn) VALUES (3,'Dictum Eu Placerat LLP','Religion','Brock Dean','Sed Dictum Proin Associates',19,10,'(902) 908-3839');
INSERT INTO "book" (sid,bname,category,author,publisher,stock_status,price,isbn) VALUES (3,'Natoque PC','Mystery','Jael Decker','Enim Sit PC',89,10,'(306) 655-2891');
INSERT INTO "book" (sid,bname,category,author,publisher,stock_status,price,isbn) VALUES (3,'Primis In Ltd','Prayer','Nigel Norton','Neque Sed Dictum Foundation',23,8,'(403) 468-9550');

-- for store 4
INSERT INTO "book" (sid,bname,category,author,publisher,stock_status,price,isbn) VALUES (4,'Feugiat Corporation','Horror','Zia Mccormick','Vivamus Rhoncus Ltd',23,5,'(825) 910-8835');
INSERT INTO "book" (sid,bname,category,author,publisher,stock_status,price,isbn) VALUES (4,'Urna PC','Horror','Rae Reed','Elementum Purus Accumsan Corp.',3,7,'(647) 916-4672');
INSERT INTO "book" (sid,bname,category,author,publisher,stock_status,price,isbn) VALUES (4,'Scelerisque Dui Associates','Religion','Josiah Sharp','Nec LLP',65,8,'(437) 773-8023');
INSERT INTO "book" (sid,bname,category,author,publisher,stock_status,price,isbn) VALUES (4,'Magna Foundation','Mystery','Jacqueline Landry','Lorem Ipsum Inc.',33,7,'(782) 638-7070');
INSERT INTO "book" (sid,bname,category,author,publisher,stock_status,price,isbn) VALUES (4,'Primis In Ltd','Prayer','Nigel Norton','Neque Sed Dictum Foundation',28,8,'(403) 468-9550');

-- for store 5
INSERT INTO "book" (sid,bname,category,author,publisher,stock_status,price,isbn) VALUES (5,'Mollis Phasellus Institute','Horror','Blaze Acosta','Odio Nam Interdum Foundation',36,6,'(902) 611-8257');
INSERT INTO "book" (sid,bname,category,author,publisher,stock_status,price,isbn) VALUES (5,'Sapien Molestie Orci Consulting','Religion','Nomlanga Barnes','Pede Suspendisse Company',78,6,'(825) 441-2582');
INSERT INTO "book" (sid,bname,category,author,publisher,stock_status,price,isbn) VALUES (5,'Quis Foundation','Mystery','Beverly Clay','Nulla Magna Malesuada PC',64,8,'(879) 854-0942');
INSERT INTO "book" (sid,bname,category,author,publisher,stock_status,price,isbn) VALUES (5,'In Nec LLP','Prayer','Melinda Grimes','Enim Curabitur Massa Institute',1,10,'(438) 837-3491');
INSERT INTO "book" (sid,bname,category,author,publisher,stock_status,price,isbn) VALUES (5,'Primis In Ltd','Prayer','Nigel Norton','Neque Sed Dictum Foundation',38,8,'(403) 468-9550');




-- review 

INSERT INTO "review" (sid,instore_bookId,review_id,rate,comment) VALUES (1,3,6,5,'Cras vehicula aliquet libero. Integer in magna.');


-- stock   

    -- warehouse 1, store 1, store 2, store 5
INSERT INTO "stock" (warehouse_id,sid) VALUES (1,1);
INSERT INTO "stock" (warehouse_id,sid) VALUES (1,2);
INSERT INTO "stock" (warehouse_id,sid) VALUES (1,5);
    -- warehouse 2, store 3, 4

INSERT INTO "stock" (warehouse_id,sid) VALUES (2,3);
INSERT INTO "stock" (warehouse_id,sid) VALUES (2,4);

    --warehouse 3, store 1, 2, 3,4
INSERT INTO "stock" (warehouse_id,sid) VALUES (3,1);
INSERT INTO "stock" (warehouse_id,sid) VALUES (3,2);
INSERT INTO "stock" (warehouse_id,sid) VALUES (3,3);
INSERT INTO "stock" (warehouse_id,sid) VALUES (3,4);

-- contain 
INSERT INTO "contain" (savedlist_id, instore_bookId,sid) VALUES (1,3,1) ;
INSERT INTO "contain" (savedlist_id, instore_bookId,sid) VALUES (1,2,1) ;
INSERT INTO "contain" (savedlist_id, instore_bookId,sid) VALUES (2,6,2) ;
INSERT INTO "contain" (savedlist_id, instore_bookId,sid) VALUES (2,8,2) ;
INSERT INTO "contain" (savedlist_id, instore_bookId,sid) VALUES (2,1,1) ;
INSERT INTO "contain" (savedlist_id, instore_bookId,sid) VALUES (2,5,1) ;
INSERT INTO "contain" (savedlist_id, instore_bookId,sid) VALUES (3,15,3) ;



-- cart 
INSERT INTO "contain" (savedlist_id, instore_bookId,sid) VALUES (1,3,1) ;
INSERT INTO "contain" (savedlist_id, instore_bookId,sid) VALUES (1,2,1) ;
INSERT INTO "contain" (savedlist_id, instore_bookId,sid) VALUES (2,6,2) ;
INSERT INTO "contain" (savedlist_id, instore_bookId,sid) VALUES (2,8,2) ;
INSERT INTO "contain" (savedlist_id, instore_bookId,sid) VALUES (2,1,1) ;
INSERT INTO "contain" (savedlist_id, instore_bookId,sid) VALUES (2,5,1) ;
INSERT INTO "contain" (savedlist_id, instore_bookId,sid) VALUES (3,15,3) ;


-- added 

INSERT INTO "added" (sid, cartId, instore_bookId, quantity, cost) VALUES (1, 1, 1, 60, 36);
INSERT INTO "added" (sid, cartId, instore_bookId, quantity, cost) VALUES (5, 1, 23, 100, 8);
INSERT INTO "added" (sid, cartId, instore_bookId, quantity, cost) VALUES (3, 2, 14, 4, 40);
INSERT INTO "added" (sid, cartId, instore_bookId, quantity, cost) VALUES (4, 1, 17, 2, 14);
INSERT INTO "added" (sid, cartId, instore_bookId, quantity, cost) VALUES (1, 3, 3, 3, 18);
INSERT INTO "added" (sid, cartId, instore_bookId, quantity, cost) VALUES (1, 4, 3, 3, 18);
INSERT INTO "added" (sid, cartId, instore_bookId, quantity, cost) VALUES (1, 5, 3, 4, 24);

INSERT INTO "added" (sid, cartId, instore_bookId, quantity, cost) VALUES (5, 6, 23, 48, 32);
INSERT INTO "added" (sid, cartId, instore_bookId, quantity, cost) VALUES (5, 7, 23, 2, 16);
INSERT INTO "added" (sid, cartId, instore_bookId, quantity, cost) VALUES (3, 8, 14, 3, 42);
INSERT INTO "added" (sid, cartId, instore_bookId, quantity, cost) VALUES (4, 9, 3, 90, 63);
INSERT INTO "added" (sid, cartId, instore_bookId, quantity, cost) VALUES (1, 10, 1, 5, 30);


UPDATE cart SET total_cost = 580 WHERE cartId = 1;
UPDATE cart SET total_cost = 840 WHERE cartId = 2;
UPDATE cart SET total_cost = 18 WHERE cartId = 3;
UPDATE cart SET total_cost = 18 WHERE cartId = 4;
UPDATE cart SET total_cost = 24 WHERE cartId = 5;

UPDATE cart SET total_cost = 328 WHERE cartId = 6;
UPDATE cart SET total_cost = 16 WHERE cartId = 7;
UPDATE cart SET total_cost = 42 WHERE cartId = 8;
UPDATE cart SET total_cost = 760 WHERE cartId = 9;
UPDATE cart SET total_cost = 30 WHERE cartId = 10;



-- bill 

INSERT INTO "bill" (payment_type, final_amount_paid, email, cartId) VALUES ('visa', 58, 'vulputate.mauris.sagittis@enimcommodo.net', 1);
INSERT INTO "bill" (payment_type, final_amount_paid, email, cartId) VALUES ('debit', 40, 'sit@vulputate.org', 2);
INSERT INTO "bill" (payment_type, final_amount_paid, email, cartId) VALUES ('mastercard', 18,'fames.ac.turpis@risus.ca',3) ;
INSERT INTO "bill" (payment_type, final_amount_paid, email, cartId) VALUES ('debit', 18,'Cras.vulputate.velit@pede.com', 4);
INSERT INTO "bill" (payment_type, final_amount_paid, email, cartId) VALUES ('visa',24,'urna@velit.net',5);


SELECT * FROM Customer limit 5;
/*
                   email                   |             address              |      cname      |  phone_number  
-------------------------------------------+----------------------------------+-----------------+----------------
 vulputate.mauris.sagittis@enimcommodo.net | 131-5431 Elit, Street            | Ulla Lynch      | 1-384-294-9288
 sit@vulputate.org                         | Ap #217-2875 Pede. Street        | Travis Stevens  | 1-687-986-3101
 fames.ac.turpis@risus.ca                  | P.O. Box 463, 6955 Convallis Rd. | Wyoming Fox     | 1-749-181-1217
 Cras.vulputate.velit@pede.com             | P.O. Box 840, 1044 Quam. Street  | Kelsie Roberson | 1-102-338-7354
 urna@velit.net                            | P.O. Box 164, 4428 Diam. Av.     | TaShya Slater   | 1-474-351-0977
(5 rows)
*/

SELECT * FROM Member limit 5;
/*
               email                |            address            |      cname      |  phone_number  | username  | password 
------------------------------------+-------------------------------+-----------------+----------------+-----------+----------
 lorem.eget.mollis@dui.ca           | P.O. Box 470, 7990 Mi, Rd.    | Piper Lester    | 1-286-557-5048 | Ferdinand | 6736
 nunc.sed@arcuMorbisit.edu          | Ap #522-5994 Ac Road          | Kelsie Shepherd | 1-427-902-6096 | Claudia   | 7212
 in.faucibus@Quisqueimperdiet.co.uk | 523-8121 Sit Rd.              | Haley Dillon    | 1-702-294-4145 | Dante     | 7917
 Cras.pellentesque@acrisusMorbi.com | P.O. Box 350, 6330 Odio. Road | Gregory Olsen   | 1-422-923-0757 | Leo       | 7778
 nec.ante@necmetusfacilisis.net     | 2853 Iaculis Av.              | William Rowe    | 1-303-776-3262 | Perry     | 3966
(5 rows)
*/

/*
 savedlist_id |                   email                   
--------------+-------------------------------------------
            1 | vulputate.mauris.sagittis@enimcommodo.net
            2 | sit@vulputate.org
            3 | fames.ac.turpis@risus.ca
            4 | Cras.vulputate.velit@pede.com
            5 | urna@velit.net

*/

SELECT * FROM Cart limit 5;
/*
 cartid | savedlist_id | total_cost |                  email                  
--------+--------------+------------+-----------------------------------------
     11 |           11 |          0 | eu.augue.porttitor@variusultrices.co.uk
     12 |           12 |          0 | commodo@adipiscingMauris.ca
     13 |           13 |          0 | libero@mollisIntegertincidunt.co.uk
     14 |           14 |          0 | non@luctusut.ca
     15 |           15 |          0 | nec@sed.org
*/

SELECT * FROM Warehouse limit 5;
/*
 warehouse_id |          address           |     phone      
--------------+----------------------------+----------------
            1 | Ap #695-2540 Magnis Avenue | 1-912-299-1282
            2 | 1450 Nonummy Road          | 1-834-440-6766
            3 | 495-2714 At Av.            | 1-606-904-2105
            4 | 633-8506 Velit. Av.        | 1-675-382-8390
            5 | Ap #122-8958 Nibh Rd.      | 1-542-564-3536
*/

SELECT * FROM Store limit 5;
/*
 sid |               sname                |         location          
-----+------------------------------------+---------------------------
   1 | Netus Et Malesuada Incorporated    | 4223 Sed Avenue
   2 | At LLP                             | 813-3201 Interdum Ave
   3 | Nunc Ullamcorper Velit Corporation | P.O. Box 693, 1400 Ut Rd.
   4 | Montes LLP                         | 835-6567 Ante Rd.
   5 | Sed Pharetra Felis Ltd             | 3351 A St.

*/

SELECT * FROM Book limit 5;
/* 
 sid | instore_bookid |          bname           | category |     author     |             publisher              | stock_status | price |      isbn      
-----+----------------+--------------------------+----------+----------------+------------------------------------+--------------+-------+----------------
   1 |              5 | Primis In Ltd            | Textbook | Nigel Norton   | Neque Sed Dictum Foundation        |           20 |     8 | (403) 468-9550
   2 |              7 | Cursus Purus Corporation | Textbook | Hamish Huber   | Parturient Montes Incorporated     |           50 |     5 | (902) 768-5263
   2 |              8 | Arcu Vel Quam Corp.      | Textbook | Signe Torres   | Neque Non Quam Inc.                |           48 |    10 | (428) 157-4203
   2 |              9 | Feugiat Nec Diam Inc.    | Memoir   | Miranda Moreno | Nec Ligula Consectetuer Consulting |           72 |     9 | (581) 187-2326
   3 |             15 | Primis In Ltd            | Prayer   | Nigel Norton   | Neque Sed Dictum Foundation        |           23 |     8 | (403) 468-9550
*/

SELECT * FROM Review limit 5;
/*
 sid | instore_bookid | review_id | rate |                                                      comment                                                      
-----+----------------+-----------+------+-------------------------------------------------------------------------------------------------------------------
   1 |              1 |         1 |    1 | Morbi accumsan laoreet ipsum. Curabitur consequat, lectus sit amet luctus vulputate, nisi sem
   1 |              1 |         2 |    1 | Nunc ac
   1 |              1 |         3 |    3 | erat
   1 |              1 |         4 |    1 | at pretium aliquet, metus urna convallis erat, eget tincidunt dui augue eu tellus. Phasellus elit pede,
   1 |              2 |         5 |    3 | Etiam vestibulum massa rutrum magna. Cras convallis convallis dolor. Quisque tincidunt pede ac urna. Ut tincidunt
*/

SELECT * FROM Stock limit 5;
/*
 warehouse_id | sid 
--------------+-----
            1 |   1
            1 |   2
            1 |   5
            2 |   3
            2 |   4
*/

SELECT * FROM Contain limit 5;
/*
 savedlist_id | instore_bookid | sid 
--------------+----------------+-----
            1 |              3 |   1
            1 |              2 |   1
            2 |              6 |   2
            2 |              8 |   2
            2 |              1 |   1
*/

SELECT * FROM Cart limit 5;
/*
cartid | savedlist_id | total_cost |                  email                  
--------+--------------+------------+-----------------------------------------
     11 |           11 |          0 | eu.augue.porttitor@variusultrices.co.uk
     12 |           12 |          0 | commodo@adipiscingMauris.ca
     13 |           13 |          0 | libero@mollisIntegertincidunt.co.uk
     14 |           14 |          0 | non@luctusut.ca
     15 |           15 |          0 | nec@sed.org
*/

SELECT * FROM Added limit 5;
/*
 sid | cartid | instore_bookid | quantity | cost 
-----+--------+----------------+----------+------
   5 |      1 |             23 |        1 |    8
   3 |      2 |             14 |        4 |   40
   4 |      1 |             17 |        2 |   14
   1 |      3 |              3 |        3 |   18
   1 |      4 |              3 |        3 |   18
*/

SELECT * FROM Bill limit 5;
/*
 payment_id | payment_type | final_amount_paid |                   email                   | cartid 
------------+--------------+-------------------+-------------------------------------------+--------
          2 | debit        |                40 | sit@vulputate.org                         |      2
          3 | mastercard   |                18 | fames.ac.turpis@risus.ca                  |      3
          4 | debit        |                18 | Cras.vulputate.velit@pede.com             |      4
          1 | Master       |                58 | vulputate.mauris.sagittis@enimcommodo.net |      1
          5 | Master       |                24 | urna@velit.net                            |      5
*/


--Q5--

-- query 1 - subquery
-- Table Description
/*
			 Table "cs421g06.customer"
    Column    |          Type          | Modifiers 
--------------+------------------------+-----------
 email        | character varying(100) | not null
 address      | character varying(100) | not null
 cname        | character varying(30)  | not null
 phone_number | character varying(100) | not null
Indexes:
    "customer_pkey" PRIMARY KEY, btree (email)
    "customer_address_key" UNIQUE CONSTRAINT, btree (address)
    "customer_cname_key" UNIQUE CONSTRAINT, btree (cname)
    "customer_phone_number_key" UNIQUE CONSTRAINT, btree (phone_number)
Check constraints:
    "customer_phone_number_check" CHECK (phone_number::text ~~ '1-%'::text)
    "customer_phone_number_check1" CHECK (phone_number::text ~~ '1-%'::text)
Referenced by:
    TABLE "bill" CONSTRAINT "bill_email_fkey" FOREIGN KEY (email) REFERENCES customer(email)
    TABLE "cart" CONSTRAINT "cart_email_fkey" FOREIGN KEY (email) REFERENCES customer(email)
    TABLE "member" CONSTRAINT "member_address_fkey" FOREIGN KEY (address) REFERENCES customer(address)
    TABLE "member" CONSTRAINT "member_cname_fkey" FOREIGN KEY (cname) REFERENCES customer(cname)
    TABLE "member" CONSTRAINT "member_email_fkey" FOREIGN KEY (email) REFERENCES customer(email)
    TABLE "member" CONSTRAINT "member_phone_number_fkey" FOREIGN KEY (phone_number) REFERENCES customer(phone_number)
    TABLE "savedlist" CONSTRAINT "savedlist_email_fkey" FOREIGN KEY (email) REFERENCES customer(email)

                                         Table "cs421g06.cart"
    Column    |          Type          |                       Modifiers                       
--------------+------------------------+-------------------------------------------------------
 cartid       | integer                | not null default nextval('cart_cartid_seq'::regclass)
 savedlist_id | integer                | not null
 total_cost   | integer                | not null
 email        | character varying(100) | not null
Indexes:
    "cart_pkey" PRIMARY KEY, btree (cartid)
    "cart_email_key" UNIQUE CONSTRAINT, btree (email)
Foreign-key constraints:
    "cart_email_fkey" FOREIGN KEY (email) REFERENCES customer(email)
    "cart_savedlist_id_fkey" FOREIGN KEY (savedlist_id) REFERENCES savedlist(savedlist_id)
*/
-- Find names of customers whose cart's cost is greater than 10 dollars.
SELECT cname, total_cost 
FROM Customer C, Cart T
WHERE C.email IN (SELECT email FROM Cart WHERE total_cost > 10 AND T.email = C.email);

-- query 2 - Exist Operator
-- Table Description
/*                                     Table "cs421g06.cart"
    Column    |          Type          |                       Modifiers                       
--------------+------------------------+-------------------------------------------------------
 cartid       | integer                | not null default nextval('cart_cartid_seq'::regclass)
 savedlist_id | integer                | not null
 total_cost   | integer                | not null
 email        | character varying(100) | not null
Indexes:
    "cart_pkey" PRIMARY KEY, btree (cartid)
    "cart_email_key" UNIQUE CONSTRAINT, btree (email)
Foreign-key constraints:
    "cart_email_fkey" FOREIGN KEY (email) REFERENCES customer(email)
    "cart_savedlist_id_fkey" FOREIGN KEY (savedlist_id) REFERENCES savedlist(savedlist_id)
  

        Table "cs421g06.added"
     Column     |  Type   | Modifiers 
----------------+---------+-----------
 sid            | integer | not null
 cartid         | integer | not null
 instore_bookid | integer | not null
 quantity       | integer | not null
 cost           | integer | not null
Indexes:
    "added_pkey" PRIMARY KEY, btree (sid, cartid, instore_bookid)
 */

-- Find emails of customers who has added more than 3 same books to their cart.
SELECT email
FROM Cart C
WHERE EXISTS (SELECT *
			  FROM added A 
			  WHERE A.quantity > 3 AND A.cartid = C.cartid);




-- query 3 - Aggregation
-- Table Description
/*
                                          Table "cs421g06.book"
     Column     |          Type          |                           Modifiers                           
----------------+------------------------+---------------------------------------------------------------
 sid            | integer                | not null
 instore_bookid | integer                | not null default nextval('book_instore_bookid_seq'::regclass)
 bname          | character varying(100) | not null
 category       | character varying(30)  | not null
 author         | character varying(100) | not null
 publisher      | character varying(100) | not null
 stock_status   | integer                | not null
 price          | integer                | not null
 isbn           | character varying(100) | not null
Indexes:
    "book_pkey" PRIMARY KEY, btree (instore_bookid)
Foreign-key constraints:
    "book_sid_fkey" FOREIGN KEY (sid) REFERENCES store(sid)
*/
-- Find the highest price of the books, the names of books which has this price and the id of the store selling this book.
SELECT bname, sid, price
FROM Book
WHERE price = (SELECT MAX(price) FROM Book);

-- query 4 - Grouping
-- Table Description
/*
                                          Table "cs421g06.book"
     Column     |          Type          |                           Modifiers                           
----------------+------------------------+---------------------------------------------------------------
 sid            | integer                | not null
 instore_bookid | integer                | not null default nextval('book_instore_bookid_seq'::regclass)
 bname          | character varying(100) | not null
 category       | character varying(30)  | not null
 author         | character varying(100) | not null
 publisher      | character varying(100) | not null
 stock_status   | integer                | not null
 price          | integer                | not null
 isbn           | character varying(100) | not null
Indexes:
    "book_pkey" PRIMARY KEY, btree (instore_bookid)
Foreign-key constraints:
    "book_sid_fkey" FOREIGN KEY (sid) REFERENCES store(sid)
*/
-- Find average price of books of different category which are in stock.
SELECT category, AVG(price)
FROM Book
WHERE stock_status > 0
GROUP BY category;


-- query 5 - Aggregation
-- Table Description
/*
            Table "cs421g06.review"
     Column     |       Type        | Modifiers 
----------------+-------------------+-----------
 sid            | integer           | not null
 instore_bookid | integer           | not null
 review_id      | integer           | not null
 rate           | integer           | not null
 comment        | character varying | not null
Indexes:
    "review_pkey" PRIMARY KEY, btree (review_id, instore_bookid)
*/
-- Count reviews with the highest ratings.
SELECT COUNT(*)
FROM Review 
WHERE rate = (SELECT MAX(rate) FROM Review);




-- q6 --
-------------------------------------------------------------------------------
---Insert all the items of bname LIKE 'Urna%' to the user with savedListid=80
select * from contain WHERE savedList_id=80;
/*
 savedlist_id | instore_bookid | sid 
--------------+----------------+-----
(0 rows)

*/
Insert INTO contain
	(
	SELECT savedlist_id, instore_bookid, sid
	FROM Book,savedlist
	WHERE bname LIKE'Urna%' AND savedList_id=80
	);
/* INSERT 0 2 */
select * from contain WHERE savedList_id=80;
/*
 savedlist_id | instore_bookid | sid 
--------------+----------------+-----
           80 |              1 |   1
           80 |             17 |   4
(2 rows)
*/
-------------------------------------------------------------------------------
--- Updating (increase) the price of the book of category ='religion'
select instore_bookid, price, category, stock_status FROM book WHERE category='Religion';
/*
 instore_bookid | price | category | stock_status 
----------------+-------+----------+--------------
             10 |     8 | Religion |           37
             12 |     9 | Religion |           52
             13 |    10 | Religion |           19
             18 |     8 | Religion |           65
             22 |     6 | Religion |           78
(5 rows)


*/
UPDATE Book
    SET price = case when stock_status <30  then price +2
                       when stock_status >30 then price+3             
                    end
    WHERE category='Religion';
/*  UPDATE 5 */
select instore_bookid, price, category, stock_status FROM book WHERE category='Religion';
/*
  instore_bookid | price | category | stock_status 
----------------+-------+----------+--------------
             10 |    11 | Religion |           37
             12 |    12 | Religion |           52
             13 |    12 | Religion |           19
             18 |    11 | Religion |           65
             22 |     9 | Religion |           78
(5 rows)
*/

------------------------------------------------------------------------------	
--- Also update the stock status of the book 
--- If the quantity is larger than stock status

select b.instore_bookid,b.stock_status,a.quantity,a.cartid
from book as b,  added as a 
WHERE a.instore_bookid=b.instore_bookid 
		AND a.quantity > b.stock_status;
/*
 instore_bookid | stock_status | quantity | cartid 
----------------+--------------+----------+--------
              3 |            3 |        4 |      5
              3 |            3 |        9 |      9
              1 |            8 |       90 |      1
              1 |            8 |       18 |     10
(4 rows)
*/

Update Book
	SET stock_status=0
	WHERE instore_bookid IN
	(
		SELECT b.instore_bookid 
		FROM book as b , added as a
		WHERE a.instore_bookid=b.instore_bookid 
		AND a.quantity > b.stock_status
		
	);
	
/* UPDATE 2 */
select instore_bookid,stock_status
from book 
WHERE instore_bookid=1 OR instore_bookid=3;
/*
 instore_bookid | stock_status 
----------------+--------------
              3 |            0
              1 |            0
(2 rows)
*/

--------------------------------------------------------------------------
---Deleting all the review with rate less than 5 and larger than 1
select instore_bookid, review_id, rate
from Review
WHERE rate>1;
/*
 instore_bookid | review_id | rate 
----------------+-----------+------
              1 |         3 |    3
              2 |         5 |    3
              3 |         6 |    5
(3 rows)

*/
DELETE FROM Review WHERE rate<5 AND rate>1;
/* DELETE 2 */
select instore_bookid, review_id, rate
from Review
WHERE rate>1;

/*
 instore_bookid | review_id | rate 
----------------+-----------+------
              3 |         6 |    5
(1 row)
*/

------------------------------------------------------------------------


--Q7--

--With this view, we can track the stock of books in each category
CREATE VIEW StockByCategory (category, categoryStock)
AS SELECT category, SUM(stock_status) AS categoryStock
FROM  Book 
GROUP BY category;

SELECT * FROM StockByCategory;

/*
 category | categorystock
----------+---------------
 Memoir   |             3
 Textbook |           118
 Horror   |            60
 Prayer   |            90
 Religion |           219
 Mystery  |            40
(6 rows)

*/


SELECT category,categoryStock FROM StockByCategory;
UPDATE Book
        SET stock_status = '10'
        WHERE category = 'Textbook';

SELECT * FROM StockByCategory;

/*
 category | categorystock
----------+---------------
 Memoir   |             3
 Textbook |            30
 Horror   |            60
 Prayer   |            90
 Religion |           219
 Mystery  |            40
(6 rows)

*/
		
		

-- With this view, we can track the email of the customer who choose to pay with Master card
CREATE VIEW MasterCardPayment (customer, consumption)
AS SELECT B.email AS customer,
SUM(B.final_amount_paid) AS consumption
FROM Bill B
WHERE payment_type = 'Master'
GROUP by customer;

SELECT * FROM MasterCardPayment;
/*
                 customer                  | consumption
-------------------------------------------+-------------
 urna@velit.net                            |          24
 vulputate.mauris.sagittis@enimcommodo.net |          58
(2 rows)

*/

SELECT customer,consumption FROM MasterCardPayment;
UPDATE Bill
        SET payment_type = 'Visa'
        WHERE payment_type = 'Master';
		
SELECT * FROM MasterCardPayment;

--Table becomes empty because there is not "Master" payment type--
/*
 customer | consumption
----------+-------------
(0 rows)

*/

/*
   Conditions for a view to be updatable:
1. The view is defined based on one and only one table.
2. The view must include the PRIMARY KEY of the table based upon which the view has been created.
3. The view should not have any field made out of aggregate functions.
4. The view must not have any distinct clause in its definition.
5. The view must not have any GROUP BY or HAVING clause in its definition.
6. The view must not have any SUBQUERIES in its definitions.
7. If the view you want to update is based upon another view, the later should be updatable.
8. Any of the selected output fields must not use constants, strings or value expressions.
*/

---------------------------------------------------------------------------------------
--Q8--
--All the phone number should start with 1
ALTER TABLE customer ADD CHECK (phone_number LIKE '1-%');
/* ALTER TABLE */
INSERT INTO customer values ('doris@gmail.com','800 sherbrooke Ouest','Doris Li','2-363-475-946');
--- error message print
/*
cs421=> INSERT INTO customer values ('doris@gmail.com','800 sherbrooke Ouest','Doris Li','2-363-475-946');
ERROR:  new row for relation "customer" violates check constraint "customer_phone_number_check"
DETAIL:  Failing row contains (doris@gmail.com, 800 sherbrooke Ouest, Doris Li, 2-363-475-946).
*/

---------------------------------------------------------------------------------------
--All the password should be length = 4;
ALTER TABLE member ADD CHECK (LENGTH(password)=4);
/* ALTER TABLE */
Update member SET password='34279' WHERE username='Leo';
--- error message print
/*
cs421=> Update member SET password='34279' WHERE username='Leo';
ERROR:  new row for relation "member" violates check constraint "member_password_check"
DETAIL:  Failing row contains (Cras.pellentesque@acrisusMorbi.com, P.O. Box 350, 6330 Odio. Road, Gregory Olsen, 1-422-923-0757, Leo, 34279).
*/
---------------------------------------------------------------------------------------

--Q9-- 
/*
The data used to populate the tables were randomly generated from a website (https://generatedata.com). 
We used this method to generate data for tables including 
    -Customer 
    -Member 
    -cart 
    -savedlist
    -store 
    -warehouse 
    -book
    -review 
The website generates a series of INSERT statement and we simply copy pasted the queries. 
As for the other tables including 
    -added 
    -contain
    -stock 
    -bill 
the data used for populating these tables were manually typed and the value of the attributes were randomly assigned 
and calculated by hand. 

*/

