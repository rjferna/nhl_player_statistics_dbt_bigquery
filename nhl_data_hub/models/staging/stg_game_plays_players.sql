-- models/staging/stg_game_plays_players.sql

-- Log the start of the process 
{{ log("Starting the creation of the internal table from the external table...", info=True) }}
{{ config(materialized='table') }}

WITH stg_game_plays_players AS (
    SELECT
        SAFE_CAST(REPLACE(play_id, '_', '000') AS INT64) AS play_id,
        SAFE_CAST(game_id AS INT64) AS game_id,
        SAFE_CAST(player_id AS INT64) AS player_id,
        SAFE_CAST(playerType AS STRING) AS playerType,
        CURRENT_TIMESTAMP() AS dw_load_timestamp
    FROM
        `{{ target.dataset }}.external_game_plays_players`
)

SELECT * 
FROM stg_game_plays_players

-- Log the completion of the process 
{{ log("Completed the creation of the internal table from the external table.", info=True) }}