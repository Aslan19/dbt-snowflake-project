{% snapshot snapshot_interview %}

{{
    config(
        target_schema = 'SNAPSHOTS',
        unique_key    = 'id',
        strategy      = 'timestamp',
        updated_at    = 'updated_at',
        hard_delete   = false
    )
}}

SELECT *
FROM {{ ref('stg_interview') }}

{% endsnapshot %}
