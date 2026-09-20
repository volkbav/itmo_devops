-- Задание 1
CREATE TABLE "CustomerDetails"."сustomers"
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

ALTER TABLE IF EXISTS "CustomerDetails"."сustomers"
    OWNER to alex;

COMMENT ON TABLE "CustomerDetails"."сustomers"
    IS 'некое описание таблицы';

-- Задание 2
