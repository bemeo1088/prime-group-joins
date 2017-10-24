create table "shoes" (
"id" serial primary key,
"name" varchar(80),
"cost" integer);

insert into "shoes" ("name", "cost") 
values ('nike', 50);

UPDATE "shoes" SET "name" = 'new balance', "cost" = 300, "size" = 8.5 
WHERE "id" = 2;

CREATE TABLE koalas (
    id serial primary key,
    “name” varchar(80) not null,
    “gender” varchar(1) not null,
    “age” integer,
    “ready_for_transfer” varchar(1) not null,
    “notes” varchar(120)
    
    );

create table "todolist" (
"id" serial primary key,
"task" varchar (300) not null
);

CREATE TABLE treats (
	id SERIAL PRIMARY KEY,
	name varchar(255),
	description text,
	pic varchar(255)
);

INSERT INTO treats (name, description, pic)
VALUES ('Cupcake', 'A delicious cupcake', '/assets/cupcake.jpg'),
('Donuts', 'Mmmm donuts', '/assets/donuts.jpg');

CREATE TABLE "user" (
id SERIAL PRIMARY KEY,
name VARCHAR(25)
);

INSERT INTO "user" ("name")
VALUES ('Chris'), ('Laura'), ('Aaron'), ('Emma');

SELECT * FROM "user";

CREATE TABLE "hobby" (
	id SERIAL PRIMARY KEY,
	description VARCHAR(100)
);

INSERT INTO "hobby" ("description")
VALUES ('kayaking'), ('celloing'), ('music'), ('knitting'), ('board games');

SELECT * FROM "hobby";

CREATE TABLE "user_hobby" (
	id SERIAL PRIMARY KEY,
	user_id INT REFERENCES "user",
	hobby_id INT REFERENCES "hobby",
	skill INT
	);
	
INSERT INTO "user_hobby" ("user_id", "hobby_id", "skill")
VALUES (1,1,4), (1,3,1), (1,5,5), (2,2,4), (2,3,5), (2,5,1), (3,1,1), (3,3,3), (3,5,5), (4,1,2), (4,2,1), (4,3,3), (4,4,4), (4,5,4);

SELECT "id" as "user_id" FROM "user";

SELECT * FROM "user" JOIN "user_hobby" ON 
"user"."id" = "user_hobby"."user_id";

SELECT * FROM "user" 
JOIN "user_hobby" ON "user"."id" = "user_hobby"."user_id"
JOIN "hobby" ON "hobby"."id" = "user_hobby"."hobby_id";

--// Use JOIN to retrieve data, not update or delete
SELECT "hobby"."description", "user_hobby"."skill"
FROM "hobby" JOIN "user_hobby"
ON "hobby"."id" = "user_hobby"."hobby_id"
WHERE "user_hobby"."user_id" = 1 AND "skill" > 3;

--AGGREGATE
SELECT count(*) FROM "user";

-- MIN or AVG
SELECT MIN("skill") FROM "user_hobby";

SELECT AVG("skill") FROM "user_hobby";

SELECT SUM("skill") FROM "user_hobby";

SELECT MIN("skill"), MAX("skill") FROM "user_hobby";

SELECT "hobby"."description", count("user_hobby"."hobby_id")
FROM "hobby" JOIN "user_hobby"
ON "hobby"."id" = "user_hobby"."hobby_id"
GROUP BY "hobby"."description";

SELECT "hobby"."description", count("user_hobby"."hobby_id"),
AVG ("user_hobby"."skill")
FROM "hobby" JOIN "user_hobby"
ON "hobby"."id" = "user_hobby"."hobby_id"
GROUP BY "hobby"."description";


CREATE TABLE customers (
    id SERIAL PRIMARY KEY,
    first_name character varying(60),
    last_name character varying(80)
);

CREATE TABLE addresses (
    id SERIAL PRIMARY KEY,
    street character varying(255),
    city character varying(60),
    state character varying(2),
    zip character varying(12),
    address_type character varying(8),
    customer_id integer REFERENCES customers
);

CREATE TABLE orders (
    id SERIAL PRIMARY KEY,
    order_date date,
    total numeric(4,2),
    address_id integer REFERENCES addresses
);

CREATE TABLE products (
    id SERIAL PRIMARY KEY,
    description character varying(255),
    unit_price numeric(3,2)
);

CREATE TABLE line_items (
    id SERIAL PRIMARY KEY,
    unit_price numeric(3,2),
    quantity integer,
    order_id integer REFERENCES orders,
    product_id integer REFERENCES products
);

CREATE TABLE warehouse (
    id SERIAL PRIMARY KEY,
    warehouse character varying(55),
    fulfillment_days integer
);

