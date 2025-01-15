-- models/staging/stg_game_goals.sql

-- Log the start of the process 
{{ log("Starting the creation of the internal table from the external table...", info=True) }}
{{ config(materialized='table') }}

WITH stg_games AS (
    SELECT
        CAST(REPLACE(play_id, '_', '000') AS INT64) AS play_id,
        CAST(strength AS STRING) AS strength,
        CAST(gameWinningGoal AS BOOL) AS gameWinningGoal,
        CAST(emptyNet AS BOOL) AS emptyNet,
        CURRENT_TIMESTAMP() AS dw_load_timestamp
    FROM
        `{{ target.dataset }}.external_game_goals`
)

SELECT * 
FROM stg_games

-- Log the completion of the process 
{{ log("Completed the creation of the internal table from the external table.", info=True) }}