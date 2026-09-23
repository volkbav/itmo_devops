--  задание 1
CREATE OR REPLACE FUNCTION "TransactionDetails".fn_intcalc(
    Amount decimal(18,5)
    , FromDate date
    , ToDate date
    , InterestRate decimal(6,3)=10
)
RETURNS decimal(18,5)
SECURITY INVOKER
AS $$
    DECLARE
        IntCalculated decimal(18,5);
    BEGIN
        IntCalculated := Amount * (InterestRate / 100.00) * (
            EXTRACT(DAY FROM ToDate::timestamp-FromDate::timestamp)/365.00
        );
        RETURN COALESCE(IntCalculated, 0);
    END
$$ LANGUAGE plpgsql
;

SELECT "TransactionDetails".fn_intcalc (
    2000
    , '2023-03-01'
    , '2023-03-10'
    , 10
)
;

DROP FUNCTION "TransactionDetails".fn_intcalc;

-- задание 2
CREATE OR REPLACE FUNCTION "TransactionDetails".returntransactions (
    CustID bigint
)
RETURNS TABLE (
    transactionid bigint
    , customerid bigint
    , transactiondescription varchar(30)
    , dateentered timestamp(0)
    , amount money
)
SECURITY INVOKER
AS $$
    SELECT
        t.transactionid AS transactionid
        , t.customerid AS customerid
        , tt.transactiondescription AS transactiondescription
        , t.dateentered AS dateentered
        , t.amount AS amount
    FROM "TransactionDetails".transactions t
    JOIN "TransactionDetails".transactiontypes tt
        ON tt.transactiontypesid = t.transactiontype
    WHERE t.customerid = CustID;
$$
LANGUAGE sql;


INSERT INTO "TransactionDetails".transactions (
    customerid
    , transactiontype
    , dateentered
    , amount
    , relatedproductid
)
VALUES
    (1, 1, '2023-08-01', 100.00, 1)
    , (1, 1, '2023-08-03', 75.67, 1)
    , (1, 2, '2023-08-08', 35.20, 1)
    , (1, 2, '2023-08-06', 20.00, 1)
;

INSERT INTO "TransactionDetails".transactiontypes (
    transactiondescription
    , credittype
    , affectcashbalance
)
VALUES
    ('proc+', true, true)
    , ('proc-', false, true)
;

SELECT * FROM "TransactionDetails".returntransactions(1);

SELECT 
    c.customerfirstname
    , c.customerlastname
    , trans.transactionid
    , trans.transactiondescription
    , trans.dateentered
    , trans.amount
FROM "CustomerDetails".customers AS c
JOIN "TransactionDetails".returntransactions(c.customerid) AS trans
    ON c.customerid = trans.customerid
;

-- задание 3
CREATE PROCEDURE "CustomerDetails".spu_inscustomer (
    Firstname varchar(50)
    , Lastname varchar(50)
    , CustTitle int
    , CustInitials varchar(10)
    , AddressId int
    , AccountNumber varchar(15)
    , AccountTypeId int
)
LANGUAGE plpgsql
AS $$
BEGIN
    INSERT INTO "CustomerDetails".customers (
        customertitleid
        , customerfirstname
        , customerotherinitials
        , customerlastname
        , addressid
        , accauntnumber
        , accaunttypeid
        , clearedbalance
        , unclearedbalance
    )
    VALUES (
        CustTitle
        , Firstname
        , CustInitials
        , Lastname
        , AddressId
        , AccountNumber
        , AccountTypeId
        , 0
        , 0
    );
END;
$$
;

CALL "CustomerDetails".spu_inscustomer ('Henry', 'Williams', 1, NULL, 431, '22067531', 1);

SELECT * FROM "CustomerDetails".customers
WHERE customerfirstname = 'Henry'
;

CALL "CustomerDetails".spu_inscustomer (
    CustTitle => 1
    , Firstname => 'Julie'
    , CustInitials => 'A'
    , Lastname => 'Dewson'
    , AddressId => 643
    , AccountNumber => 'SS865'
    , AccountTypeId => 7
)
;


SELECT * FROM "CustomerDetails".customers
WHERE customerfirstname = 'Julie'
;

-- задание 4

