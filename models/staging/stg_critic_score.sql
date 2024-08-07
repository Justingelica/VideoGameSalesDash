{{ config(materialized='table') }}

with source_data as (
  select
    genre,
    critic_score
  from {{ source('RAW_VIDEO_GAME_SALES_DATA', 'DATA') }}
  where critic_score is not null
)

select * from source_data
