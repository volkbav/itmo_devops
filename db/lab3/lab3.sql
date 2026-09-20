-- Задание 2
CREATE DATABASE "ApressFinancial"
    WITH
    OWNER = alex
    ENCODING = 'UTF8'
    LC_COLLATE = "en_US.utf8"
    LC_CTYPE = "en_US.utf8"
    CONNECTION LIMIT = 1
    TABLESPACE = pg_default
    IS_TEMPLATE = False;

-- Задание 3

CREATE SCHEMA IF NOT EXISTS "TransactionDetails"
    AUTHORIZATION alex;