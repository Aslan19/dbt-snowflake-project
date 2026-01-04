{{ config(materialized='table') }}

WITH date_range AS (

    -- generate dates from 2010-01-01 to 2035-12-31 (adjust as needed)
    SELECT
        DATEADD(day, seq4(), TO_DATE('2010-01-01')) AS date_day
    FROM TABLE(GENERATOR(ROWCOUNT => 40000))   -- ~110 years of dates

),

enhanced AS (
    SELECT
        date_day,
        YEAR(date_day)                           AS year,
        QUARTER(date_day)                        AS quarter,
        MONTH(date_day)                          AS month,
        DAY(date_day)                            AS day,
        WEEK(date_day)                           AS week,
        DAYOFWEEK(date_day)                      AS day_of_week,
        DAYNAME(date_day)                        AS day_name,
        MONTHNAME(date_day)                      AS month_name,
        CASE WHEN DAYOFWEEK(date_day) IN (6, 7) THEN TRUE ELSE FALSE END AS is_weekend
    FROM date_range
)

SELECT *
FROM enhanced
ORDER BY date_day
