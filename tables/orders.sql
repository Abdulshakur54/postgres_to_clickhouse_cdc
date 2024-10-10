CREATE TABLE orders(
   order_number INTEGER  NOT NULL PRIMARY KEY 
  ,order_date   DATE  NOT NULL
  ,purchaser    INTEGER  NOT NULL
  ,quantity     INTEGER  NOT NULL
  ,product_id   INTEGER  NOT NULL
);
INSERT INTO orders(order_number,order_date,purchaser,quantity,product_id) VALUES (10001,'2016-01-16',1001,1,102);
INSERT INTO orders(order_number,order_date,purchaser,quantity,product_id) VALUES (10002,'2016-01-17',1002,2,105);
INSERT INTO orders(order_number,order_date,purchaser,quantity,product_id) VALUES (10003,'2016-02-19',1002,2,106);
INSERT INTO orders(order_number,order_date,purchaser,quantity,product_id) VALUES (10004,'2016-02-21',1003,1,107);




CREATE TABLE IF NOT EXISTS inventory.orders(
  order_number UInt32,
  order_date Date
  ,purchaser UInt32
  ,quantity UInt32
  ,product_id UInt32,
  sign Int8
)
ENGINE = CollapsingMergeTree(sign)
PRIMARY KEY order_number;


;
INSERT INTO orders(order_number,order_date,purchaser,quantity,product_id,sign) VALUES 
(10001,'2016-01-16',1001,1,102,1),
(10002,'2016-01-17',1002,2,105,1),
(10003,'2016-02-19',1002,2,106,1),
(10004,'2016-02-21',1003,1,107,1);
