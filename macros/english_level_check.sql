-- macros/english_level_check.sql
{% test english_level_check(model, column_name) %}
    SELECT *
    FROM {{ model }}
    WHERE {{ column_name }} NOT LIKE 'A%' AND
          {{ column_name }} NOT LIKE 'B%' AND
          {{ column_name }} NOT LIKE 'C%' AND
          {{ column_name }} != 'Unspecified' AND
          {{ column_name }} != 'Native'
{% endtest %}