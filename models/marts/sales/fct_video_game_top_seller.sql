{{ config(materialized='table') }}

with top_games as (
  select
    title,
    sum(total_sales) as total_sales,
    row_number() over (order by sum(total_sales) desc) as rank
  from {{ ref('stg_video_game_sales') }}
  group by title
)

select * from top_games
where rank <= 10