CREATE TABLE warehouse_product (
    product_id integer NOT NULL REFERENCES products,
    warehouse_id integer NOT NULL REFERENCES warehouse,
    on_hand integer,
    PRIMARY KEY (product_id, warehouse_id)
);

INSERT INTO customers 
VALUES (1, 'Lisa', 'Bonet'),
(2, 'Charles', 'Darwin'),
(3, 'George', 'Foreman'),
(4, 'Lucy', 'Liu');

INSERT INTO addresses 
VALUES (1, '1 Main St', 'Detroit', 'MI', '31111', 'home', 1), 
(2, '555 Some Pl', 'Chicago', 'IL', '60611', 'business', 1),
(3, '8900 Linova Ave', 'Minneapolis', 'MN', '55444', 'home', 2),
(4, 'PO Box 999', 'Minneapolis', 'MN', '55334', 'business', 3),
(5, '3 Charles Dr', 'Los Angeles', 'CA', '00000', 'home', 4),
(6, '934 Superstar Ave', 'Portland', 'OR', '99999', 'business', 4);

INSERT INTO orders 
VALUES (1, '2010-03-05', 88.00, 1),
(2, '2012-02-08', 23.50, 2),
(3, '2016-02-07', 4.09, 2),
(4, '2011-03-04', 4.00, 3),
(5, '2012-09-22', 12.99, 5),
(6, '2012-09-23', 23.00, 6),
(7, '2013-05-25', 39.12, 5);

INSERT INTO products 
VALUES (1, 'toothbrush', 3.00),
(2, 'nail polish - blue', 4.25),
(3, 'generic beer can', 2.50),
(4, 'lysol', 6.00),
(5, 'cheetos', 0.99),
(6, 'diet pepsi', 1.20),
(7, 'wet ones baby wipes', 8.99);

INSERT INTO line_items 
VALUES (1, 5.00, 16, 1, 1),
(2, 3.12, 4, 1, 2),
(3, 4.00, 2, 2, 3),
(4, 7.25, 3, 4, 4),
(5, 6.00, 1, 5, 7),
(6, 2.34, 6, 6, 5),
(7, 1.05, 9, 7, 5);

INSERT INTO warehouse VALUES (1, 'alpha', 2),
(2, 'beta', 3),
(3, 'delta', 4),
(4, 'gamma', 4),
(5, 'epsilon', 5);

INSERT INTO warehouse_product 
VALUES (1, 3, 0),
(1, 1, 5),
(2, 4, 20),
(3, 5, 3),
(4, 2, 9),
(4, 3, 12),
(5, 3, 7),
(6, 1, 1),
(7, 2, 4),
(6, 3, 88),
(6, 4, 3);

--	1.	Get all customers and their addresses.
SELECT "first_name", "last_name", "street", "city", "state", "zip", "address_type"  FROM "customers" JOIN "addresses" ON
"customers"."id" = "addresses"."customer_id";

--	2.	Get all orders and their line items.
SELECT * FROM orders JOIN line_items ON
"orders"."id" = "line_items"."order_id";

--  3.Which warehouses have cheetos?
SELECT "products"."description", "warehouse"."warehouse" FROM warehouse
JOIN warehouse_product ON "warehouse"."id" = "warehouse_product"."warehouse_id"
JOIN products ON "products"."id" = "warehouse_product"."product_id"
WHERE "products"."description" = 'cheetos';

--	4.	Which warehouses have diet pepsi?
SELECT "products"."description", "warehouse"."warehouse" FROM warehouse
JOIN warehouse_product ON "warehouse"."id" = "warehouse_product"."warehouse_id"
JOIN products ON "products"."id" = "warehouse_product"."product_id"
WHERE "products"."description" = 'diet pepsi';

--	5.	Get the number of orders for each customer. NOTE: It is OK if those without orders are not included in results.
SELECT COUNT("orders"."id"), "customers"."first_name", "customers"."last_name" FROM customers 
JOIN addresses ON "customers"."id" = "addresses"."customer_id"
JOIN orders ON "orders"."address_id" = "addresses"."id" GROUP BY "customers"."id";

--	6.	How many customers do we have?
SELECT COUNT(*) FROM customers;

--	7.	How many products do we carry?
SELECT COUNT(*) FROM products; ;

--	8.	What is the total available on-hand quantity of diet pepsi?
SELECT "products"."description", SUM("warehouse_product"."on_hand") FROM products
JOIN warehouse_product ON "products"."id" = "warehouse_product"."product_id"
WHERE "products"."description" = 'diet pepsi'
GROUP BY "products"."description";
;


