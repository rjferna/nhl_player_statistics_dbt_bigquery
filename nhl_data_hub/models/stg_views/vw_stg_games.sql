-- models/views/vw_stg_games.sql



-- Log the start of the process 
{{ log("Starting the creation of the internal table from the external table...", info=True) }}
{{ config(materialized='view') }}

--CAST(CONCAT(CONCAT(REPLACE(SPLIT(CAST(date_time_gmt AS STRING), ' ')[OFFSET(0)], '-',''), LEFT(SPLIT(CAST(date_time_gmt AS STRING), ' ')[OFFSET(1)], 2)), '000') AS INT64) AS game_date_gmt_id,
--LEFT(REPLACE(LEFT(SPLIT(CAST(date_time_gmt AS STRING), ' ')[OFFSET(1)], 8), ':',''), 2) as HH,
--RIGHT(LEFT(REPLACE(LEFT(SPLIT(CAST(date_time_gmt AS STRING), ' ')[OFFSET(1)], 8), ':',''), 4),2) as MM,

with vw_stg_games AS (
    SELECT DISTINCT
    game_id,  
    season,
    CAST(CONCAT(REPLACE(SPLIT(CAST(date_time_gmt AS STRING), ' ')[OFFSET(0)], '-',''), '000') AS INT64) as game_date_gmt_id,
    REPLACE(LEFT(SPLIT(CAST(date_time_gmt AS STRING), ' ')[OFFSET(1)], 8), ':','') as hh_mm_ss,
    type,
    home_team_id,
    away_team_id,
    home_goals,
    away_goals,
    UPPER(outcome) as outcome,
    UPPER(home_rink_side_start) as home_rink_side_start,
    UPPER(venue) as venue,
    UPPER(venue_time_zone_id) as venue_time_zone_id,
    UPPER(venue_time_zone_tz) as venue_time_zone_tz,
    venue_time_zone_offset,
    CURRENT_TIMESTAMP() as DW_LOAD_TIMESTAMP
    FROM 
        `{{ target.dataset }}.stg_games`
)

SELECT *
FROM vw_stg_games

-- Log the completion of the process 
{{ log("Completed the creation of the internal table from the external table.", info=True) }}