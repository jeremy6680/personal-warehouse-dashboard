---
title: Films — Statistiques
---

```sql by_genre
select genre, count(*) as titles, round(avg(rating), 2) as avg_rating
from (
    select trim(unnest(string_split(genres, ','))) as genre, rating
    from personal_warehouse.mrt_movies__collection
    where genres is not null
)
where genre != ''
group by genre
order by titles desc
limit 20
```

```sql by_country
select
    country,
    count(*) as titles,
    round(avg(rating), 2) as avg_rating
from personal_warehouse.mrt_movies__collection
where country is not null
group by country
order by titles desc
limit 20
```

```sql by_decade
select
    cast(cast(floor(release_year / 10) * 10 as bigint) as varchar) as decade,
    count(*) as titles,
    round(avg(rating), 2) as avg_rating
from personal_warehouse.mrt_movies__collection
where release_year is not null
group by floor(release_year / 10) * 10
order by floor(release_year / 10) * 10
```

```sql by_content_type
select
    content_type,
    count(*) as titles,
    countif(is_watched) as watched
from personal_warehouse.mrt_movies__collection
group by content_type
order by titles desc
```

```sql rating_dist
select
    rating,
    count(*) as titles
from personal_warehouse.mrt_movies__collection
where rating is not null
group by rating
order by rating desc
```

```sql by_year_watched
select
    cast(year(first_watched_date) as varchar) as year_watched,
    count(*) as titles
from personal_warehouse.mrt_movies__collection
where first_watched_date is not null
group by year(first_watched_date)
order by year(first_watched_date)
```

```sql top_directors
select
    director,
    count(*) as titles,
    countif(is_watched) as watched,
    round(avg(rating), 2) as avg_rating
from (
    select trim(unnest(string_split(directors, ','))) as director, is_watched, rating
    from personal_warehouse.mrt_movies__collection
    where directors is not null
)
where director != ''
group by director
order by titles desc, avg_rating desc
limit 15
```

# Films — Statistiques

## Par genre

<BarChart data={by_genre} x=genre y=titles title="Titres par genre" swapXY=true />

## Par pays

<BarChart data={by_country} x=country y=titles title="Titres par pays" swapXY=true />

## Par décennie

<BarChart data={by_decade} x=decade y=titles title="Titres par décennie" sort=false />

## Par type de contenu

<BarChart data={by_content_type} x=content_type y=titles title="Films vs Séries" />

## Distribution des notes

<BarChart data={rating_dist} x=rating y=titles title="Distribution des notes" />

## Films vus par année

<BarChart data={by_year_watched} x=year_watched y=titles title="Films vus par année" sort=false />

## Top réalisateurs (par nombre de titres)

<DataTable data={top_directors} rows=15>
    <Column id=director title="Réalisateur" />
    <Column id=titles title="Titres" />
    <Column id=watched title="Vus" />
    <Column id=avg_rating title="Note moyenne" />
</DataTable>
