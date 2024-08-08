{{ config(materialized='table') }}

with source_data as (
  select
    release_date
  from {{ source('RAW_VIDEO_GAME_SALES_DATA', 'DATA') }}
  where release_date is not null
  order by release_date desc
)

select * from source_data
