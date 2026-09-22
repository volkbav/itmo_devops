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
