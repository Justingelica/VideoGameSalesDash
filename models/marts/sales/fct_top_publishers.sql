{{ config(materialized='table') }}

with top_publishers as (
    select
        publisher,
        top_selling_games_count,
        total_sales,
        avg_critic_score
    from {{ ref('int_top_publishers') }}
    where top_selling_games_count > 0
)

select
    publisher,
    top_selling_games_count as number_of_top_selling_games,
    total_sales,
    avg_critic_score
from top_publishers
order by top_selling_games_count desc, total_sales desc
