-- задание 1

SELECT 
    sharedesc
    , sharetickerid
    , currentprice AS "Last Price"
FROM "ShareDetails".shares
WHERE currentprice > 0
ORDER BY sharedesc;

-- задание 2
--1
SELECT 
    shares.shareid
    , shares.sharedesc
    , shares.sharetickerid
    , shares.currentprice AS "Last Price"
FROM "ShareDetails".shares
WHERE shares.currentprice > 0::numeric
ORDER BY shares.sharedesc;
--2
SELECT 
   sp.shareid
   , sp.price
   , sp.pricedate
   , vcs.sharedesc
FROM "ShareDetails".shareprices sp
INNER JOIN "ShareDetails".v_currentshares vcs
    ON sp.shareid = vcs.shareid
ORDER BY vcs.sharedesc, sp.pricedate DESC;
-- 3
INSERT INTO "ShareDetails".shareprices (
    shareid, price, pricedate
)
VALUES
    (1, 2.155, '2023-08-01 10:10:00')
    , (1, 2.2125, '2023-08-01 10:12:00')
    , (1, 2.4175, '2023-08-01 10:16:00')
    , (1, 2.21, '2023-08-01 10:22:00')
    , (1, 2.17, '2023-08-01 14:54:00')
    , (1, 2.34125, '2023-08-01 16:10:00')
    , (2, 41.10, '2023-08-01 10:10:00')
    , (2, 43.22, '2023-08-02 10:10:00')
    , (2, 45.20, '2023-08-03 10:10:00')

INSERT INTO "ShareDetails".shares
    (sharedesc, sharetickerid, currentprice)
VALUES ('FAT-BELLY.COM', 'FBC', 45.2000)

-- 4
SELECT * FROM "ShareDetails".v_shareprices

-- задание 3
CREATE VIEW "CustomerDetails".v_custtrans
AS
SELECT
    c.accauntnumber
    , c.customerfirstname
    , c.customerotherinitials
    , tt.transactiondescription
    , t.dateentered
    , t.amount
    , t.referencedetails
FROM "CustomerDetails".customers AS c
JOIN "TransactionDetails".transactions AS t
    ON t.customerid = c.customerid
JOIN "TransactionDetails".transactiontypes AS tt
    ON tt.transactiontypesid = t.transactiontype
ORDER BY c.accauntnumber ASC, t.dateentered DESC;

-- задание 4
-- 1
INSERT INTO "CustomerDetails".financialproducts (
    productid, productname
)
VALUES
    (1, 'Regular Saving')
    , (2, 'Bonds Account')
    , (3, 'Share Account')
    , (4, 'Life Insurance')
;

INSERT INTO "CustomerDetails".customersproducts (
    customerid
    , financialproductid
    , amounttocollect
    , frequency
    , lastcollected
    , lastcollection
    , renewable
)
VALUES
    (1, 1, 200, 1, '2021-08-31', '2035-08-31', false)
    , (1, 2, 50, 1, '2023-08-24', '24 March 2025', false)
    , (2, 4, 150, 3, '2023-08-20', '2025-08-20', true)
    , (3, 3, 500, 0, '2023-08-24', '2025-08-24', true)
;

-- 2
DROP VIEW IF EXISTS "CustomerDetails".v_custfinproducts;

CREATE VIEW "CustomerDetails".v_custfinproducts
AS
SELECT
    c. customerfirstname || ' ' || c.customerlastname AS customerlastname
    , c.accauntnumber
    , fp.productname
    , cp.amounttocollect
    , cp.frequency
    , cp.lastcollected
FROM "CustomerDetails".customers As c
JOIN "CustomerDetails".customersproducts AS cp
    ON cp.customerid = c.customerid
JOIN "CustomerDetails".financialproducts AS fp
    ON fp.productid = cp.financialproductid
;

-- 3
SELECT * FROM "CustomerDetails".v_custfinproducts;

-- 4
ALTER TABLE "CustomerDetails".customers
ALTER COLUMN customerfirstname TYPE varchar(100);

-- задание 5
DROP VIEW IF EXISTS "CustomerDetails".v_custfinproducts;

CREATE MATERIALIZED VIEW "CustomerDetails".v_custfinproducts
AS
SELECT
    c. customerfirstname || ' ' || c.customerlastname AS customerlastname
    , c.accauntnumber
    , fp.productname
    , cp.amounttocollect
    , cp.frequency
    , cp.lastcollected
FROM "CustomerDetails".customers As c
JOIN "CustomerDetails".customersproducts AS cp
    ON cp.customerid = c.customerid
JOIN "CustomerDetails".financialproducts AS fp
    ON fp.productid = cp.financialproductid
;

SELECT * FROM "CustomerDetails".v_custfinproducts;

UPDATE "CustomerDetails".customers
SET customerlastname = 'Brusten'
WHERE customerlastname = 'Brust';

SELECT * FROM "CustomerDetails".customers;

SELECT * FROM "CustomerDetails".v_custfinproducts;

REFRESH MATERIALIZED VIEW "CustomerDetails".v_custfinproducts;
SELECT * FROM "CustomerDetails".v_custfinproducts;

