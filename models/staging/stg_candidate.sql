-- depends_on: {{ ref('config') }}
{{ config(materialized='table') }}

{{ staging_macro(
    raw_table_name = 'CANDIDATES',
    business_key = 'candidate_id',
    updated_at_col = '_updated_micros'
) }}