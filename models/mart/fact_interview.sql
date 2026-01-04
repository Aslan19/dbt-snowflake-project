{{ config(materialized='table') }}

WITH interview_created AS (

    -- base record: interview at creation moment
    SELECT *
    FROM {{ ref('stg_interview') }}
    WHERE status = 'DRAFT'

),

status_events AS (

    -- all status changes with timestamps
    SELECT
        id                 AS interview_id,
        status,
        row_valid_from     AS status_ts
    FROM {{ ref('stg_interview') }}

),

status_times AS (

    SELECT
        interview_id,

        -- MIN(CASE WHEN status = 'DRAFT'
        --          THEN status_ts END) AS created_datetime,

        -- MIN(CASE WHEN status = 'SCHEDULED'
        --          THEN status_ts END) AS scheduled_datetime,

        MIN(CASE WHEN status = 'IN_PROGRESS'
                 THEN status_ts END) AS in_progress_datetime,

        MIN(CASE WHEN status = 'PENDING_FEEDBACK'
                 THEN status_ts END) AS pending_feedback_datetime,

        MIN(CASE WHEN status = 'COMPLETED'
                 THEN status_ts END) AS completed_datetime,

        MIN(CASE WHEN status = 'CANCELLED'
                 THEN status_ts END) AS cancelled_datetime

    FROM status_events
    GROUP BY interview_id

)

SELECT
    b.id                         AS id,
    b.candidate_type,
    b._offset                     AS candidate_offset,
    b.status,
    b.interviewer_id             AS interviewer_offset,
    b.location,
    b.logged,
    b.media_available,
    b.run_type,
    b.type             AS type,
    b.media_status,
    b.invite_answer_status,

    -- timestamps
    -- t.created_datetime,
    -- DATE(t.created_datetime)     AS created_date,
    -- t.scheduled_datetime,
    t.in_progress_datetime,
    t.pending_feedback_datetime,
    t.completed_datetime,
    t.cancelled_datetime,

    -- metrics
    DATEDIFF(
        hour,
        t.in_progress_datetime,
        t.pending_feedback_datetime
    ) AS interview_duration,

    DATEDIFF(
        hour,
        t.pending_feedback_datetime,
        COALESCE(t.completed_datetime, t.cancelled_datetime)
    ) AS feedback_delay

FROM interview_created b
LEFT JOIN status_times t
    ON b.id = t.interview_id
