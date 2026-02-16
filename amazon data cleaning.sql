-- removing duplicate
SELECT * FROM amazon.amazon_explo;

SELECT *, 
       ROW_NUMBER() OVER (
           PARTITION BY CustomerName, ProductName, Category, TotalAmount, ShippingCost, "OrderDate"
       ) AS row_num
FROM amazon_explo;

WITH duplicate_CTE AS
( 
SELECT *, 
       ROW_NUMBER() OVER (
           PARTITION BY CustomerName, ProductName, Category, TotalAmount, ShippingCost, "OrderDate"
       ) AS row_num
FROM amazon_explo
)
SELECT * 
FROM duplicate_cte
WHERE row_num >1;

WITH duplicate_CTE AS
( 
SELECT *, 
       ROW_NUMBER() OVER (
           PARTITION BY CustomerName, ProductName, Category, TotalAmount, ShippingCost, "OrderDate"
       ) AS row_num
FROM amazon_explo
)
DELETE 
FROM duplicate_cte
WHERE row_num >1;



  CREATE TABLE `amazon_explo1` (
  `OrderID` text,
  `OrderDate` text,
  `CustomerID` text,
  `CustomerName` text,
  `ProductID` text,
  `ProductName` text,
  `Category` text,
  `Brand` text,
  `Quantity` int DEFAULT NULL,
  `UnitPrice` double DEFAULT NULL,
  `Discount` double DEFAULT NULL,
  `Tax` double DEFAULT NULL,
  `ShippingCost` double DEFAULT NULL,
  `TotalAmount` double DEFAULT NULL,
  `PaymentMethod` text,
  `OrderStatus` text,
  `City` text,
  `State` text,
  `Country` text,
  `SellerID` text,
  row_num int
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

SELECT *
FROM amazon_explo1;

INSERT INTO amazon_explo1
SELECT *, 
       ROW_NUMBER() OVER (
           PARTITION BY CustomerName, ProductName, Category, TotalAmount, ShippingCost, "OrderDate"
       ) AS row_num
FROM amazon_explo; 

SELECT *
FROM amazon_explo1
where row_num >1;

DELETE 
FROM amazon_explo1
where row_num >1
;

SELECT *
FROM amazon_explo1 
WHERE row_num = 1;


-- standardizing data
SELECT  brand,Trim(Brand)
FROM amazon_explo1;
UPDATE amazon_explo1
SET brand = Trim(Brand);




SELECT  ProductName,Category
FROM amazon_explo1 ;
UPDATE amazon_explo1 
SET Category = 'Electronics'
WHERE ProductName   = '4K Monitor';

UPDATE amazon_explo1 
SET Category = 'Electronics'
WHERE ProductName   = 'Portable SSD 1TB';

UPDATE amazon_explo1 
SET Category = 'Electronics'
WHERE ProductName   = 'USB-C Charger';


UPDATE amazon_explo1 
SET Category = 'Electronics'
WHERE ProductName   ='Smart Light Bulb'  ;

UPDATE amazon_explo1 
SET Category = 'Electronics'
WHERE ProductName  = 'Router';

 
 UPDATE amazon_explo1 
SET Category = 'Electronics'
WHERE ProductName  ='Power Bank 20000mAh';

UPDATE amazon_explo1 
SET Category = 'Electronics'
WHERE ProductName  ='Bluetooth Speaker' ;

UPDATE amazon_explo1 
SET Category = 'Electronics'
WHERE ProductName  ='Graphic Tablet'  ;

UPDATE amazon_explo1 
SET Category = 'Electronics'
WHERE ProductName  = 'Mechanical Keyboard'  ;
UPDATE amazon_explo1 
SET Category = 'Electronics'
WHERE ProductName  ='External HDD 2TB';

UPDATE amazon_explo1 
SET Category = 'Electronics'
WHERE ProductName  = 'Action Camera'
 ;

  ;

UPDATE amazon_explo1 
SET Category = 'Home & Kitchen'
WHERE ProductName  = 'Desk Organizer'
  ;

UPDATE amazon_explo1 
SET Category = 'Home & Kitchen'
WHERE ProductName  = 'LED Desk Lamp'  ;

UPDATE amazon_explo1 
SET Category = 'Toys & Games'
WHERE ProductName  ='Board Game';
UPDATE amazon_explo1 
SET Category = 'Sports & Outdoors'
WHERE ProductName  ='Backpack' ;

 UPDATE amazon_explo1 
SET Category = 'Clothing'
WHERE ProductName  = 'Dress Shirt'  ;


select ProductName, Category
FROM amazon_explo1
where ProductName = 'Mechanical Keyboard'  ;


SELECT  ProductName,Category
FROM amazon_explo1 ;

SELECT distinct ProductName ,  Category
FROM  amazon_explo1;

SELECT  *
FROM amazon_explo1
WHERE ProductName IS Null
 OR ProductName =' ';
 
 ALTER TABLE amazon_explo1 
 DROP COLUMN Brand;
 
 ALTER table amazon_explo1
 DROP COLUMN row_num;

SELECT  *
FROM amazon_explo1
;






