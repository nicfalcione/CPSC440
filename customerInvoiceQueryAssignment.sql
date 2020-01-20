/* SQLINTRODBINIT.SQL                                 	*/
/* Introduction to SQL 					*/
/* Script originally file for ORACLE  DBMS				*/
/* Converted to Postgres by MCJ October 2012 */
/* This script file creates the following tables:	*/
/* VENDOR, PRODUCT, CUSTOMER, INVOICE, LINE		*/
/* and loads the default data rows			*/

DROP TABLE IF EXISTS LINE CASCADE;
DROP TABLE IF EXISTS INVOICE CASCADE;
DROP TABLE IF EXISTS CUSTOMER CASCADE;
DROP TABLE IF EXISTS PRODUCT CASCADE;
DROP TABLE IF EXISTS VENDOR CASCADE;

CREATE TABLE VENDOR ( 
V_CODE 		INTEGER, 
V_NAME 		VARCHAR(35) NOT NULL, 
V_CONTACT 	VARCHAR(15) NOT NULL, 
V_AREACODE 	CHAR(3) NOT NULL, 
V_PHONE 	CHAR(8) NOT NULL, 
V_STATE 	CHAR(2) NOT NULL, 
V_ORDER 	CHAR(1) NOT NULL, 
PRIMARY KEY (V_CODE));

CREATE TABLE PRODUCT (
P_CODE 	varchar(10) CONSTRAINT PRODUCT_P_CODE_PK PRIMARY KEY,
P_DESCRIPT 	varchar(35) NOT NULL,
P_INDATE 	DATE NOT NULL,
P_QOH 	  	DECIMAL NOT NULL,
P_MIN 		DECIMAL NOT NULL,
P_PRICE 	DECIMAL(8,2) NOT NULL,
P_DISCOUNT 	DECIMAL(5,2) NOT NULL,
V_CODE 		INTEGER,
CONSTRAINT PRODUCT_V_CODE_FK
FOREIGN KEY (V_CODE) REFERENCES VENDOR);

CREATE TABLE CUSTOMER (
CUS_CODE	DECIMAL PRIMARY KEY,
CUS_LNAME	VARCHAR(15) NOT NULL,
CUS_FNAME	VARCHAR(15) NOT NULL,
CUS_INITIAL	CHAR(1),
CUS_AREACODE 	CHAR(3) DEFAULT '615' NOT NULL CHECK(CUS_AREACODE IN ('615','713','931')),
CUS_PHONE	CHAR(8) NOT NULL,
CUS_BALANCE	DECIMAL(9,2) DEFAULT 0.00,
CONSTRAINT CUS_UI1 UNIQUE(CUS_LNAME,CUS_FNAME));

CREATE TABLE INVOICE (
inv_number     	DECIMAL PRIMARY KEY,
CUS_CODE	DECIMAL NOT NULL REFERENCES CUSTOMER(CUS_CODE),
INV_DATE  	DATE DEFAULT CURRENT_DATE NOT NULL,
CONSTRAINT INV_CK1 CHECK (INV_DATE > TO_DATE('01-JAN-2008','DD-MON-YYYY')));

CREATE TABLE LINE (
inv_number 	DECIMAL NOT NULL,
line_number	DECIMAL(2,0) NOT NULL,
P_CODE		VARCHAR(10) NOT NULL,
LINE_UNITS	DECIMAL(9,2) DEFAULT 0.00 NOT NULL,
LINE_PRICE	DECIMAL(9,2) DEFAULT 0.00 NOT NULL,
PRIMARY KEY (inv_number,line_number),
FOREIGN KEY (inv_number) REFERENCES INVOICE ON DELETE CASCADE,
FOREIGN KEY (P_CODE) REFERENCES PRODUCT(P_CODE),
CONSTRAINT LINE_UI1 UNIQUE(inv_number, P_CODE));

