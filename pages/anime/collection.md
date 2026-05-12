---
title: Animé — Collection
---

```sql genres
select distinct genre
from (
    select trim(unnest(string_split(genres, ','))) as genre
    from personal_warehouse.mrt_anime__collection
    where genres is not null and genres != ''

    union all

    select 'Non renseigné' as genre
    from personal_warehouse.mrt_anime__collection
    where genres is null or genres = ''
)
where genre != ''
order by genre
```

```sql countries
select distinct country
from (
    select coalesce(country, 'Non renseigné') as country
    from personal_warehouse.mrt_anime__collection
)
order by country
```

```sql anime
select
    title,
    cast(cast(release_year as bigint) as varchar) as release_year,
    directors,
    coalesce(nullif(genres, ''), 'Non renseigné') as genres,
    rating,
    runtime_minutes,
    coalesce(country, 'Non renseigné') as country,
    source,
    first_watched_date,
    is_watched
from personal_warehouse.mrt_anime__collection
where
    (coalesce(nullif(genres, ''), 'Non renseigné') like '%' || '${inputs.genre.value}' || '%' or '${inputs.genre.value}' = '%')
    and (coalesce(country, 'Non renseigné') = '${inputs.country.value}' or '${inputs.country.value}' = '%')
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
    countif(not is_watched) as planned,
    countif(is_rated) as rated,
    round(avg(rating), 2) as avg_rating,
    count(distinct country) as countries
from personal_warehouse.mrt_anime__collection
where
    (coalesce(nullif(genres, ''), 'Non renseigné') like '%' || '${inputs.genre.value}' || '%' or '${inputs.genre.value}' = '%')
    and (coalesce(country, 'Non renseigné') = '${inputs.country.value}' or '${inputs.country.value}' = '%')
    and (is_watched = true or '${inputs.watched_filter.value}' = 'all')
```


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

<BigValue data={stats} value=total title="Animés" />
<BigValue data={stats} value=watched title="Vus" />
<BigValue data={stats} value=planned title="À voir" />
<BigValue data={stats} value=rated title="Notés" />
<BigValue data={stats} value=avg_rating title="Note moyenne" />
<BigValue data={stats} value=countries title="Pays" />

---

<DataTable data={anime} rows=25 search=true>
    <Column id=title title="Titre" />
    <Column id=directors title="Réalisateurs" />
    <Column id=genres title="Genres" />
    <Column id=release_year title="Année" />
    <Column id=rating title="Note" />
    <Column id=runtime_minutes title="Durée (min)" />
    <Column id=country title="Pays" />
    <Column id=first_watched_date title="Vu le" />
    <Column id=source title="Source" />
</DataTable>
