-- задание 1
-- выполняется в графике
CREATE UNIQUE INDEX ix_customers_customerid
    ON "CustomerDetails".customers USING btree
    (customerid)
    WITH (deduplicate_items=True)
;

-- задание 2
CREATE INDEX IF NOT EXISTS ix_customersproducts
    ON "CustomerDetails".customersproducts (customerid);

CREATE UNIQUE INDEX IF NOT EXISTS ix_transactiontypes
    ON "TransactionDetails".transactiontypes
    USING btree
    (transactiontypesid ASC);

ALTER TABLE IF EXISTS "TransactionDetails".transactiontypes
    CLUSTER ON ix_transactiontypes;

CREATE INDEX IF NOT EXISTS ix_transactions_ttypes
    ON "TransactionDetails".transactions
    USING btree
    (transactiontype ASC);

-- задание 3
DROP INDEX "TransactionDetails".ix_transactiontypes;

-- задание 4
