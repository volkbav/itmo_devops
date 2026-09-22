-- задание 1
INSERT INTO "ShareDetails".shares (
    sharedesc
    ,sharetickerid
    ,currentprice
)
VALUES (
    'ACME''S HOMEBAKE COOKISE INK'
    ,'AHCI'
    ,2.34125
);

SELECT * FROM "ShareDetails".shares;

INSERT INTO "CustomerDetails".customers (
    customertitleid
    ,customerlastname
    ,customerfirstname
    ,customerotherinitials
    ,addressid
    ,accauntnumber
    ,accaunttypeid
    ,clearedbalance
    ,unclearedbalance
)
VALUES (
    3
    ,'Lobel'
    ,'Leonard'
    ,NULL
    ,145
    ,53431993
    ,1
    ,437.97
    ,-10.56
);

DELETE FROM "CustomerDetails".customers
WHERE customerid = 2;

ALTER TABLE "CustomerDetails".customers
ALTER COLUMN customerfirstname TYPE character varying(50);

ALTER TABLE "CustomerDetails".customers
ALTER COLUMN customerotherinitials TYPE character varying(10);

ALTER TABLE "CustomerDetails".customers
ALTER COLUMN customerlastname TYPE character varying(50);

ALTER TABLE "CustomerDetails".customers
ALTER COLUMN accauntnumber TYPE character varying(15);

-- Из pgadmin
-- Table: CustomerDetails.customers

-- DROP TABLE IF EXISTS "CustomerDetails".customers;

