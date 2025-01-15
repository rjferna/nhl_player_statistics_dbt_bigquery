-- models/views/vw_stg_game_plays_players.sql

-- Log the start of the process 
{{ log("Starting the creation of the internal table from the external table...", info=True) }}
{{ config(materialized='view') }}

WITH vw_stg_game_plays_players AS (
    SELECT
        play_id,
        game_id,
        player_id,
        UPPER(playerType) as playerType,
        CURRENT_TIMESTAMP() AS dw_load_timestamp
    FROM
        `{{ target.dataset }}.stg_game_plays_players`
)

SELECT * 
FROM vw_stg_game_plays_players

-- Log the completion of the process 
{{ log("Completed the creation of the internal table from the external table.", info=True) }}