{{ config(materialized='table') }}

SELECT
    candidate_id,
    staffing_status,
    english_level,
    primary_skill_id,
    job_function_id,
    row_valid_from,
    row_valid_to,
    row_is_active
FROM {{ ref('stg_candidate') }}
