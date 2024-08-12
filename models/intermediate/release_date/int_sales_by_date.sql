{{ config(materialized='table') }}

with sales_by_release_date as (
  select
    s.release_date,
    sum(s.total_sales) as total_sales
  from {{ ref('stg_release_date') }} as rd
  inner join {{ ref('stg_video_game_sales') }} as s on rd.release_date = s.release_date
  group by s.release_date
  order by s.release_date desc
)

select * from sales_by_release_date
