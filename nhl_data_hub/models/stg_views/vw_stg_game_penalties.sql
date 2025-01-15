-- models/views/vw_stg_game_penalties.sql

-- Log the start of the process 
{{ log("Starting the creation of the internal table from the external table...", info=True) }}
{{ config(materialized='view') }}

WITH vw_stg_game_penalties AS (
    SELECT DISTINCT
        play_id,
        UPPER(penaltySeverity) AS penaltySeverity,
        penaltyMinutes,
        CURRENT_TIMESTAMP() AS dw_load_timestamp
    FROM
        `{{ target.dataset }}.stg_game_penalties`
)

SELECT * 
FROM vw_stg_game_penalties

-- Log the completion of the process 
{{ log("Completed the creation of the internal table from the external table.", info=True) }}