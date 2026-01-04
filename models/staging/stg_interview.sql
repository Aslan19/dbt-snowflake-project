-- depends_on: {{ ref('config') }}
{{ config(materialized='table') }}

{{ staging_macro(
    raw_table_name = 'INTERVIEWS',
    business_key = 'id',
    updated_at_col = '_updated_micros'
) }}