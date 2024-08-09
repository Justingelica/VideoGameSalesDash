{{ config(materialized='table') }}

with source_data as (
  select distinct publisher
  from {{ source('RAW_VIDEO_GAME_SALES_DATA', 'DATA') }}
  where publisher is not null and publisher <> 'Unknown'
)

select * from source_data
