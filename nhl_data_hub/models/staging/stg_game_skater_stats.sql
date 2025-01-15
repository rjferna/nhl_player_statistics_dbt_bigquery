-- models/staging/stg_game_skater_stats.sql

-- Log the start of the process 
{{ log("Starting the creation of the internal table from the external table...", info=True) }}
{{ config(materialized='table') }}

WITH stg_game_skater_stats AS (
    SELECT
        SAFE_CAST(game_id AS INT64) AS game_id,
        SAFE_CAST(player_id AS INT64) AS player_id,
        SAFE_CAST(team_id AS INT64) AS team_id,
        SAFE_CAST(timeOnIce AS SMALLINT) AS timeOnIce,
        SAFE_CAST(assists AS SMALLINT) AS assists,
        SAFE_CAST(goals AS SMALLINT) AS goals,
        SAFE_CAST(shots AS SMALLINT) AS shots,
        SAFE_CAST(hits AS SMALLINT) AS hits,
        SAFE_CAST(powerPlayGoals AS SMALLINT) AS powerPlayGoals,
        SAFE_CAST(powerPlayAssists AS SMALLINT) AS powerPlayAssists,
        SAFE_CAST(penaltyMinutes AS SMALLINT) AS penaltyMinutes,
        SAFE_CAST(faceOffWins AS SMALLINT) AS faceOffWins,
        SAFE_CAST(faceOffTaken AS SMALLINT) AS faceOffTaken,
        SAFE_CAST(takeaways AS SMALLINT) AS takeaways,
        SAFE_CAST(giveaways AS SMALLINT) AS giveaways,
        SAFE_CAST(shortHandedGoals AS SMALLINT) AS shortHandedGoals,
        SAFE_CAST(shortHandedAssists AS SMALLINT) AS shortHandedAssists,
        SAFE_CAST(blocked AS SMALLINT) AS blocked,
        SAFE_CAST(plusMinus AS SMALLINT) AS plusMinus,
        SAFE_CAST(evenTimeOnIce AS SMALLINT) AS evenTimeOnIce,
        SAFE_CAST(shortHandedTimeOnIce AS SMALLINT) AS shortHandedTimeOnIce,
        SAFE_CAST(powerPlayTimeOnIce AS SMALLINT) AS powerPlayTimeOnIce,
        CURRENT_TIMESTAMP() AS dw_load_timestamp
    FROM
        `{{ target.dataset }}.external_game_skater_stats`
)

SELECT * 
FROM stg_game_skater_stats

-- Log the completion of the process 
{{ log("Completed the creation of the internal table from the external table.", info=True) }}