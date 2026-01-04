{{ config(materialized='table') }}

SELECT
    id,
    is_active,
    type       AS type,
    name,
    url,
    parent_id
FROM {{ ref('stg_skill') }}
