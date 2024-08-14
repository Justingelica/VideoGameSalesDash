{{ config(materialized='table') }}

with sales_by_quarter as (
  select
    extract(year from release_date) as year,
    date_trunc('quarter', release_date) as quarter,
    round(sum(total_sales),1) as total_sales
  from {{ ref('int_sales_by_date') }}
  where extract(year from release_date) between 2010 and 2018
  group by year, quarter
)

select
  year,
  quarter,
  total_sales
from sales_by_quarter
order by year, quarter
