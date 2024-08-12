{{ config(materialized='table') }}

with publisher_sales as (
    select
        publisher,
        count(distinct title) as top_selling_games_count,
        sum(total_sales) as total_sales,
        avg(critic_score) as avg_critic_score
    from {{ ref('stg_video_game_sales') }}
    where total_sales is not null
    group by publisher
)

select
    publisher,
    top_selling_games_count,
    total_sales,
    avg_critic_score
from publisher_sales
order by top_selling_games_count desc
