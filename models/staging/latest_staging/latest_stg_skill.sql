{{ config(materialized='table') }}

{{latest_staging_macro(
    stg_model="stg_skill"
)}}
