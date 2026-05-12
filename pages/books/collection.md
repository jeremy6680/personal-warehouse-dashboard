---
title: Livres — Collection
---

```sql genres
select distinct genre
from personal_warehouse.mrt_books__collection
where genre is not null and genre != ''
order by genre
```

```sql countries
select distinct country
from personal_warehouse.mrt_books__collection
where country is not null
order by country
```

```sql books
select
    title,
    author,
    genre,
    category,
    rating,
    cast(cast(year_published as bigint) as varchar) as year_published,
    country,
    source
from personal_warehouse.mrt_books__collection
where
    (genre = '${inputs.genre.value}' or '${inputs.genre.value}' = '%')
    and (country = '${inputs.country.value}' or '${inputs.country.value}' = '%')
order by
    case when rating is null then 1 else 0 end,
    rating desc,
    author,
    title
```

```sql stats
select
    count(*) as total,
    count(*) as read,
    countif(is_rated) as rated,
    round(avg(rating), 2) as avg_rating,
    count(distinct author) as authors,
    count(distinct country) as countries
from personal_warehouse.mrt_books__collection
where
    (genre = '${inputs.genre.value}' or '${inputs.genre.value}' = '%')
    and (country = '${inputs.country.value}' or '${inputs.country.value}' = '%')
```


<Dropdown data={genres} name=genre value=genre title="Genre">
    <DropdownOption value="%" valueLabel="Tous les genres" />
</Dropdown>

<Dropdown data={countries} name=country value=country title="Pays">
    <DropdownOption value="%" valueLabel="Tous les pays" />
</Dropdown>

---

<BigValue data={stats} value=total title="Livres" />
<BigValue data={stats} value=read title="Lus" />
<BigValue data={stats} value=rated title="Notés" />
<BigValue data={stats} value=avg_rating title="Note moyenne" />
<BigValue data={stats} value=authors title="Auteurs" />
<BigValue data={stats} value=countries title="Pays" />

---

<DataTable data={books} rows=25 search=true>
    <Column id=title title="Titre" />
    <Column id=author title="Auteur" />
    <Column id=genre title="Genre" />
    <Column id=rating title="Note" />
    <Column id=year_published title="Année" />
    <Column id=country title="Pays" />
    <Column id=source title="Source" />
</DataTable>
