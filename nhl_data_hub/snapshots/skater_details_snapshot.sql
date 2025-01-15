-- snapshots/skater_details_snapshots.sql

{% snapshot skater_details_snapshots %}
{{ config(
    target_schema='nhl_data_hub',
    unique_key='player_id',
    strategy='check',
    check_cols=['DoB']
    ) }}


SELECT DISTINCT
player_id,
firstName,
lastName,
DoB,
age,
nationality,
height_cm,
weight,
SUM(timeOnIce) as timeOnIce,
SUM(assists) as assists,
SUM(goals) as goals,
SUM(shots) as shots,
SUM(hits) as hits,
SUM(penaltyMinutes) as penaltyMinutes,
SUM(faceOffWins) as faceOffWins,
SUM(faceOffTaken) as faceOffTaken,
SUM(takeaways) as takeaways,
SUM(giveaways) as giveaways,
SUM(blocked) as blocked,
SUM(plusMinus) as plusMinus,
SUM(powerPlayGoals) as powerPlayGoals,
SUM(powerPlayAssists) as powerPlayAssists,
SUM(powerPlayTimeOnIce) as powerPlayTimeOnIce,
SUM(shortHandedGoals) as shortHandedGoals,
SUM(shortHandedAssists) as shortHandedAssists,
SUM(shortHandedTimeOnIce) as shortHandedTimeOnIce,
CURRENT_TIMESTAMP() as SNAPSHOT_TIMESTAMP
FROM `{{ target.dataset }}.ref_skater_details`
WHERE
  nationality = 'USA'
AND 
  age > 40
AND
  (game_date_gmt_id BETWEEN 20200101000 AND 20201231000)
GROUP BY 
player_id, firstName, lastName, fullName, DoB, age, nationality, height_cm, weight
ORDER BY lastname asc

{% endsnapshot %}