{{
    config(materialized='incremental', unique_key='t_time_sk')
}}

WITH dim_times AS (
        Select *
        from "SNOWFLAKE_SAMPLE_DATA"."TPCDS_SF10TCL"."TIME_DIM"
        WHERE to_time(concat(T_HOUR::varchar, ':', T_MINUTE, ':', T_SECOND)) <= current_time
        {% if is_incremental() %}
            AND to_time(concat(T_HOUR::varchar, ':', T_MINUTE, ':', T_SECOND)) > (SELECT MAX(to_time(concat(T_HOUR::varchar, ':', T_MINUTE, ':', T_SECOND))) FROM {{ this}})
        {% endif %}
                )
SELECT * FROM dim_times
