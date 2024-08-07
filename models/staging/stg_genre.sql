{{ config(materialized='table') }}

with source_data as (
  select distinct genre from raw_vgchartz.data
)

select * from source_data
