---
title: Music — Collection
---

```sql genres
select distinct genre
from (
    select trim(unnest(string_split(genres, ','))) as genre
    from personal_warehouse.mrt_music__collection
    where genres is not null
)
where genre != '' and genre != '[]'
order by genre
```

```sql countries
select distinct country
from personal_warehouse.mrt_music__collection
where country is not null
order by country
```

```sql sources
select distinct source_name
from personal_warehouse.mrt_music__collection
order by source_name
```

```sql albums
select
    title,
    artist,
    genres,
    cast(cast(release_year as bigint) as varchar) as release_year,
    rating,
    country,
    source_name,
    total_tracks,
    spotify_album_id
from personal_warehouse.mrt_music__collection
where
    (genres like '%' || '${inputs.genre.value}' || '%' or '${inputs.genre.value}' = '%')
    and (country = '${inputs.country.value}' or '${inputs.country.value}' = '%')
    and (source_name = '${inputs.source.value}' or '${inputs.source.value}' = '%')
    and (is_rated = true or '${inputs.rated.value}' = 'all')
order by
    case when rating is null then 1 else 0 end,
    rating desc,
    artist,
    title
```

```sql stats
select
    count(*) as total,
    countif(is_rated) as rated,
    round(avg(rating), 2) as avg_rating,
    count(distinct artist) as artists,
    min(release_year) as oldest_year,
    max(release_year) as newest_year
from personal_warehouse.mrt_music__collection
where
    (genres like '%' || '${inputs.genre.value}' || '%' or '${inputs.genre.value}' = '%')
    and (country = '${inputs.country.value}' or '${inputs.country.value}' = '%')
    and (source_name = '${inputs.source.value}' or '${inputs.source.value}' = '%')
    and (is_rated = true or '${inputs.rated.value}' = 'all')
```

# Music — Collection

<Dropdown data={genres} name=genre value=genre title="Genre">
    <DropdownOption value="%" valueLabel="All genres" />
</Dropdown>

<Dropdown data={countries} name=country value=country title="Country">
    <DropdownOption value="%" valueLabel="All countries" />
</Dropdown>

<Dropdown data={sources} name=source value=source_name title="Source">
    <DropdownOption value="%" valueLabel="All sources" />
</Dropdown>

<Dropdown name=rated title="Rated only">
    <DropdownOption value="all" valueLabel="All albums" />
    <DropdownOption value="rated" valueLabel="Rated only" />
</Dropdown>

---

<BigValue data={stats} value=total title="Albums" />
<BigValue data={stats} value=avg_rating title="Avg Rating" />
<BigValue data={stats} value=artists title="Artists" />
<BigValue data={stats} value=rated title="Rated" />

---

<DataTable data={albums} rows=25 search=true>
    <Column id=title />
    <Column id=artist />
    <Column id=genres />
    <Column id=release_year title="Year" />
    <Column id=rating />
    <Column id=country />
    <Column id=source_name title="Source" />
</DataTable>
