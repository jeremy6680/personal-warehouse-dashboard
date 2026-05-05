---
title: Musique — Collection
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


<Dropdown data={genres} name=genre value=genre title="Genre">
    <DropdownOption value="%" valueLabel="Tous les genres" />
</Dropdown>

<Dropdown data={countries} name=country value=country title="Pays">
    <DropdownOption value="%" valueLabel="Tous les pays" />
</Dropdown>

<Dropdown data={sources} name=source value=source_name title="Source">
    <DropdownOption value="%" valueLabel="Toutes les sources" />
</Dropdown>

<Dropdown name=rated title="Notation">
    <DropdownOption value="all" valueLabel="Tous les albums" />
    <DropdownOption value="rated" valueLabel="Notés uniquement" />
</Dropdown>

---

<BigValue data={stats} value=total title="Albums" />
<BigValue data={stats} value=avg_rating title="Note moyenne" />
<BigValue data={stats} value=artists title="Artistes" />
<BigValue data={stats} value=rated title="Notés" />

---

<DataTable data={albums} rows=25 search=true>
    <Column id=title title="Titre" />
    <Column id=artist title="Artiste" />
    <Column id=genres title="Genres" />
    <Column id=release_year title="Année" />
    <Column id=rating title="Note" />
    <Column id=country title="Pays" />
    <Column id=source_name title="Source" />
</DataTable>
