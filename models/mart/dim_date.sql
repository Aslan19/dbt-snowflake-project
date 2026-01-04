{{ config(materialized='table') }}

SELECT
        date_day,
        year,
        quarter,
        month,
        day,
        week,
        day_of_week,
        day_name,
        month_name,
        is_weekend
FROM {{ ref('stg_date') }}
