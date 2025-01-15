-- models/staging/stg_games.sql

-- Log the start of the process 
{{ log("Starting the creation of the internal table from the external table...", info=True) }}
{{ config(materialized='table') }}

WITH stg_games AS (
    SELECT
        CAST(game_id AS INT64) AS game_id,
        CAST(season AS INT64) AS season,
        CAST(type AS STRING) AS type,
        CAST(date_time_GMT AS TIMESTAMP) AS date_time_GMT,
        CAST(away_team_id AS INT64) AS away_team_id,
        CAST(home_team_id AS INT64) AS home_team_id,
        CAST(away_goals AS SMALLINT) AS away_goals,
        CAST(home_goals AS SMALLINT) AS home_goals,
        CAST(outcome AS STRING) AS outcome,
        CAST(home_rink_side_start AS STRING) AS home_rink_side_start,
        CAST(venue as STRING) AS venue,
        CAST(venue_link as STRING) AS venue_link,
        CAST(venue_time_zone_id as STRING) AS venue_time_zone_id,
        CAST(venue_time_zone_offset as SMALLINT) AS venue_time_zone_offset,
        CAST(venue_time_zone_tz as STRING) AS venue_time_zone_tz,
        CURRENT_TIMESTAMP() AS dw_load_timestamp
    FROM
        `{{ target.dataset }}.external_game`
)

SELECT * 
FROM stg_games

-- Log the completion of the process 
{{ log("Completed the creation of the internal table from the external table.", info=True) }}