-- models/staging/stg_player_info.sql

-- Log the start of the process 
{{ log("Starting the creation of the internal table from the external table...", info=True) }}
{{ config(materialized='table') }}

WITH stg_player_info AS (
    SELECT
        SAFE_CAST(player_id AS INT64) AS player_id,
        SAFE_CAST(firstName AS STRING) AS firstName,
        SAFE_CAST(lastName AS STRING) AS lastName,
        SAFE_CAST(nationality AS STRING) AS nationality,
        SAFE_CAST(birthcity AS STRING) AS birthcity,
        SAFE_CAST(primaryPosition AS STRING) AS primaryPosition,
        SAFE_CAST(birthdate AS STRING) AS birthdate,
        SAFE_CAST(birthStateProvince AS STRING) AS birthStateProvince,
        SAFE_CAST(height AS STRING) AS height,
        SAFE_CAST(height_cm AS FLOAT64) AS height_cm,
        SAFE_CAST(weight AS FLOAT64) AS weight,
        SAFE_CAST(shootsCatches AS STRING) AS shootsCatches,
        CURRENT_TIMESTAMP() AS dw_load_timestamp
    FROM
        `{{ target.dataset }}.external_player_info`
)

SELECT * 
FROM stg_player_info

-- Log the completion of the process 
{{ log("Completed the creation of the internal table from the external table.", info=True) }}