-- models/views/vw_stg_game_scratches.sql

-- Log the start of the process 
{{ log("Starting the creation of the internal table from the external table...", info=True) }}
{{ config(materialized='view') }}

WITH vw_stg_game_scratches AS (
    SELECT
        game_id,
        team_id,
        player_id,
        CURRENT_TIMESTAMP() AS dw_load_timestamp
    FROM
        `{{ target.dataset }}.stg_game_scratches`
)

SELECT * 
FROM vw_stg_game_scratches

-- Log the completion of the process 
{{ log("Completed the creation of the internal table from the external table.", info=True) }}