-- models/staging/stg_game_shifts.sql

-- Log the start of the process 
{{ log("Starting the creation of the internal table from the external table...", info=True) }}
{{ config(materialized='table') }}

WITH stg_game_shifts AS (
    SELECT
        SAFE_CAST(game_id AS INT64) AS game_id,
        SAFE_CAST(player_id AS INT64) AS player_id,
        SAFE_CAST(period AS SMALLINT) AS period,
        SAFE_CAST(shift_start AS SMALLINT) AS shift_start,
        SAFE_CAST(shift_end AS SMALLINT) AS shift_end,
        CURRENT_TIMESTAMP() AS dw_load_timestamp
    FROM
        `{{ target.dataset }}.external_game_shifts`
)

SELECT * 
FROM stg_game_shifts

-- Log the completion of the process 
{{ log("Completed the creation of the internal table from the external table.", info=True) }}