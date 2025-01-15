--macros/create_external_table_game.sql

{% macro create_external_table_game() %}
  {% set create_table_sql %}
  CREATE OR REPLACE EXTERNAL TABLE `{{ target.dataset }}.external_game`
  OPTIONS (
    format = 'PARQUET',
    uris = ['{{ var('gcs_bucket_path') }}/game.parquet']
  );
  {% endset %}

  {{ log("Executing SQL: " ~ create_table_sql, info=True) }} 
  {{ run_query(create_table_sql) }}
{% endmacro %}
{% endmacro %}