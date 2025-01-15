-- models/staging/stg_game_teams_stats.sql

-- Log the start of the process 
{{ log("Starting the creation of the internal table from the external table...", info=True) }}
{{ config(materialized='table') }}

WITH stg_game_teams_stats AS (
    SELECT
        SAFE_CAST(game_id AS INT64) AS game_id,
        SAFE_CAST(team_id AS INT64) AS team_id,
        SAFE_CAST(HoA AS STRING) AS HoA,
        SAFE_CAST(Won AS BOOL) as Won,
        SAFE_CAST(settled_in AS STRING) AS settled_in,
        SAFE_CAST(head_coach AS STRING) AS head_coach,
        SAFE_CAST(goals AS SMALLINT) AS goals,
        SAFE_CAST(shots AS SMALLINT) AS shots,
        SAFE_CAST(hits AS SMALLINT) AS hits,
        SAFE_CAST(pim AS SMALLINT) AS pim,
        SAFE_CAST(powerPlayOpportunities AS SMALLINT) AS powerPlayOpportunities,
        SAFE_CAST(powerPlayGoals AS SMALLINT) AS powerPlayGoals,
        SAFE_CAST(faceOffWinPercentage AS FLOAT64) AS faceOffWinPercentage,
        SAFE_CAST(giveaways AS SMALLINT) AS giveaways,
        SAFE_CAST(takeaways AS SMALLINT) AS takeaways,
        SAFE_CAST(blocked AS SMALLINT) AS blocked,
        SAFE_CAST(startRinkSide AS STRING) AS startRankSide,
        CURRENT_TIMESTAMP() AS dw_load_timestamp
    FROM
        `{{ target.dataset }}.external_game_teams_stats`
)

SELECT * 
FROM stg_game_teams_stats

-- Log the completion of the process 
{{ log("Completed the creation of the internal table from the external table.", info=True) }}