-- models/views/vw_stg_team_info.sql

-- Log the start of the process 
{{ log("Starting the creation of the internal table from the external table...", info=True) }}
{{ config(materialized='view') }}

WITH vw_stg_team_info AS (
    SELECT
        team_id,
        franchiseId,
        UPPER(shortName) AS shortName,
        UPPER(teamName) AS teamName,
        UPPER(abbreviation) AS abbreviation,
        CURRENT_TIMESTAMP() AS dw_load_timestamp
    FROM
        `{{ target.dataset }}.stg_team_info`
)

SELECT * 
FROM vw_stg_team_info

-- Log the completion of the process 
{{ log("Completed the creation of the internal table from the external table.", info=True) }}