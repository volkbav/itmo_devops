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
