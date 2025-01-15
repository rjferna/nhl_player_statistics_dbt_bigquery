--macros/create_external_table_game_penalties.sql

{% macro create_external_table_game_penalties() %}
  {% set create_table_sql %}
  CREATE OR REPLACE EXTERNAL TABLE `{{ target.dataset }}.external_game_penalties`
  OPTIONS (
    format = 'PARQUET',
    uris = ['{{ var('gcs_bucket_path') }}/game_penalties.parquet']
  );
  {% endset %}

  {{ log("Executing SQL: " ~ create_table_sql, info=True) }} 
  {{ run_query(create_table_sql) }}
{% endmacro %}
{% endmacro %}