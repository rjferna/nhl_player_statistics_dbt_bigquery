-- models/views/vw_stg_game_teams_stats.sql

-- Log the start of the process 
{{ log("Starting the creation of the internal table from the external table...", info=True) }}
{{ config(materialized='view') }}

WITH vw_stg_game_teams_stats AS (
    SELECT DISTINCT
        game_id,
        team_id,
        UPPER(HoA) AS HoA,
        Won,
        UPPER(settled_in) AS settled_in,
        UPPER(head_coach) AS head_coach,
        goals,
        shots,
        hits,
        pim,
        powerPlayOpportunities,
        powerPlayGoals,
        faceOffWinPercentage,
        giveaways,
        takeaways,
        blocked,
        UPPER(startRankSide) AS startRankSide,
        CURRENT_TIMESTAMP() AS dw_load_timestamp
    FROM
        `{{ target.dataset }}.stg_game_teams_stats`
)

SELECT * 
FROM vw_stg_game_teams_stats

-- Log the completion of the process 
{{ log("Completed the creation of the internal table from the external table.", info=True) }}