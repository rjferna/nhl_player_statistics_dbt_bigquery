-- models/staging/stg_game_goalies_stats.sql

-- Log the start of the process 
{{ log("Starting the creation of the internal table from the external table...", info=True) }}
{{ config(materialized='table') }}

WITH stg_game_goalie_stats AS (
    SELECT
        SAFE_CAST(game_id AS INT64) AS game_id,
        SAFE_CAST(player_id AS INT64) AS player_id,
        SAFE_CAST(team_id AS INT64) AS team_id,
        SAFE_CAST(timeOnIce AS SMALLINT) AS timeOnIce,
        SAFE_CAST(assists AS SMALLINT) as assists,
        SAFE_CAST(goals AS SMALLINT) AS goals,
        SAFE_CAST(pim AS SMALLINT) AS pim,
        SAFE_CAST(shots AS SMALLINT) AS shots,
        SAFE_CAST(saves AS SMALLINT) AS saves,
        SAFE_CAST(powerPlaySaves AS SMALLINT) AS powerPlaySaves,
        SAFE_CAST(shortHandedSaves AS SMALLINT) AS shortHandedSaves,
        SAFE_CAST(evenSaves AS SMALLINT) AS evenSaves,
        SAFE_CAST(shortHandedShotsAgainst AS SMALLINT) AS shortHandedShotsAgainst,
        SAFE_CAST(evenShotsAgainst AS SMALLINT) AS evenShotsAgainst,
        SAFE_CAST(powerPlayShotsAgainst AS SMALLINT) AS powerPlayShotsAgainst,
        SAFE_CAST(decision AS STRING) AS decision,
        SAFE_CAST(savePercentage AS FLOAT64) AS savePercentage,
        SAFE_CAST(powerPlaySavePercentage AS FLOAT64) AS powerPlaySavePercentage,
        SAFE_CAST(evenStrengthSavePercentage AS FLOAT64) AS evenStrengthSavePercentage,
        CURRENT_TIMESTAMP() AS dw_load_timestamp
    FROM
        `{{ target.dataset }}.external_game_goalie_stats`
)

SELECT * 
FROM stg_game_goalie_stats

-- Log the completion of the process 
{{ log("Completed the creation of the internal table from the external table.", info=True) }}