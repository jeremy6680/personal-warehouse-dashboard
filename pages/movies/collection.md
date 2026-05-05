---
title: Films — Collection
---

```sql content_types
select distinct content_type
from personal_warehouse.mrt_movies__collection
where content_type is not null
order by content_type
```

```sql genres
select distinct genre
from (
    select trim(unnest(string_split(genres, ','))) as genre
    from personal_warehouse.mrt_movies__collection
    where genres is not null
)
where genre != ''
order by genre
```

```sql countries
select distinct country
from personal_warehouse.mrt_movies__collection
where country is not null
order by country
```

```sql movies
select
    title,
    content_type,
    cast(cast(release_year as bigint) as varchar) as release_year,
    directors,
    genres,
    rating,
    runtime_minutes,
    country,
    source,
    first_watched_date,
    is_watched
from personal_warehouse.mrt_movies__collection
where
    (content_type = '${inputs.content_type.value}' or '${inputs.content_type.value}' = '%')
    and (genres like '%' || '${inputs.genre.value}' || '%' or '${inputs.genre.value}' = '%')
    and (country = '${inputs.country.value}' or '${inputs.country.value}' = '%')
    and (is_watched = true or '${inputs.watched_filter.value}' = 'all')
order by
    case when rating is null then 1 else 0 end,
    rating desc,
    title
```

```sql stats
select
    count(*) as total,
    countif(is_watched) as watched,
    countif(not is_watched) as wishlist,
    round(avg(rating), 2) as avg_rating,
    count(distinct country) as countries
from personal_warehouse.mrt_movies__collection
where
    (content_type = '${inputs.content_type.value}' or '${inputs.content_type.value}' = '%')
    and (genres like '%' || '${inputs.genre.value}' || '%' or '${inputs.genre.value}' = '%')
    and (country = '${inputs.country.value}' or '${inputs.country.value}' = '%')
    and (is_watched = true or '${inputs.watched_filter.value}' = 'all')
```


<Dropdown data={content_types} name=content_type value=content_type title="Type">
    <DropdownOption value="%" valueLabel="Tous les types" />
</Dropdown>

<Dropdown data={genres} name=genre value=genre title="Genre">
    <DropdownOption value="%" valueLabel="Tous les genres" />
</Dropdown>

<Dropdown data={countries} name=country value=country title="Pays">
    <DropdownOption value="%" valueLabel="Tous les pays" />
</Dropdown>

<Dropdown name=watched_filter title="Visionnage">
    <DropdownOption value="all" valueLabel="Tous" />
    <DropdownOption value="watched" valueLabel="Vus uniquement" />
</Dropdown>

---

<BigValue data={stats} value=total title="Titres" />
<BigValue data={stats} value=watched title="Vus" />
<BigValue data={stats} value=wishlist title="Wishlist" />
<BigValue data={stats} value=avg_rating title="Note moyenne" />
<BigValue data={stats} value=countries title="Pays" />

---

<DataTable data={movies} rows=25 search=true>
    <Column id=title title="Titre" />
    <Column id=content_type title="Type" />
    <Column id=directors title="Réalisateurs" />
    <Column id=genres title="Genres" />
    <Column id=release_year title="Année" />
    <Column id=rating title="Note" />
    <Column id=runtime_minutes title="Durée (min)" />
    <Column id=country title="Pays" />
    <Column id=first_watched_date title="Vu le" />
</DataTable>
