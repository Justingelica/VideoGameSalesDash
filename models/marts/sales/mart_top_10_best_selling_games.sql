{{ config(materialized='table') }}

with top_10_games as (
    select
        title,
        console,
        publisher,
        total_sales,
        avg_critic_score,
        latest_release_date,
        sales_rank
    from {{ ref('int_top_selling_games') }}
    where sales_rank <= 10
)

select
    title,
    console as platform,
    publisher,
    total_sales,
    avg_critic_score,
    latest_release_date
from top_10_games
order by sales_rank
