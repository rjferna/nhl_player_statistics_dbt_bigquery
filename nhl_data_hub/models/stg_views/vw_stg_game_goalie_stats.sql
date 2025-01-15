-- models/views/vw_stg_game_goalies_stats.sql

-- Log the start of the process 
{{ log("Starting the creation of the internal table from the external table...", info=True) }}
{{ config(materialized='view') }}

WITH vw_stg_game_goalie_stats AS (
    SELECT DISTINCT
        game_id,
        player_id,
        team_id,
        timeOnIce,
        assists,
        goals,
        pim,
        shots,
        saves,
        powerPlaySaves,
        shortHandedSaves,
        evenSaves,
        shortHandedShotsAgainst,
        evenShotsAgainst,
        powerPlayShotsAgainst,
        decision,
        savePercentage,
        powerPlaySavePercentage,
        evenStrengthSavePercentage,
        CURRENT_TIMESTAMP() AS dw_load_timestamp
    FROM
        `{{ target.dataset }}.stg_game_goalie_stats`
)

SELECT * 
FROM vw_stg_game_goalie_stats

-- Log the completion of the process 
{{ log("Completed the creation of the internal table from the external table.", info=True) }}