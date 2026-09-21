-- Задание 1
CREATE TABLE "CustomerDetails"."customers"
(
    customerid bigint NOT NULL GENERATED ALWAYS AS IDENTITY,
    customertitleid integer NOT NULL,
    customerfirstname character varying(50) NOT NULL,
    customerotherinitials character varying(10)[],
    customerlastname character varying(50)[] NOT NULL,
    addressid bigint NOT NULL,
    accauntnumber character(15)[] NOT NULL,
    accaunttypeid integer NOT NULL,
    clearedbalance money NOT NULL,
    unclearedbalance money NOT NULL,
    dateadded date NOT NULL DEFAULT current_date,
    PRIMARY KEY (customerid)
);

ALTER TABLE IF NOT EXISTS "CustomerDetails"."customers"
    OWNER to alex;

COMMENT ON TABLE "CustomerDetails"."customers"
    IS 'некое описание таблицы';

-- Задание 2
CREATE TABLE IF NOT EXISTS "TransactionDetails".transactions (
    transactionid bigint GENERATED ALWAYS AS IDENTITY ( INCREMENT 1 START 1) 
        PRIMARY KEY NOT NULL,
    customerid bigint NOT NULL,
    transactiontype int NOT NULL,
    dateentered timestamp(0) NOT NULL,
    amount numeric(18,5) NOT NULL,
    referencedetails varchar(50) NULL,
    notes varchar(50) NULL,
    relatedshareid bigint NULL,
    relatedproductid bigint NOT NULL
);

CREATE TABLE IF NOT EXISTS "TransactionDetails".transactiontypes (
    transactiontypesid int  GENERATED ALWAYS AS IDENTITY NOT NULL,
    transactiondescription varchar(30) NOT NULL,
    credittype boolean NOT NULL
);

-- задание 3
-- 1
ALTER TABLE "TransactionDetails".transactiontypes
ADD affectcashbalance boolean NULL;
-- 2
ALTER TABLE "TransactionDetails".transactiontypes
ALTER COLUMN affectcashbalance SET NOT NULL;
-- 3
ALTER TABLE "TransactionDetails".transactiontypes
ADD CONSTRAINT PK_TransactionTypes PRIMARY KEY (transactiontypesid);

-- задание 4
CREATE TABLE IF NOT EXISTS "CustomerDetails".customersproducts (
    customerfinancialproductid bigint GENERATED ALWAYS AS IDENTITY NOT NULL,
    customerid bigint NOT NULL,
    financialproductid bigint NOT NULL,
    amounttocollect money NOT NULL,
    frequency int NOT NULL,
    lastcollected timestamp(0) NOT NULL,
    lastcollection timestamp(0) NOT NULL,
    renewable boolean NOT NULL
);

CREATE TABLE IF NOT EXISTS "CustomerDetails".financialproducts (
    productid bigint NOT NULL,
    productname varchar(50) NOT NULL
);

CREATE SCHEMA IF NOT EXISTS "ShareDetails" AUTHORIZATION alex;

CREATE TABLE IF NOT EXISTS "ShareDetails".shareprices (
    sharepriceid bigint GENERATED ALWAYS AS IDENTITY NOT NULL,
    shareid bigint NOT NULL,
    price numeric(18,5) NOT NULL,
    pricedate timestamp(0) NOT NULL
);

CREATE TABLE IF NOT EXISTS "ShareDetails".shares (
    shareid bigint GENERATED ALWAYS AS IDENTITY NOT NULL,
    sharedesc varchar(50) NOT NULL,
    sharetickerid varchar(50) NULL,
    currentprice numeric(18,5) NOT NULL
);

-- задание 5
-- выполнено в графике
ALTER TABLE IF EXISTS "TransactionDetails".transactions
    ADD CONSTRAINT fk_customers_transactions FOREIGN KEY (customerid)
    REFERENCES "CustomerDetails".customers (customerid) MATCH SIMPLE
    ON UPDATE NO ACTION
    ON DELETE NO ACTION
    NOT VALID;
CREATE INDEX IF NOT EXISTS fki_fk_customers_transactions
    ON "TransactionDetails".transactions(customerid);

-- задание 6
ALTER TABLE "TransactionDetails".transactions
ADD CONSTRAINT fk_transactions_shares FOREIGN KEY (relatedshareid)
REFERENCES "ShareDetails".shares(shareid);

-- исправление ошибки
ALTER TABLE "ShareDetails".shares
ADD CONSTRAINT pk_shares PRIMARY KEY (shareid);