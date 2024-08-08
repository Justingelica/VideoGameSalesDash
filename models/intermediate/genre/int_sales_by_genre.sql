{{ config(materialized='table') }}

with sales_by_genre as (
  select
    g.genre,
    round(sum(s.total_sales), 1) as total_sales
  from {{ ref('stg_genre') }} as g
  left join {{ ref('stg_video_game_sales') }} as s on g.genre = s.genre
  group by g.genre
)

select * from sales_by_genre
