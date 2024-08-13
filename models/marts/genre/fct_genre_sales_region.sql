{{ config(materialized='table') }}

with genre_sales as (
  select
    g.genre,
    sum(s.na_sales) as na_sales,
    sum(s.jp_sales) as jp_sales,
    sum(s.pal_sales) as pal_sales,
    sum(s.other_sales) as other_sales
  from {{ ref('stg_video_game_sales') }} as s
  join {{ ref('stg_genre') }} as g
    on s.genre = g.genre
  group by g.genre
),

sales_by_genre_region as (
  select
    genre,
    'NA' as region,
    ROUND(na_sales, 1) as total_sales
  from genre_sales
  where na_sales is not null
  union all
  select
    genre,
    'JP' as region,
    ROUND(jp_sales, 1) as total_sales
  from genre_sales
  where jp_sales is not null
  union all
  select
    genre,
    'PAL' as region,
    ROUND(pal_sales, 1) as total_sales
  from genre_sales
  where pal_sales is not null
  union all
  select
    genre,
    'Other' as region,
    ROUND(other_sales, 1) as total_sales
  from genre_sales
  where other_sales is not null
),

top_genres_by_region as (
  select *,
    row_number() over (partition by region order by total_sales desc) as rank
  from sales_by_genre_region
)

select * from top_genres_by_region
where rank <= 3
