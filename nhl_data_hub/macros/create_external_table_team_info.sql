--macros/create_external_table_team_info.sql

{% macro create_external_table_team_info() %}
  {% set create_table_sql %}
  CREATE OR REPLACE EXTERNAL TABLE `{{ target.dataset }}.external_team_info`
  OPTIONS (
    format = 'PARQUET',
    uris = ['{{ var('gcs_bucket_path') }}/team_info.parquet']
  );
  {% endset %}

  {{ log("Executing SQL: " ~ create_table_sql, info=True) }} 
  {{ run_query(create_table_sql) }}
{% endmacro %}
{% endmacro %}