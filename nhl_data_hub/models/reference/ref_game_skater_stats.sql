-- models/reference/ref_game_skater_stats.sql

-- Log the start of the process 
{{ log("Starting the creation of the internal reference table from the view table...", info=True) }}
{{ config(materialized='table') }}

SELECT DISTINCT
gs.game_id,
gs.team_id,
gs.player_id,
gs.timeOnIce,
gs.assists,
gs.goals,
gs.shots,
gs.hits,
gs.penaltyMinutes,
gs.faceOffWins,
gs.faceOffTaken,
gs.takeaways,
gs.giveaways,
gs.blocked,
gs.plusMinus,
gs.powerPlayGoals,
gs.powerPlayAssists,
gs.powerPlayTimeOnIce,
gs.shortHandedGoals,
gs.shortHandedAssists,
gs.shortHandedTimeOnIce,
CURRENT_TIMESTAMP() as DW_LOAD_TIMESTAMP
FROM 
  `{{ target.dataset }}.vw_stg_game_skater_stats` AS gs

-- Log the completion of the process 
{{ log("Completed the creation of the internal reference table from the view table.", info=True) }}