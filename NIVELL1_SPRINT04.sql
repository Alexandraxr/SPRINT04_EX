CREATE TABLE companies (
company_id VARCHAR(15),
company_name VARCHAR(100),
phone VARCHAR(15),
email VARCHAR(100),
country VARCHAR(100),
website VARCHAR(100),
PRIMARY KEY (company_id) ); 

CREATE TABLE credit_cards (
id VARCHAR(15),
user_id VARCHAR(15),
iban VARCHAR(30),
pan VARCHAR(20),
pin VARCHAR(4),
cvv INT,
track1 VARCHAR(100),
track2 VARCHAR(100),
expiring_date DATE,
PRIMARY KEY (id) );

DROP TABLE products ;

CREATE TABLE products (
id VARCHAR(50),
product_name VARCHAR(50),
price DECIMAL(10,2),
colour VARCHAR(50),
weight VARCHAR(50),
warehouse_id VARCHAR(50),
PRIMARY KEY (id) );
#La tabla product la he creado haciendo una nueva tabla , por que no me dejaba introducirla. 

CREATE TABLE transactions (
id VARCHAR(50),
card_id VARCHAR(15),
bussines_id VARCHAR(15),
fecha_hora timestamp,
amount DECIMAL (10,2),
declined BOOLEAN, 
products_ids VARCHAR(20),
user_id INT,
latitude VARCHAR(20),
longitude VARCHAR(20),
PRIMARY KEY (id) );

CREATE TABLE users ( 
id VARCHAR (4),
name VARCHAR (50),
surname VARCHAR (50),
phone VARCHAR(50),
email VARCHAR(50),
birth_date DATE,
country VARCHAR(50),
city VARCHAR(50),
postal_code VARCHAR(10),
address VARCHAR(50),
PRIMARY KEY (id) );
#Tabla users por el problema de las comillas, la he creado haciendo una nueva.

LOAD DATA LOCAL INFILE "C:\Users\usuario\Documents\FADD\FADD CURS PRESENCIAL\datos sprint 03\users_ca.csv"
INTO TABLE users
FIELDS TERMINATED BY ","
LINES TERMINATED BY "\r\n"
IGNORE 1 ROWS;
#codigo para entrar documento csv, pero me da error: "file request rejected due to restrictions on access", por lo tanto he subido los documentos con wizard.

DROP TABLE users_all;

CREATE TABLE users_all AS
SELECT id, name, surname, phone, email, birth_date, country, city, postal_code, address FROM users_ca
UNION ALL
SELECT id, name, surname, phone, email, birth_date, country, city, postal_code, address FROM users_uk 
UNION ALL 
SELECT id, name, surname, phone, email, birth_date, country, city, postal_code, address FROM users_usa
ORDER BY id desc ; 

#crear FOREING KEYS:

ALTER TABLE transactions
ADD foreign key (bussines_id) REFERENCES companies(company_id);

SET FOREIGN_KEY_CHECKS=0;

ALTER TABLE transactions
ADD foreign key (card_id) REFERENCES credit_cards(id);

ALTER TABLE transactions
ADD foreign key (user_id) REFERENCES users_all(id);

SET GLOBAL FOREIGN_KEY_CHECKS=1;

SELECT
 SUBSTRING_INDEX(SUBSTRING_INDEX(products_ids, ",", 1), ",", -1) AS product1,
 SUBSTRING_INDEX(SUBSTRING_INDEX(products_ids, ",", 2), ",", -1) AS product2,
 SUBSTRING_INDEX(SUBSTRING_INDEX(products_ids, ",", 3), ",", -1) AS product3,
 SUBSTRING_INDEX(SUBSTRING_INDEX(products_ids, ",", 4), ",", -1) AS product4
FROM transactions;










