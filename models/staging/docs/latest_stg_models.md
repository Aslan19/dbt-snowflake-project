{% docs stg_interview_latest %}

The **Latest Interview Staging model** contains the current state of each interview.

Each interview appears only once, representing its most recent status
and attributes.
This model is useful for operational reporting, dashboards,
and use cases where only the current interview state matters.

Historical changes are intentionally excluded.

{% enddocs %}


{% docs stg_candidate_latest %}

The **Latest Candidate Staging model** represents the current profile of each candidate.

It contains the most up-to-date candidate attributes such as staffing status,
English level, and job function.
This model is intended for current-state reporting
and should not be used when historical accuracy is required.

{% enddocs %}

{% docs stg_employee_latest %}

The **Latest Employee Staging model** provides the current snapshot of employee information.

It reflects the employee’s most recent organizational assignment,
employment status, and job function.
This model is suitable for headcount reporting and operational views
that require only the current employee state.

{% enddocs %}

{% docs stg_job_function_latest %}

The **Latest Job Function Staging model** represents the current definition
of job roles within the organization.

It includes only the active version of each job function,
excluding historical changes.
This model is useful for reporting on the current role structure
and organizational taxonomy.

{% enddocs %}

{% docs stg_skill_latest %}

The **Latest Skill Staging model** contains the current catalog of skills.

Only the active and most recent definition of each skill is included.
This model supports current skill analysis, role matching,
and reporting that does not require historical context.

{% enddocs %}
