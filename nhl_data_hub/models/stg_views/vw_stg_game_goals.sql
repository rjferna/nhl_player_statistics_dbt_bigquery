-- models/views/vw_stg_game_goals.sql

-- Log the start of the process 
{{ log("Starting the creation of the internal table from the external table...", info=True) }}
{{ config(materialized='view') }}

WITH vw_stg_game_goals AS (
    SELECT DISTINCT
        play_id,
        UPPER(strength) as strength,
        gameWinningGoal,
        emptyNet,
        CURRENT_TIMESTAMP() AS dw_load_timestamp
    FROM
        `{{ target.dataset }}.stg_game_goals`
)

SELECT * 
FROM vw_stg_game_goals

-- Log the completion of the process 
{{ log("Completed the creation of the internal table from the external table.", info=True) }}