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


-- задание 3
-- задание 4