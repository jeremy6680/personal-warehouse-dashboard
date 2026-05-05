---
title: Livres — Collection
---

```sql statuses
select distinct status
from personal_warehouse.mrt_books__collection
where status is not null
order by status
```

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
    status,
    rating,
    cast(cast(year_published as bigint) as varchar) as year_published,
    country,
    source
from personal_warehouse.mrt_books__collection
where
    (status = '${inputs.status.value}' or '${inputs.status.value}' = '%')
    and (genre = '${inputs.genre.value}' or '${inputs.genre.value}' = '%')
    and (country = '${inputs.country.value}' or '${inputs.country.value}' = '%')
    and (is_read = true or '${inputs.read_filter.value}' = 'all')
order by
    case when rating is null then 1 else 0 end,
    rating desc,
    author,
    title
```

```sql stats
select
    count(*) as total,
    countif(is_read) as read,
    countif(not is_read) as unread,
    round(avg(rating), 2) as avg_rating,
    count(distinct author) as authors,
    count(distinct country) as countries
from personal_warehouse.mrt_books__collection
where
    (status = '${inputs.status.value}' or '${inputs.status.value}' = '%')
    and (genre = '${inputs.genre.value}' or '${inputs.genre.value}' = '%')
    and (country = '${inputs.country.value}' or '${inputs.country.value}' = '%')
    and (is_read = true or '${inputs.read_filter.value}' = 'all')
```


<Dropdown data={statuses} name=status value=status title="Statut">
    <DropdownOption value="%" valueLabel="Tous les statuts" />
</Dropdown>

<Dropdown data={genres} name=genre value=genre title="Genre">
    <DropdownOption value="%" valueLabel="Tous les genres" />
</Dropdown>

<Dropdown data={countries} name=country value=country title="Pays">
    <DropdownOption value="%" valueLabel="Tous les pays" />
</Dropdown>

<Dropdown name=read_filter title="Lecture">
    <DropdownOption value="all" valueLabel="Tous les livres" />
    <DropdownOption value="read" valueLabel="Lus uniquement" />
</Dropdown>

---

<BigValue data={stats} value=total title="Livres" />
<BigValue data={stats} value=read title="Lus" />
<BigValue data={stats} value=unread title="À lire" />
<BigValue data={stats} value=avg_rating title="Note moyenne" />
<BigValue data={stats} value=authors title="Auteurs" />
<BigValue data={stats} value=countries title="Pays" />

---

<DataTable data={books} rows=25 search=true>
    <Column id=title title="Titre" />
    <Column id=author title="Auteur" />
    <Column id=genre title="Genre" />
    <Column id=status title="Statut" />
    <Column id=rating title="Note" />
    <Column id=year_published title="Année" />
    <Column id=country title="Pays" />
    <Column id=source title="Source" />
</DataTable>
