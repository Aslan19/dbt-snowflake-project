{% docs stg_interview %}

The **Interview Staging model** represents the full history of interview records.

Each interview can appear multiple times as its status changes
(for example: created, scheduled, in progress, completed).
The model keeps these historical versions so downstream models
can understand how interviews evolved over time.

This model is the foundation for interview analytics and is used
to calculate durations, delays, and lifecycle metrics.

{% enddocs %}

{% docs stg_candidate %}

The **Candidate Staging model** contains historical candidate attributes.

It tracks changes in candidate information such as staffing status,
English level, and assigned job function.
Multiple rows can exist for the same candidate to reflect how
their profile changed over time.

This history allows analytics to use the candidate’s attributes
as they were at a specific point in time.

{% enddocs %}

{% docs stg_employee %}

The **Employee Staging model** represents historical employee records.

It captures changes in employment status, organizational assignment,
job function, and activity flags.
The model preserves previous states so employee attributes
can be accurately aligned with events that happened in the past.

{% enddocs %}

{% docs stg_job_function %}

The **Job Function Staging model** describes roles within the organization.

It includes job categories, seniority levels, and career tracks.
Historical versions are retained so that analytics can reflect
how job roles were defined at the time an event occurred.

{% enddocs %}

{% docs stg_skill %}

The **Skill Staging model** contains the catalog of skills
and their hierarchical relationships.

It includes information about whether a skill is active, primary,
or considered a key skill.
The model supports skill-based analysis and role profiling.

{% enddocs %}

{% docs stg_date %}

The **Date Staging model** is a generated calendar table.

It provides commonly used date attributes such as year, month,
week, day name, and weekend indicators.
This model supports time-based reporting and trend analysis.

{% enddocs %}
