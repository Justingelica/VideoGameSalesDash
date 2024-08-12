{{ config(materialized='table') }}

with sales_by_release_date as (
  select
    rd.release_date,
    sum(s.total_sales) as total_sales
  from {{ ref('stg_release_date') }} as rd
  left join {{ ref('stg_video_game_sales') }} as s on rd.release_date = s.release_date
  group by rd.release_date
)

select * from sales_by_release_date