CREATE TABLE IF NOT EXISTS "CustomerDetails".customers
(
    customerid bigint NOT NULL GENERATED ALWAYS AS IDENTITY ( INCREMENT 1 START 1 MINVALUE 1 MAXVALUE 9223372036854775807 CACHE 1 ),
    customertitleid integer NOT NULL,
    customerfirstname character varying(50) COLLATE pg_catalog."default" NOT NULL,
    customerotherinitials character varying(10) COLLATE pg_catalog."default",
    customerlastname character varying(50) COLLATE pg_catalog."default" NOT NULL,
    addressid bigint NOT NULL,
    accauntnumber character varying(15) COLLATE pg_catalog."default" NOT NULL,
    accaunttypeid integer NOT NULL,
    clearedbalance money NOT NULL,
    unclearedbalance money NOT NULL,
    dateadded date NOT NULL DEFAULT CURRENT_DATE,
    CONSTRAINT customers_pkey PRIMARY KEY (customerid)
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS "CustomerDetails".customers
    OWNER to alex;

COMMENT ON TABLE "CustomerDetails".customers
    IS 'некое описание таблицы';
-- Index: ix_customers_customerid

-- DROP INDEX IF EXISTS "CustomerDetails".ix_customers_customerid;

CREATE UNIQUE INDEX IF NOT EXISTS ix_customers_customerid
    ON "CustomerDetails".customers USING btree
    (customerid ASC NULLS LAST)
    WITH (deduplicate_items=True)
    TABLESPACE pg_default;

SELECT * FROM "CustomerDetails".customers

ALTER TABLE "CustomerDetails".customers
ALTER COLUMN customerid
DROP IDENTITY;

UPDATE "CustomerDetails".customers
SET customerid = 1;


ALTER TABLE "CustomerDetails".customers
ALTER COLUMN customerid
ADD GENERATED ALWAYS AS IDENTITY;


INSERT INTO "CustomerDetails".customers (
    customertitleid
    ,customerlastname
    ,customerfirstname
    ,customerotherinitials
    ,addressid
    ,accauntnumber
    ,accaunttypeid
    ,clearedbalance
    ,unclearedbalance
)
VALUES 
    (1, 'Brust', 'Andrew', 'J.', 133, 18176111, 1, 200.00, 2.00),
    (3, 'Lobel', 'Leonard', NULL, 145, 53431993, 1, 437.97, -10.56)
;

ALTER SEQUENCE "CustomerDetails".customers_customerid_seq RESTART WITH 2;

-- задание 2
-- 1 
ALTER TABLE "CustomerDetails".customersproducts
ADD CONSTRAINT pk_customersproducts
PRIMARY KEY (customerfinancialproductid);

ALTER TABLE "CustomerDetails".customersproducts
ADD CONSTRAINT ck_custprods_amtcheck
CHECK (amounttocollect > 0::money);

ALTER TABLE "CustomerDetails".customersproducts
ALTER COLUMN renewable
SET DEFAULT false;

-- 4
INSERT INTO "CustomerDetails".customersproducts
    (customerid
    , financialproductid
    , amounttocollect
    , frequency
    , lastcollected
    , lastcollection
    , renewable)
VALUES(1, 1, -100, 0, '2023-08-24', '2023-08-24', false);

INSERT INTO "CustomerDetails".customersproducts
    (customerid
    , financialproductid
    , amounttocollect
    , frequency
    , lastcollected
    , lastcollection
    , renewable)
VALUES(1, 1, 100, 0, '2023-08-24', '2023-08-20', false);

-- Задание 3
SELECT * FROM "CustomerDetails".customers

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
VALUES 
    (3, 'Bernie', 'I', 'McGee', 314, 65368765, 1, 6653.11, 0.00),
    (2, 'Julie', 'A', 'Dewson', 2134, 81625422, 1, 53.32, -12.21),
    (1, 'Kristy', NULL, 'Hull', 4312, 96656334, 1, 1266.00, 10.32);

SELECT * FROM "ShareDetails".shares

INSERT INTO "ShareDetails".shares (
    sharedesc
    , sharetickerid
    , currentprice
)
VALUES 
    ('FAT-BELLY.COM', 'FBC', 45.20)
    , ('NetRadio Inc', 'NRI', 29.79)
    , ('Texas Oil Industries', 'TOI', 0.455)
    , ('London Bridge Club', 'LBC', 1.46)
;

-- задание 4
SELECT * FROM "CustomerDetails".customers

SELECT
    customerfirstname AS "First Name"
    , customerlastname AS "Last Name"
    , clearedbalance Balance
FROM "CustomerDetails".customers;

-- задание 5
--1
UPDATE "CustomerDetails".customers
SET customerlastname = 'Brodie'
WHERE customerid = 4;
-- check
SELECT customerlastname 
FROM "CustomerDetails".customers
WHERE customerid = 4;

--2
DO 
$$
DECLARE
    ValueToUpdate VARCHAR(30);
BEGIN
    ValueToUpdate := 'McGlynn';

    UPDATE "CustomerDetails".customers
    SET
        customerlastname = ValueToUpdate
        , clearedbalance = clearedbalance + unclearedbalance
        , unclearedbalance = 0
    WHERE customerlastname = 'Brodie';
END
$$

-- 3
-- not work
DO 
$$
DECLARE
    WrongDataType VARCHAR(20) := '4311.22';
BEGIN
    UPDATE "CustomerDetails".customers
    SET
        clearedbalance = WrongDataType
    WHERE customerid = 4;
END
$$

-- work
DO 
$$
DECLARE
    WrongDataType VARCHAR(20) := '4311,22';
BEGIN
    UPDATE "CustomerDetails".customers
    SET
        clearedbalance = WrongDataType::money
    WHERE customerid = 4;
END
$$

-- Задание 6
CREATE TEMPORARY TABLE tmp_customers
AS SELECT
    customerid
    , customerfirstname
    , customerotherinitials
    , customerlastname
FROM "CustomerDetails".customers;

SELECT * FROM tmp_customers;

DELETE FROM tmp_customers
WHERE customerid = 4;

INSERT INTO tmp_customers (
    customerfirstname
    , customerotherinitials
    , customerlastname
)
VALUES ('Dmitrij', 'J', 'Vetrov');

DELETE FROM tmp_customers
WHERE customerid IS NULL;

ALTER TABLE tmp_customers
ALTER COLUMN customerid
SET NOT NULL;


ALTER TABLE tmp_customers
ALTER COLUMN customerid
ADD GENERATED ALWAYS AS IDENTITY ( INCREMENT 1 START 7);

DELETE FROM tmp_customers;

TRUNCATE TABLE tmp_customers;

TRUNCATE TABLE tmp_customers RESTART IDENTITY;

ALTER TABLE tmp_customers
ALTER COLUMN customerid
DROP IDENTITY;

ALTER TABLE tmp_customers
ALTER COLUMN customerid
ADD GENERATED ALWAYS AS IDENTITY ( INCREMENT 1 START 1);

