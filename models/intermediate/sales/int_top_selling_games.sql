{{ config(materialized='table') }}

with game_sales as (
    select
        title,
        console,
        publisher,
        sum(total_sales) as total_sales,
        avg(critic_score) as avg_critic_score,
        max(release_date) as latest_release_date
    from {{ ref('stg_video_game_sales') }}
    group by title, console, publisher
)

select
    title,
    console,
    publisher,
    total_sales,
    avg_critic_score,
    latest_release_date,
    rank() over (order by total_sales desc) as sales_rank
from game_sales
