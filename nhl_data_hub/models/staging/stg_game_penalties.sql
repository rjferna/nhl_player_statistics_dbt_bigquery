-- models/staging/stg_game_penalties.sql

-- Log the start of the process 
{{ log("Starting the creation of the internal table from the external table...", info=True) }}
{{ config(materialized='table') }}

WITH stg_game_penalties AS (
    SELECT
        SAFE_CAST(REPLACE(play_id, '_', '000') AS INT64) AS play_id,
        CAST(penaltySeverity AS STRING) AS penaltySeverity,
        CAST(penaltyMinutes AS SMALLINT) AS penaltyMinutes,
        CURRENT_TIMESTAMP() AS dw_load_timestamp
    FROM
        `{{ target.dataset }}.external_game_penalties`
)

SELECT * 
FROM stg_game_penalties

-- Log the completion of the process 
{{ log("Completed the creation of the internal table from the external table.", info=True) }}