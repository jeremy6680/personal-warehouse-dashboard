---
title: Manga — Collection
---

```sql genres
select distinct genre
from (
    select coalesce(nullif(genre, ''), 'Non renseigné') as genre
    from personal_warehouse.mrt_manga__collection
)
order by genre
```

```sql countries
select distinct country
from (
    select coalesce(country, 'Non renseigné') as country
    from personal_warehouse.mrt_manga__collection
)
order by country
```

```sql manga
select
    title,
    author,
    coalesce(nullif(genre, ''), 'Non renseigné') as genre,
    rating,
    coalesce(country, 'Non renseigné') as country,
    source
from personal_warehouse.mrt_manga__collection
where
    (coalesce(nullif(genre, ''), 'Non renseigné') = '${inputs.genre.value}' or '${inputs.genre.value}' = '%')
    and (coalesce(country, 'Non renseigné') = '${inputs.country.value}' or '${inputs.country.value}' = '%')
order by
    case when rating is null then 1 else 0 end,
    rating desc,
    author,
    title
```

```sql stats
select
    count(*) as total,
    countif(is_rated) as rated,
    round(avg(rating), 2) as avg_rating,
    count(distinct author) as authors,
    count(distinct country) as countries
from personal_warehouse.mrt_manga__collection
where
    (coalesce(nullif(genre, ''), 'Non renseigné') = '${inputs.genre.value}' or '${inputs.genre.value}' = '%')
    and (coalesce(country, 'Non renseigné') = '${inputs.country.value}' or '${inputs.country.value}' = '%')
```


<Dropdown data={genres} name=genre value=genre title="Genre">
    <DropdownOption value="%" valueLabel="Tous les genres" />
</Dropdown>

<Dropdown data={countries} name=country value=country title="Pays">
    <DropdownOption value="%" valueLabel="Tous les pays" />
</Dropdown>

---

<BigValue data={stats} value=total title="Manga" />
<BigValue data={stats} value=rated title="Notés" />
<BigValue data={stats} value=avg_rating title="Note moyenne" />
<BigValue data={stats} value=authors title="Auteurs" />
<BigValue data={stats} value=countries title="Pays" />

---

<DataTable data={manga} rows=25 search=true>
    <Column id=title title="Titre" />
    <Column id=author title="Auteur" />
    <Column id=genre title="Genre" />
    <Column id=rating title="Note" />
    <Column id=country title="Pays" />
    <Column id=source title="Source" />
</DataTable>
