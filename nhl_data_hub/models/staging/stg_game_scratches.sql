-- models/staging/stg_game_plays_players.sql

-- Log the start of the process 
{{ log("Starting the creation of the internal table from the external table...", info=True) }}
{{ config(materialized='table') }}

WITH stg_game_scratches AS (
    SELECT
        SAFE_CAST(game_id AS INT64) AS game_id,
        SAFE_CAST(team_id AS INT64) AS team_id,
        SAFE_CAST(player_id AS INT64) AS player_id,
        CURRENT_TIMESTAMP() AS dw_load_timestamp
    FROM
        `{{ target.dataset }}.external_game_scratches`
)

SELECT * 
FROM stg_game_scratches

-- Log the completion of the process 
{{ log("Completed the creation of the internal table from the external table.", info=True) }}