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

