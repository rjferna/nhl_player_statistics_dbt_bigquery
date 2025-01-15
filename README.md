# Intro
This goal of this repository is to analyze  NHL Player Statistics using DBT to transform and build data models. And, BigQuery as a serverless data warehouse for analysis.


## Prerequisites

1. GCP Account (Free trial is offered)
    * Create a BigQuery Project for For NHL Statistics.
    * Create bucket for project and apply the appropriate permissions
    * Create a Service Account for Project
    * Generate a keyfile for Project

2. Installation of DBT

3. NHL Statistics Data
    * Kaggle: <a href="https://www.kaggle.com/datasets/martinellis/nhl-game-data" target="_black">NHL Game Data</a>



# DBT

## **Macros**
Currently, this directory contains macros to create external tables in BigQuery.


| File                                          | Description                                                                                             |
|-----------------------------------------------|---------------------------------------------------------------------------------------------------------|
| create_external_table_automated.sql           | Macro to be used with script/bin/gcp_external_table_automated.py for automated external table creation. |
| create_external_table_game_goalie.sql         | Manually executed macro to build Game Goalie  external table.                                           |
| create_external_table_game_goals.sql          | Manually executed macro to build Game Goals  external table.                                            |
| create_external_table_game_officials.sql      | Manually executed macro to build Game Officials  external table.                                        |
| create_external_table_game_penalties.sql      | Manually executed macro to build Game Penalties  external table.                                        |
| create_external_table_game_plays_players.sql  | Manually executed macro to build Game Plays Players  external table.                                    |
| create_external_table_game_plays.sql          | Manually executed macro to build Game Plays  external table.                                            |
| create_external_table_game_shifts.sql         | Manually executed macro to build Game Shifts  external table.                                           |
| create_external_table_game_skater_stats.sql   | Manually executed macro to build Game Skater Stats  external table.                                     |
| create_external_table_game_teams_stats.sql    | Manually executed macro to build Game Team Stats  external table.                                       |
| create_external_table_game.sql                | Manually executed macro to build Game external table.                                                   |
| create_external_table_player_info.sql         | Manually executed macro to build Player Info  external table.                                           |
| create_external_table_team_info.sql           | Manually executed macro to build Team Info  external table.                                             |


**Macro Execution (Manual)**
```
dbt run-operation create_external_table_game_goalie
```


**Macro Execution (Automated)**
```
python3 gcp_external_table_automated.py
```

## **Models**
In this directory you will find the four sub-directories reference, staging, stg_views and ref_views. The **staging** directory holds scripts where we read in data from **external** 
tables and cast every attribute a datatype format and, create a staging base table. The **stg_views** directory holds scripts where we apply further transformations
(if needed) to build the final **reference** base table which we will use primarily for analysis. Lastly, the **ref_views** directory will primarily be used for building datasets 
on top of **reference** tables.

To build the Staging and Reference tables you need to execute the scripts in sequence **External > Staging > Staging Views > Reference > Reverence Views**.

**Order for Player Info**
1. Staging:   
``` 
dbt run --select stg_player_info.sql 
```

2. Stg_Views: 
``` 
dbt run --select vw_stg_player_info.sql 
```

3. Reference: 
``` 
dbt run --select ref_player_info.sql 
```

**Order for Player Info**
1. Staging:   
``` 
dbt run --select stg_game_skater_stats.sql 
```

2. Stg_Views: 
``` 
dbt run --select vw_stg_game_skater_stats.sql 
```

3. Reference: 
``` 
dbt run --select ref_game_skater_stats.sql 
```

**Player Info & Game Skater Stats Required to build Skater Details**
4. Reference: 
``` 
dbt run --select ref_skater_details.sql 
```