INSERT INTO VENDOR VALUES(21225,'Bryson, Inc.'    ,'Smithson','615','223-3234','TN','Y');
INSERT INTO VENDOR VALUES(21226,'SuperLoo, Inc.'  ,'Flushing','904','215-8995','FL','N');
INSERT INTO VENDOR VALUES(21231,'D\&E Supply'     ,'Singh'   ,'615','228-3245','TN','Y');
INSERT INTO VENDOR VALUES(21344,'Gomez Bros.'     ,'Ortega'  ,'615','889-2546','KY','N');
INSERT INTO VENDOR VALUES(22567,'Dome Supply'     ,'Smith'   ,'901','678-1419','GA','N');
INSERT INTO VENDOR VALUES(23119,'Randsets Ltd.'   ,'Anderson','901','678-3998','GA','Y');
INSERT INTO VENDOR VALUES(24004,'Brackman Bros.'  ,'Browning','615','228-1410','TN','N');
INSERT INTO VENDOR VALUES(24288,'ORDVA, Inc.'     ,'Hakford' ,'615','898-1234','TN','Y');
INSERT INTO VENDOR VALUES(25443,'B\&K, Inc.'      ,'Smith'   ,'904','227-0093','FL','N');
INSERT INTO VENDOR VALUES(25501,'Damal Supplies'  ,'Smythe'  ,'615','890-3529','TN','N');
INSERT INTO VENDOR VALUES(25595,'Rubicon Systems' ,'Orton'   ,'904','456-0092','FL','Y');

/* P rows						*/
INSERT INTO PRODUCT VALUES('11QER/31','Power painter, 15 psi., 3-nozzle'     ,'03-NOV-2007',  8,  5,109.99,0.00,25595);
INSERT INTO PRODUCT VALUES('13-Q2/P2','7.25-in. pwr. saw blade'              ,'13-DEC-2007', 32, 15, 14.99,0.05,21344);
INSERT INTO PRODUCT VALUES('14-Q1/L3','9.00-in. pwr. saw blade'              ,'13-NOV-2007', 18, 12, 17.49,0.00,21344);
INSERT INTO PRODUCT VALUES('1546-QQ2','Hrd. cloth, 1/4-in., 2x50'            ,'15-JAN-2008', 15,  8, 39.95,0.00,23119);
INSERT INTO PRODUCT VALUES('1558-QW1','Hrd. cloth, 1/2-in., 3x50'            ,'15-JAN-2008', 23,  5, 43.99,0.00,23119);
INSERT INTO PRODUCT VALUES('2232/QTY','B\&D jigsaw, 12-in. blade'            ,'30-DEC-2007',  8,  5,109.92,0.05,24288);
INSERT INTO PRODUCT VALUES('2232/QWE','B\&D jigsaw, 8-in. blade'             ,'24-DEC-2007',  6,  5, 99.87,0.05,24288);
INSERT INTO PRODUCT VALUES('2238/QPD','B\&D cordless drill, 1/2-in.'         ,'20-JAN-2008', 12,  5, 38.95,0.05,25595);
INSERT INTO PRODUCT VALUES('23109-HB','Claw hammer'                          ,'20-JAN-2008', 23, 10,  9.95,0.10,21225);
INSERT INTO PRODUCT VALUES('23114-AA','Sledge hammer, 12 lb.'                ,'02-JAN-2008',  8,  5, 14.40,0.05,NULL);
INSERT INTO PRODUCT VALUES('54778-2T','Rat-tail file, 1/8-in. fine'          ,'15-DEC-2007', 43, 20,  4.99,0.00,21344);
INSERT INTO PRODUCT VALUES('89-WRE-Q','Hicut chain saw, 16 in.'              ,'07-FEB-2008', 11,  5,256.99,0.05,24288);
INSERT INTO PRODUCT VALUES('PVC23DRT','PVC pipe, 3.5-in., 8-ft'              ,'20-FEB-2008',188, 75,  5.87,0.00,NULL);
INSERT INTO PRODUCT VALUES('SM-18277','1.25-in. metal screw, 25'             ,'01-MAR-2008',172, 75,  6.99,0.00,21225);
INSERT INTO PRODUCT VALUES('SW-23116','2.5-in. wd. screw, 50'                ,'24-FEB-2008',237,100,  8.45,0.00,21231);
INSERT INTO PRODUCT VALUES('WR3/TT3' ,'Steel matting, 4''x8''x1/6", .5" mesh','17-JAN-2008', 18,  5,119.95,0.10,25595);


