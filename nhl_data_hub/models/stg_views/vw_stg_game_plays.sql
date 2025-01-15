-- models/views/vw_stg_game_plays.sql

-- Log the start of the process 
{{ log("Starting the creation of the internal table from the external table...", info=True) }}
{{ config(materialized='view') }}

WITH vw_stg_game_plays AS (
    SELECT
        play_id,
        game_id,
        team_id_for,
        team_id_against,
        UPPER(event) AS event,
        UPPER(secondaryType) as secondaryType,
        x,
        y,
        `period`,
        UPPER(periodType) AS periodType,
        periodTime,
        periodTimeRemaining,
        `dateTime`,
        goals_away,
        goals_home,
        UPPER(`description`) AS `description`,
        st_x,
        st_y,        
        CURRENT_TIMESTAMP() AS dw_load_timestamp
    FROM
        `{{ target.dataset }}.stg_game_plays`
)

SELECT * 
FROM vw_stg_game_plays

-- Log the completion of the process 
{{ log("Completed the creation of the internal table from the external table.", info=True) }}