---
title: Music — Stats
---

```sql by_genre
select
    trim(genre) as genre,
    count(*) as albums,
    round(avg(rating), 2) as avg_rating
from personal_warehouse.mrt_music__collection,
    unnest(split(genres, ',')) as genre
where genres is not null and trim(genre) != ''
group by trim(genre)
order by albums desc
limit 20
```

```sql by_country
select
    country,
    count(*) as albums,
    round(avg(rating), 2) as avg_rating
from personal_warehouse.mrt_music__collection
where country is not null
group by country
order by albums desc
limit 20
```

```sql by_decade
select
    floor(release_year / 10) * 10 as decade,
    count(*) as albums,
    round(avg(rating), 2) as avg_rating
from personal_warehouse.mrt_music__collection
where release_year is not null
group by floor(release_year / 10) * 10
order by decade
```

```sql rating_dist
select
    rating,
    count(*) as albums
from personal_warehouse.mrt_music__collection
where rating is not null
group by rating
order by rating desc
```

```sql by_source
select
    source_name,
    count(*) as albums
from personal_warehouse.mrt_music__collection
group by source_name
order by albums desc
```

```sql top_artists
select
    artist,
    count(*) as albums,
    round(avg(rating), 2) as avg_rating
from personal_warehouse.mrt_music__collection
group by artist
order by albums desc, avg_rating desc
limit 15
```

# Music — Stats

## By genre

<BarChart data={by_genre} x=genre y=albums title="Albums by genre" swapXY=true />

## By country

<BarChart data={by_country} x=country y=albums title="Albums by country" swapXY=true />

## By decade

<BarChart data={by_decade} x=decade y=albums title="Albums by decade" />

## Rating distribution

<BarChart data={rating_dist} x=rating y=albums title="Rating distribution" />

## By source

<BarChart data={by_source} x=source_name y=albums title="MusicBuddy vs Spotify" />

## Top artists (by album count)

<DataTable data={top_artists} rows=15>
    <Column id=artist />
    <Column id=albums />
    <Column id=avg_rating title="Avg rating" />
</DataTable>
