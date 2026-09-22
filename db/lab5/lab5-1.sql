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
