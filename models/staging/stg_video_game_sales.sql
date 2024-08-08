{{ config(materialized='table') }}

with raw_sales as (
    select
        img,
        title,
        console,
        genre,
        publisher,
        developer,
        critic_score,
        total_sales,
        na_sales,
        jp_sales,
        pal_sales,
        other_sales,
        release_date,
        last_update
    from {{ source('RAW_VIDEO_GAME_SALES_DATA', 'DATA') }}
)

select
    title,
    console as platform,
    genre,
    publisher,
    developer,
    critic_score,
    total_sales,
    na_sales,
    jp_sales,
    pal_sales,
    other_sales,
    release_date,
    last_update
from raw_sales
where total_sales is not null