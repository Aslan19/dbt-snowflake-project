{% macro staging_macro(
    raw_table_name,
    business_key,
    updated_at_col
) %}

{% if execute %}
    {% set results = run_query(
        "select raw_column_name,
                target_column_name,
                target_data_type
         from " ~ ref('config') ~ "
         where raw_table_name = '" ~ raw_table_name ~ "'
         order by target_order_num"
    ) %}
    {% set cols = results.rows %}
{% else %}
    {% set cols = [] %}
{% endif %}


WITH base AS (

    SELECT
        {% for col in cols %}
            {% set raw_col = col[0] %}
            {% set tgt_col = col[1] %}
            {% set tgt_type = col[2] %}

            {% if tgt_type.upper() == 'TIMESTAMP'
                  and raw_col.upper().endswith('_MICROS') %}
                TO_TIMESTAMP(
                    TRY_TO_NUMBER("{{ raw_col }}") / 1e6
                ) AS {{ tgt_col }}
            {% else %}
                CAST("{{ raw_col }}" AS {{ tgt_type }})
                    AS {{ tgt_col }}
            {% endif %}
            {% if not loop.last %},{% endif %}
        {% endfor %}

    FROM {{source("raw", raw_table_name)}}

),

history AS (

    SELECT
        *,
        {{ updated_at_col }} AS row_valid_from,
        LEAD({{ updated_at_col }}) OVER (
            PARTITION BY {{ business_key }}
            ORDER BY {{ updated_at_col }}
        ) AS next_valid_from
    FROM base

),

final AS (

    SELECT
        * EXCLUDE (next_valid_from),
        COALESCE(
            next_valid_from,
            TO_TIMESTAMP_NTZ('9999-12-31')
        ) AS row_valid_to,
        CASE
            WHEN next_valid_from IS NULL THEN 1
            ELSE 0
        END AS row_is_active
    FROM history

)

SELECT *
FROM final

{% endmacro %}
