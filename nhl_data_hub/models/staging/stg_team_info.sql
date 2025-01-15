-- models/staging/stg_team_info.sql

-- Log the start of the process 
{{ log("Starting the creation of the internal table from the external table...", info=True) }}
{{ config(materialized='table') }}

WITH stg_team_info AS (
    SELECT
        CAST(team_id AS INT64) AS team_id,
        CAST(franchiseId AS INT64) AS franchiseId,
        CAST(shortName AS STRING) AS shortName,
        CAST(teamName AS STRING) AS teamName,
        CAST(abbreviation AS STRING) AS abbreviation,
        CAST(link AS STRING) AS link,
        CURRENT_TIMESTAMP() AS dw_load_timestamp
    FROM
        `{{ target.dataset }}.external_team_info`
)

SELECT * 
FROM stg_team_info

-- Log the completion of the process 
{{ log("Completed the creation of the internal table from the external table.", info=True) }}