/* CUSTOMER rows					*/
INSERT INTO CUSTOMER VALUES(10010,'Ramas'   ,'Alfred','A' ,'615','844-2573',0);
INSERT INTO CUSTOMER VALUES(10011,'Dunne'   ,'Leona' ,'K' ,'713','894-1238',0);
INSERT INTO CUSTOMER VALUES(10012,'Smith'   ,'Kathy' ,'W' ,'615','894-2285',345.86);
INSERT INTO CUSTOMER VALUES(10013,'Olowski' ,'Paul'  ,'F' ,'615','894-2180',536.75);
INSERT INTO CUSTOMER VALUES(10014,'Orlando' ,'Myron' ,NULL,'615','222-1672',0);
INSERT INTO CUSTOMER VALUES(10015,'O''Brian','Amy'   ,'B' ,'713','442-3381',0);
INSERT INTO CUSTOMER VALUES(10016,'Brown'   ,'James' ,'G' ,'615','297-1228',221.19);
INSERT INTO CUSTOMER VALUES(10017,'Williams','George',NULL,'615','290-2556',768.93);
INSERT INTO CUSTOMER VALUES(10018,'Farriss' ,'Anne'  ,'G' ,'713','382-7185',216.55);
INSERT INTO CUSTOMER VALUES(10019,'Smith'   ,'Olette','K' ,'615','297-3809',0);

/* INVOICE rows						*/
INSERT INTO INVOICE VALUES(1001,10014,'16-JAN-2008');
INSERT INTO INVOICE VALUES(1002,10011,'16-JAN-2008');
INSERT INTO INVOICE VALUES(1003,10012,'16-JAN-2008');
INSERT INTO INVOICE VALUES(1004,10011,'17-JAN-2008');
INSERT INTO INVOICE VALUES(1005,10018,'17-JAN-2008');
INSERT INTO INVOICE VALUES(1006,10014,'17-JAN-2008');
INSERT INTO INVOICE VALUES(1007,10015,'17-JAN-2008');
INSERT INTO INVOICE VALUES(1008,10011,'17-JAN-2008');

/* LINE rows				*/
INSERT INTO LINE VALUES(1001,1,'13-Q2/P2',1,14.99);
INSERT INTO LINE VALUES(1001,2,'23109-HB',1,9.95);
INSERT INTO LINE VALUES(1002,1,'54778-2T',2,4.99);
INSERT INTO LINE VALUES(1003,1,'2238/QPD',1,38.95);
INSERT INTO LINE VALUES(1003,2,'1546-QQ2',1,39.95);
INSERT INTO LINE VALUES(1003,3,'13-Q2/P2',5,14.99);
INSERT INTO LINE VALUES(1004,1,'54778-2T',3,4.99);
INSERT INTO LINE VALUES(1004,2,'23109-HB',2,9.95);
INSERT INTO LINE VALUES(1005,1,'PVC23DRT',12,5.87);
INSERT INTO LINE VALUES(1006,1,'SM-18277',3,6.99);
INSERT INTO LINE VALUES(1006,2,'2232/QTY',1,109.92);
INSERT INTO LINE VALUES(1006,3,'23109-HB',1,9.95);
INSERT INTO LINE VALUES(1006,4,'89-WRE-Q',1,256.99);
INSERT INTO LINE VALUES(1007,1,'13-Q2/P2',2,14.99);
INSERT INTO LINE VALUES(1007,2,'54778-2T',1,4.99);
INSERT INTO LINE VALUES(1008,1,'PVC23DRT',5,5.87);
INSERT INTO LINE VALUES(1008,2,'WR3/TT3',3,119.95);
INSERT INTO LINE VALUES(1008,3,'23109-HB',1,9.95);

------------- DO NOT ATTEMPT TO ALTER THE SCRIPT ABOVE THIS LINE!!! -------------

-- Complete the following directions. Put your SQL below each corresponding instruction. 
-- Keep the comments in place to show which questions the queries belong to.
-- Each direction is independent. One does not depend on another. They run separately.

-- Do NOT hard card. Only literals in the questions are allowed.
-- If it says to look for 'Alfred Ramas', you may use criteria like customer.cus_fname='Alfred' etc.

-- Note that some queries may produce no output. This is expected and is the intention of filtering.

