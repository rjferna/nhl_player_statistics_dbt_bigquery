-- models/reference/ref_skater_details.sql

-- Log the start of the process 
{{ log("Starting the creation of the internal table from the external table...", info=True) }}
{{ config(materialized='table') }}

WITH CTE AS (
    SELECT
    game_id,
    game_date_gmt_id,
    season,
    home_team_id as team_id
    FROM 
        `{{ target.dataset }}.vw_stg_games`
    UNION DISTINCT
    SELECT
    game_id,  
    game_date_gmt_id,
    season,
    away_team_id as team_id
    FROM 
      `{{ target.dataset }}.vw_stg_games`
)
SELECT DISTINCT
g.game_date_gmt_id,
gs.game_id,
gs.team_id,
g.season,
pi.player_id,
pi.firstName,
pi.lastName,
pi.fullName,
pi.DoB,
pi.age,
pi.nationality,
pi.height_cm,
pi.weight,
pi.shootsCatches,
pi.primaryPosition,
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
  `{{ target.dataset }}.vw_stg_player_info` AS pi
LEFT OUTER JOIN
  `{{ target.dataset }}.vw_stg_game_skater_stats` AS gs ON pi.player_id = gs.player_id
LEFT OUTER JOIN
  CTE AS g ON g.game_id = gs.game_id AND g.team_id = gs.team_id
WHERE 
  pi.nationality IS NOT NULL
AND
  pi.shootsCatches IS NOT NULL  
ORDER BY 
  g.game_date_gmt_id desc

-- Log the completion of the process 
{{ log("Completed the creation of the internal table from the external table.", info=True) }}