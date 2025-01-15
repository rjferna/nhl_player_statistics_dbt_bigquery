-- models/reference/ref_player_info.sql

-- Log the start of the process 
{{ log("Starting the creation of the internal table from the view table...", info=True) }}
{{ config(materialized='table') }}

SELECT DISTINCT
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
CURRENT_TIMESTAMP() as DW_LOAD_TIMESTAMP
FROM 
  `{{ target.dataset }}.vw_stg_player_info` AS pi
WHERE 
  pi.nationality IS NOT NULL
AND
  pi.shootsCatches IS NOT NULL  

-- Log the completion of the process 
{{ log("Completed the creation of the internal table from the external table.", info=True) }}