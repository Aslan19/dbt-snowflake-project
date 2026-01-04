-- depends_on: {{ ref('config') }}
{{ config(materialized='table') }}

{{ staging_macro(
    raw_table_name = 'JOB_FUNCTIONS',
    business_key = 'job_function_id',
    updated_at_col = '_updated_micros'
) }}