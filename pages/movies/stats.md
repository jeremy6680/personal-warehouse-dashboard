---
title: Movies — Stats
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

# Movies — Stats

## By genre

<BarChart data={by_genre} x=genre y=titles title="Titles by genre" swapXY=true />

## By country

<BarChart data={by_country} x=country y=titles title="Titles by country" swapXY=true />

## By decade

<BarChart data={by_decade} x=decade y=titles title="Titles by decade" sort=false />

## By content type

<BarChart data={by_content_type} x=content_type y=titles title="Movies vs TV" />

## Rating distribution

<BarChart data={rating_dist} x=rating y=titles title="Rating distribution" />

## Films watched per year

<BarChart data={by_year_watched} x=year_watched y=titles title="Films watched per year" sort=false />

## Top directors (by title count)

<DataTable data={top_directors} rows=15>
    <Column id=director />
    <Column id=titles />
    <Column id=watched />
    <Column id=avg_rating title="Avg rating" />
</DataTable>
