---
title: Animé — Statistiques
---

```sql by_genre
select genre, count(*) as anime, round(avg(rating), 2) as avg_rating
from (
    select trim(unnest(string_split(genres, ','))) as genre, rating
    from personal_warehouse.mrt_anime__collection
    where genres is not null and genres != ''

    union all

    select 'Non renseigné' as genre, rating
    from personal_warehouse.mrt_anime__collection
    where genres is null or genres = ''
)
where genre != ''
group by genre
order by anime desc
limit 20
```

```sql by_country
select
    coalesce(country, 'Non renseigné') as country,
    count(*) as anime,
    round(avg(rating), 2) as avg_rating
from personal_warehouse.mrt_anime__collection
group by coalesce(country, 'Non renseigné')
order by anime desc
limit 20
```

```sql by_decade
select
    cast(cast(floor(release_year / 10) * 10 as bigint) as varchar) as decade,
    count(*) as anime,
    round(avg(rating), 2) as avg_rating
from personal_warehouse.mrt_anime__collection
where release_year is not null
group by floor(release_year / 10) * 10
order by floor(release_year / 10) * 10
```

```sql rating_dist
select
    rating,
    count(*) as anime
from personal_warehouse.mrt_anime__collection
where rating is not null
group by rating
order by rating desc
```

```sql top_directors
select
    director,
    count(*) as anime,
    countif(is_watched) as watched,
    round(avg(rating), 2) as avg_rating
from (
    select trim(unnest(string_split(directors, ','))) as director, is_watched, rating
    from personal_warehouse.mrt_anime__collection
    where directors is not null
)
where director != ''
group by director
order by anime desc, avg_rating desc
limit 15
```


## Par genre

<BarChart data={by_genre} x=genre y=anime title="Animés par genre" swapXY=true />

## Par pays

<BarChart data={by_country} x=country y=anime title="Animés par pays" swapXY=true />

## Par décennie

<BarChart data={by_decade} x=decade y=anime title="Animés par décennie" sort=false />

## Distribution des notes

<BarChart data={rating_dist} x=rating y=anime title="Distribution des notes" />

## Top réalisateurs

<DataTable data={top_directors} rows=15>
    <Column id=director title="Réalisateur" />
    <Column id=anime title="Animés" />
    <Column id=watched title="Vus" />
    <Column id=avg_rating title="Note moyenne" />
</DataTable>
