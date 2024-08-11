{{ config(materialized='table') }}

with source_data as (
  select distinct console
  from {{ source('RAW_VIDEO_GAME_SALES_DATA', 'DATA') }}
)

select * from source_data
