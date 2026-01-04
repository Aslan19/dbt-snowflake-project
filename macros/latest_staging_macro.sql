{% macro latest_staging_macro(
    stg_model
) %}

SELECT *
FROM {{ ref(stg_model) }}
WHERE row_is_active = 1

{% endmacro %}
