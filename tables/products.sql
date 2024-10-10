CREATE TABLE products(
   id          INTEGER  NOT NULL PRIMARY KEY 
  ,name        VARCHAR(18) NOT NULL
  ,description VARCHAR(55) NOT NULL
  ,weight      NUMERIC(5,3) NOT NULL
);
INSERT INTO products(id,name,description,weight) VALUES (101,'scooter','Small 2-wheel scooter',3.14);
INSERT INTO products(id,name,description,weight) VALUES (102,'car battery','12V car battery',8.1);
INSERT INTO products(id,name,description,weight) VALUES (103,'12-pack drill bits','12-pack of drill bits with sizes ranging from #40 to #3',0.8);
INSERT INTO products(id,name,description,weight) VALUES (104,'hammer','12oz carpenter''s hammer',0.75);
INSERT INTO products(id,name,description,weight) VALUES (105,'hammer','14oz carpenter''s hammer',0.875);
INSERT INTO products(id,name,description,weight) VALUES (106,'hammer','16oz carpenter''s hammer',1);
INSERT INTO products(id,name,description,weight) VALUES (107,'rocks','box of assorted rocks',5.3);
INSERT INTO products(id,name,description,weight) VALUES (108,'jacket','water resistent black wind breaker',0.1);
INSERT INTO products(id,name,description,weight) VALUES (109,'spare tire','24 inch spare tire',22.2);



CREATE TABLE inventory.products(
   id UInt32
  ,name LowCardinality(String)
  ,description String
  ,weight Decimal32(3),
  sign Int8
)
ENGINE = CollapsingMergeTree(sign)
PRIMARY KEY id
;
INSERT INTO inventory.products(id,name,description,weight,sign) VALUES 
(101,'scooter','Small 2-wheel scooter',3.14,1),
(102,'car battery','12V car battery',8.1,1),
(103,'12-pack drill bits','12-pack of drill bits with sizes ranging from #40 to #3',0.8,1),
(104,'hammer','12oz carpenter''s hammer',0.75,1),
(105,'hammer','14oz carpenter''s hammer',0.875,1),
(106,'hammer','16oz carpenter''s hammer',1,1),
(107,'rocks','box of assorted rocks',5.3,1),
(108,'jacket','water resistent black wind breaker',0.1,1),
(109,'spare tire','24 inch spare tire',22.2,1);
