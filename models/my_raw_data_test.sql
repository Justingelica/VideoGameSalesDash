{{ config(materialized='table') }}

select
  title,
  console,
  total_sales,
  na_sales,
  pal_sales,
  developer,
  publisher
from FIVETRAN_DATABASE.RAW_VGCHARTZ.DATA