-- 1. Show every product (description only) with a price of $10.00 or more, along with its price.
select P_DESCRIPT, P_PRICE 
from PRODUCT 
where P_PRICE >= 10.00; 


-- 2. Show all invoice numbers belonging to customer Alfred Ramas (output = 1 column)
select INVOICE.inv_number 
from INVOICE, CUSTOMER 
where CUSTOMER.CUS_FNAME = 'Alfred' 
and CUSTOMER.CUS_LNAME = 'Ramas'
and CUSTOMER.CUS_CODE = INVOICE.CUS_CODE;


-- 3. Show every product (description only) related to saws (LIKE '%saw%') along with the supplying vendor (name only) (output = 2 columns)
select PRODUCT.P_DESCRIPT, VENDOR.V_NAME 
from PRODUCT, VENDOR 
where P_DESCRIPT like '%saw%';


-- 4. Show every unique product (description only) purchased by Kathy Smith (use Invoice Line) (output = 1 column)
select distinct PRODUCT.P_DESCRIPT 
from PRODUCT, CUSTOMER, INVOICE, LINE
where CUSTOMER.CUS_FNAME = 'Kathy' 
and CUSTOMER.CUS_LNAME = 'Smith'
and CUSTOMER.CUS_CODE = INVOICE.CUS_CODE
and INVOICE.INV_NUMBER = LINE.INV_NUMBER
and LINE.P_CODE = PRODUCT.P_CODE;


-- 5. Use ALTER to add a column called ISO9000 to Vendor. This column should hold a single character and should be 'N' by default and should never be null. 
alter table VENDOR 
add ISO9000 char(1) not null default 'N';


-- 6. Use SELECT DISTINCT to list vendor names and product descriptions (Vendor Name and Product Description), matching products with their vendors using keys. Use a FULL OUTER JOIN so that unmatched vendors and products will still be in the output. (output = 2 columns)
select distinct VENDOR.V_NAME, PRODUCT.P_DESCRIPT
from PRODUCT
full outer join VENDOR
on VENDOR.V_CODE = PRODUCT.V_CODE;


-- 7. Use SELECT to create a simple list of invoices (invoide number) belonging to those customers in the '615' area code. You will need to join customer to invoice on two criteria: matching cus_code AND cus_areacode matching the string above. (output = 1 column)
select INVOICE.inv_number 
from INVOICE 
join CUSTOMER 
on INVOICE.CUS_CODE = CUSTOMER.CUS_CODE 
and CUSTOMER.CUS_AREACODE = '615';


-- 8. Use aggregate functions and math operations to total up the amount of money spent by every single individual in the database (first/last names, total). You will need to join customer with invoice and line and output first and last names with dollar amounts. (output = 3 columns)
select CUSTOMER.CUS_FNAME, CUSTOMER.CUS_LNAME, sum(PRODUCT.P_PRICE) 
from CUSTOMER, LINE, INVOICE, PRODUCT 
where CUSTOMER.CUS_CODE = INVOICE.CUS_CODE 
and INVOICE.INV_NUMBER = LINE.INV_NUMBER 
and LINE.P_CODE = PRODUCT.P_CODE
group by CUSTOMER.CUS_FNAME, CUSTOMER.CUS_LNAME
order by CUSTOMER.CUS_FNAME, CUSTOMER.CUS_LNAME, sum(PRODUCT.P_PRICE);


-- 9. Display a list of names (first and last) of all customers with NO invoices. You will need to utilize outer joins and the IS NULL keywords. (output = 2 columns)
select CUSTOMER.CUS_FNAME, CUSTOMER.CUS_LNAME 
from CUSTOMER 
left outer join INVOICE 
on CUSTOMER.CUS_CODE = INVOICE.CUS_CODE 
where INVOICE.inv_number is null;


-- 10. Use DELETE and a subquery to remove all customers from the database if they have no invoices. You can utilize the query above!
delete from CUSTOMER 
where CUSTOMER.CUS_CODE = any(
select CUSTOMER.CUS_CODE
from CUSTOMER 
left outer join INVOICE 
on CUSTOMER.CUS_CODE = INVOICE.CUS_CODE 
where INVOICE.inv_number is null);