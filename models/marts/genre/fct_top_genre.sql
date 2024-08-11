{{ config(materialized='table') }}

with top_genres as (
  select * from {{ ref('int_sales_by_genre') }}
  order by total_sales desc
)

select * from top_genres
