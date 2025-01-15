-- models/staging/stg_game_officials.sql

-- Log the start of the process 
{{ log("Starting the creation of the internal table from the external table...", info=True) }}
{{ config(materialized='table') }}

WITH stg_game_officials AS (
    SELECT
        CAST(game_id AS INT64) AS game_id,
        CAST(official_name AS STRING) AS official_name,
        CAST(official_type AS STRING) AS official_type,
        CURRENT_TIMESTAMP() AS dw_load_timestamp
    FROM
        `{{ target.dataset }}.external_game_officials`
)

SELECT * 
FROM stg_game_officials

-- Log the completion of the process 
{{ log("Completed the creation of the internal table from the external table.", info=True) }}