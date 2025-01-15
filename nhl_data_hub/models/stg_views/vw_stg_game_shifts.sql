-- models/views/vw_stg_game_shifts.sql

-- Log the start of the process 
{{ log("Starting the creation of the internal table from the external table...", info=True) }}
{{ config(materialized='view') }}

WITH vw_stg_game_shifts AS (
    SELECT
        game_id,
        player_id,
        `period`,
        shift_start,
        shift_end,
        CURRENT_TIMESTAMP() AS dw_load_timestamp
    FROM
        `{{ target.dataset }}.stg_game_shifts`
)

SELECT * 
FROM vw_stg_game_shifts

-- Log the completion of the process 
{{ log("Completed the creation of the internal table from the external table.", info=True) }}