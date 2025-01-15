--macros/create_external_table_game_team_stats.sql

{% macro create_external_table_game_teams_stats() %}
  {% set create_table_sql %}
  CREATE OR REPLACE EXTERNAL TABLE `{{ target.dataset }}.external_game_teams_stats`
  OPTIONS (
    format = 'PARQUET',
    uris = ['gs://dev-dbt-data-jf/input/nhl-game-data/game_teams_stats.parquet']
  );
  {% endset %}

  {{ log("Executing SQL: " ~ create_table_sql, info=True) }} 
  {{ run_query(create_table_sql) }}
{% endmacro %}
