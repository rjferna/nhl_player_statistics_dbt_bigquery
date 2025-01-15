-- models/views/vw_stg_game_officials.sql

-- Log the start of the process 
{{ log("Starting the creation of the internal table from the external table...", info=True) }}
{{ config(materialized='view') }}

WITH vw_stg_game_officials AS (
    SELECT DISTINCT
        game_id,
        UPPER(official_name) AS official_name,
        UPPER(official_type) AS official_type,
        CURRENT_TIMESTAMP() AS dw_load_timestamp
    FROM
        `{{ target.dataset }}.stg_game_officials`
)

SELECT * 
FROM vw_stg_game_officials

-- Log the completion of the process 
{{ log("Completed the creation of the internal table from the external table.", info=True) }}