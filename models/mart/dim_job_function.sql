{{ config(materialized='table') }}

SELECT
    job_function_id        AS id,
    base_name,
    category,
    is_active,
    level,
    track,
    seniority_level,
    seniority_index,
    row_valid_from         AS valid_from_datetime,
    row_valid_to           AS valid_to_datetime
FROM {{ ref('stg_job_function') }}
