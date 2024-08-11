{{ config(materialized='table') }}

with sales_by_genre_region as (
  select
    genre,
    'NA' as region,
    sum(na_sales) as total_sales
  from {{ ref('stg_video_game_sales') }}
  where na_sales is not null
  group by genre
  union all
  select
    genre,
    'JP' as region,
    sum(jp_sales) as total_sales
  from {{ ref('stg_video_game_sales') }}
  where jp_sales is not null
  group by genre
  union all
  select
    genre,
    'PAL' as region,
    sum(pal_sales) as total_sales
  from {{ ref('stg_video_game_sales') }}
  where pal_sales is not null
  group by genre
  union all
  select
    genre,
    'Other' as region,
    sum(other_sales) as total_sales
  from {{ ref('stg_video_game_sales') }}
  where other_sales is not null
  group by genre
),

top_genres_by_region as (
  select *,
    row_number() over (partition by region order by total_sales desc) as rank
  from sales_by_genre_region
)

select * from top_genres_by_region
where rank <= 3
