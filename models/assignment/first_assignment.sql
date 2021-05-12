{{ config(materialized='table') }}

WITH T1 AS (SELECT O_ORDERDATE, SUM(O_TOTALPRICE) AS TOTAL_PRICE FROM "SNOWFLAKE_SAMPLE_DATA"."TPCH_SF1"."ORDERS" GROUP BY O_ORDERDATE)
SELECT O_ORDERDATE, SUM(TOTAL_PRICE) OVER (ORDER BY O_ORDERDATE ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) AS CUM_SALES FROM T1
