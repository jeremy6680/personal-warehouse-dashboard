---
title: World Map
---

```sql domains
select distinct domain
from personal_warehouse.mrt_media__country_index
order by domain
```

```sql by_country
select
    country,
    count(*) as items,
    count(distinct domain) as domains_represented,
    round(avg(rating), 2) as avg_rating
from personal_warehouse.mrt_media__country_index
where country = '${inputs.domain_filter.value}' or '${inputs.domain_filter.value}' = '%'
group by country
order by items desc
limit 30
```

```sql by_country_domain
select
    country,
    domain,
    count(*) as items
from personal_warehouse.mrt_media__country_index
where domain = '${inputs.domain_filter.value}' or '${inputs.domain_filter.value}' = '%'
group by country, domain
order by items desc
limit 60
```

```sql items_table
select
    country,
    domain,
    item_title,
    person_name,
    person_role,
    rating
from personal_warehouse.mrt_media__country_index
where
    (domain = '${inputs.domain_filter.value}' or '${inputs.domain_filter.value}' = '%')
    and (country = '${inputs.country_filter.value}' or '${inputs.country_filter.value}' = '%')
order by country, domain, item_title
```

```sql country_list
select distinct country
from personal_warehouse.mrt_media__country_index
order by country
```

# World Map

Where does my media come from?

<Dropdown data={domains} name=domain_filter value=domain title="Domain">
    <DropdownOption value="%" valueLabel="All domains" />
</Dropdown>

<Dropdown data={country_list} name=country_filter value=country title="Country">
    <DropdownOption value="%" valueLabel="All countries" />
</Dropdown>

---

## Items by country

<BarChart
    data={by_country}
    x=country
    y=items
    title="Top 30 countries"
    swapXY=true
    sort=false
/>

## Breakdown by country and domain

<BarChart
    data={by_country_domain}
    x=country
    y=items
    series=domain
    title="Items per country, by domain"
    swapXY=true
    sort=false
/>

---

## All items

<DataTable data={items_table} rows=25 search=true>
    <Column id=country />
    <Column id=domain />
    <Column id=item_title title="Title" />
    <Column id=person_name title="Author / Director / Artist" />
    <Column id=rating />
</DataTable>
