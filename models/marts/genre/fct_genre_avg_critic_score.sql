{{ config(materialized='table') }}

select
  genre,
  round(avg(critic_score), 1) as avg_critic_score
from {{ source('RAW_VIDEO_GAME_SALES_DATA', 'DATA') }}
where critic_score is not null
group by genre
