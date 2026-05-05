---
title: Books — Collection
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

# Books — Collection

<Dropdown data={statuses} name=status value=status title="Status">
    <DropdownOption value="%" valueLabel="All statuses" />
</Dropdown>

<Dropdown data={genres} name=genre value=genre title="Genre">
    <DropdownOption value="%" valueLabel="All genres" />
</Dropdown>

<Dropdown data={countries} name=country value=country title="Country">
    <DropdownOption value="%" valueLabel="All countries" />
</Dropdown>

<Dropdown name=read_filter title="Read status">
    <DropdownOption value="all" valueLabel="All books" />
    <DropdownOption value="read" valueLabel="Read only" />
</Dropdown>

---

<BigValue data={stats} value=total title="Books" />
<BigValue data={stats} value=read title="Read" />
<BigValue data={stats} value=unread title="To read" />
<BigValue data={stats} value=avg_rating title="Avg Rating" />
<BigValue data={stats} value=authors title="Authors" />
<BigValue data={stats} value=countries title="Countries" />

---

<DataTable data={books} rows=25 search=true>
    <Column id=title />
    <Column id=author />
    <Column id=genre />
    <Column id=status />
    <Column id=rating />
    <Column id=year_published title="Year" />
    <Column id=country />
    <Column id=source />
</DataTable>
