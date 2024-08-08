{{ config(materialized='table') }}

select
  g.genre,
  round(avg(cs.critic_score),1) as avg_critic_score
from {{ ref('stg_genre') }} as g
left join {{ ref('stg_critic_score') }} as cs on g.genre = cs.genre
group by g.genre
order by avg_critic_score desc
