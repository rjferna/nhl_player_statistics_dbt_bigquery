-- models/staging/stg_game_plays.sql

-- Log the start of the process 
{{ log("Starting the creation of the internal table from the external table...", info=True) }}
{{ config(materialized='table') }}

WITH stg_game_plays AS (
    SELECT
        SAFE_CAST(REPLACE(play_id, '_', '000') AS INT64) AS play_id,
        SAFE_CAST(game_id AS INT64) AS game_id,
        SAFE_CAST(team_id_for AS INT64) AS team_id_for,
        SAFE_CAST(team_id_against AS INT64) AS team_id_against,
        SAFE_CAST(event AS STRING) AS event,
        SAFE_CAST(secondaryType AS STRING) as secondaryType,
        SAFE_CAST(x AS INT64) AS x,
        SAFE_CAST(y AS INT64) AS y,
        SAFE_CAST(period AS INT64) AS `period`,
        SAFE_CAST(periodType AS STRING) AS periodType,
        SAFE_CAST(periodTime AS INT64) AS periodTime,
        SAFE_CAST(periodTimeRemaining AS INT64) AS periodTimeRemaining,
        SAFE_CAST(dateTime AS TIMESTAMP) AS `dateTime`,
        SAFE_CAST(goals_away AS INT64) AS goals_away,
        SAFE_CAST(goals_home AS INT64) AS goals_home,
        SAFE_CAST(description AS STRING) AS `description`,
        SAFE_CAST(st_x AS INT64) AS st_x,
        SAFE_CAST(st_y AS INT64) AS st_y,        
        CURRENT_TIMESTAMP() AS dw_load_timestamp
    FROM
        `{{ target.dataset }}.external_game_plays`
)

SELECT * 
FROM stg_game_plays

-- Log the completion of the process 
{{ log("Completed the creation of the internal table from the external table.", info=True) }}