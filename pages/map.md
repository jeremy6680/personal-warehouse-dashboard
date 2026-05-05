---
title: World Map
---

```sql domains
select distinct domain
from personal_warehouse.mrt_media__country_index
order by domain
```

```sql country_list
select distinct country
from personal_warehouse.mrt_media__country_index
order by country
```

```sql choropleth
select
    iso_alpha3,
    country,
    count(*) as items,
    round(avg(rating), 2) as avg_rating
from personal_warehouse.mrt_media__country_index
where
    iso_alpha3 is not null
    and (domain = '${inputs.domain_filter.value}' or '${inputs.domain_filter.value}' = '%')
group by iso_alpha3, country
order by items desc
```

```sql by_country
select
    country,
    count(*) as items,
    round(avg(rating), 2) as avg_rating
from personal_warehouse.mrt_media__country_index
where domain = '${inputs.domain_filter.value}' or '${inputs.domain_filter.value}' = '%'
group by country
order by items desc
limit 30
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

# World Map

Where does my media come from?

<Dropdown data={domains} name=domain_filter value=domain title="Domain">
    <DropdownOption value="%" valueLabel="All domains" />
</Dropdown>

---

<AreaMap
    data={choropleth}
    geoJsonUrl="https://raw.githubusercontent.com/datasets/geo-countries/master/data/countries.geojson"
    areaCol=iso_alpha3
    geoId="ISO3166-1-Alpha-3"
    value=items
    title="Items by country"
    height=500
    legendType=scalar
    startingZoom=2
    startingLat=20
    startingLong=10
/>

---

## Top 30 countries

<BarChart
    data={by_country}
    x=country
    y=items
    title="Items by country"
    swapXY=true
    sort=false
/>

---

## All items

<Dropdown data={country_list} name=country_filter value=country title="Filter by country">
    <DropdownOption value="%" valueLabel="All countries" />
</Dropdown>

<DataTable data={items_table} rows=25 search=true>
    <Column id=country />
    <Column id=domain />
    <Column id=item_title title="Title" />
    <Column id=person_name title="Author / Director / Artist" />
    <Column id=rating />
</DataTable>
