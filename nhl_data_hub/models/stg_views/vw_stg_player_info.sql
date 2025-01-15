-- models/views/vw_stg_player_info.sql

-- Log the start of the process 
{{ log("Starting the creation of the internal table from the external table...", info=True) }}
{{ config(materialized='view') }}

with vw_stg_player_info AS (
    SELECT DISTINCT
    player_id,
    UPPER(firstName) as firstName,
    UPPER(lastName) as lastName,
    CONCAT(firstName, ' ', lastName) as fullName,
    UPPER(nationality) as nationality,
    UPPER(birthStateProvince) as birthStateProvince,
    UPPER(birthcity) as birthcity,
    CAST(CONCAT(REPLACE(LEFT(CAST(birthdate AS STRING), 10), '-', ''), '000') AS INT64) as DoB,
    CAST(DATE_DIFF(CURRENT_DATE(), CAST(LEFT(CAST(birthdate AS STRING), 10) AS DATE), YEAR) AS INT64) as age,
    primaryPosition,
    height_cm,
    `weight`,
    shootsCatches,
    CURRENT_TIMESTAMP() as dw_load_timestamp
    FROM 
        `{{ target.dataset }}.stg_player_info`
)

SELECT *
FROM vw_stg_player_info

-- Log the completion of the process 
{{ log("Completed the creation of the internal table from the external table.", info=True) }}