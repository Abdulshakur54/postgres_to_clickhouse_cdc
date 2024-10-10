CREATE TABLE customers(
   id INTEGER  NOT NULL PRIMARY KEY 
  ,first_name VARCHAR(20) NOT NULL
  ,last_name  VARCHAR(20) NOT NULL
  ,email      VARCHAR(21) NOT NULL
);
INSERT INTO customers(id,first_name,last_name,email) VALUES (1001,'Sally','Thomas','sally.thomas@acme.com');
INSERT INTO customers(id,first_name,last_name,email) VALUES (1002,'George','Bailey','gbailey@foobar.com');
INSERT INTO customers(id,first_name,last_name,email) VALUES (1003,'Edward','Walker','ed@walker.com');
INSERT INTO customers(id,first_name,last_name,email) VALUES (1004,'Anne','Kretchmar','annek@noanswer.org');






CREATE DATABASE IF NOT EXISTS inventory;
CREATE TABLE inventory.customers(
   id UInt32
  ,first_name FixedString(20)
  ,last_name FixedString(20)
  ,email FixedString(30),
  sign Int8
)
ENGINE = CollapsingMergeTree(sign)
PRIMARY KEY id


INSERT INTO customers(id,first_name,last_name,email,sign) VALUES
 (1001,'Sally','Thomas','sally.thomas@acme.com',1),
 (1002,'George','Bailey','gbailey@foobar.com',1),
(1003,'Edward','Walker','ed@walker.com',1),
(1004,'Anne','Kretchmar','annek@noanswer.org',1);



