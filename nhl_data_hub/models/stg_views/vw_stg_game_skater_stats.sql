-- models/views/vw_stg_game_skater_stats.sql

-- Log the start of the process 
{{ log("Starting the creation of the internal table from the external table...", info=True) }}
{{ config(materialized='view') }}

with vw_stg_game_skater_stats AS (
    SELECT DISTINCT
    game_id,
    player_id,
    team_id,
    timeOnIce,
    assists,
    goals,
    shots,
    hits,
    penaltyMinutes,
    faceOffWins,
    faceOffTaken,
    takeaways,
    giveaways,
    blocked,
    plusMinus,
    evenTimeOnIce,
    powerPlayGoals,
    powerPlayAssists,
    powerPlayTimeOnIce,
    shortHandedGoals,
    shortHandedAssists,
    shortHandedTimeOnIce,
    CURRENT_TIMESTAMP() as DW_LOAD_TIMESTAMP
    FROM 
        `{{ target.dataset }}.stg_game_skater_stats`
)

SELECT *
FROM vw_stg_game_skater_stats

-- Log the completion of the process 
{{ log("Completed the creation of the internal table from the external table.", info=True) }}