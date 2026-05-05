---
title: Musique — Statistiques
---

```sql by_genre
select genre, count(*) as albums, round(avg(rating), 2) as avg_rating
from (
    select trim(unnest(string_split(genres, ','))) as genre, rating
    from personal_warehouse.mrt_music__collection
    where genres is not null
)
where genre != '' and genre != '[]'
group by genre
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
    cast(cast(floor(release_year / 10) * 10 as bigint) as varchar) as decade,
    count(*) as albums,
    round(avg(rating), 2) as avg_rating
from personal_warehouse.mrt_music__collection
where release_year is not null
group by floor(release_year / 10) * 10
order by floor(release_year / 10) * 10
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
where artist != 'Various'
group by artist
order by albums desc, avg_rating desc
limit 15
```


## Par genre

<BarChart data={by_genre} x=genre y=albums title="Albums par genre" swapXY=true />

## Par pays

<BarChart data={by_country} x=country y=albums title="Albums par pays" swapXY=true />

## Par décennie

<BarChart data={by_decade} x=decade y=albums title="Albums par décennie" sort=false />

## Distribution des notes

<BarChart data={rating_dist} x=rating y=albums title="Distribution des notes" />

## Par source

<BarChart data={by_source} x=source_name y=albums title="MusicBuddy vs Spotify" />

## Top artistes (par nombre d'albums)

<DataTable data={top_artists} rows=15>
    <Column id=artist title="Artiste" />
    <Column id=albums title="Albums" />
    <Column id=avg_rating title="Note moyenne" />
</DataTable>
