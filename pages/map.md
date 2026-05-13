---
title: Carte du monde
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
    (domain = '${inputs.table_domain.value}' or '${inputs.table_domain.value}' in ('%', 'undefined'))
    and (country = '${inputs.country_filter.value}' or '${inputs.country_filter.value}' in ('%', 'undefined'))
order by country, domain, item_title
```


D'où vient ma médiathèque ?

<Dropdown data={domains} name=domain_filter value=domain title="Domaine">
    <DropdownOption value="%" valueLabel="Tous les domaines" />
</Dropdown>

---

<AreaMap
    data={choropleth}
    geoJsonUrl="https://raw.githubusercontent.com/nvkelso/natural-earth-vector/master/geojson/ne_110m_admin_0_countries.geojson"
    areaCol=iso_alpha3
    geoId="ADM0_A3"
    value=items
    title="Œuvres par pays"
    height=500
    legendType=scalar
    startingZoom=2
    startingLat=20
    startingLong=10
    opacity=0.8
    colorPalette={['#FADADD', '#C0392B']}
/>

---

## Top 30 pays

<BarChart
    data={by_country}
    x=country
    y=items
    title="Œuvres par pays"
    swapXY=true
    sort=false
/>

---

## Toutes les œuvres

<Dropdown data={country_list} name=country_filter value=country title="Pays">
    <DropdownOption value="%" valueLabel="Tous les pays" />
</Dropdown>

<Dropdown data={domains} name=table_domain value=domain title="Domaine">
    <DropdownOption value="%" valueLabel="Tous les domaines" />
</Dropdown>

<DataTable data={items_table} rows=25 search=true>
    <Column id=country title="Pays" />
    <Column id=domain title="Domaine" />
    <Column id=item_title title="Titre" width=200 wrap=true />
    <Column id=person_name title="Auteur / Réalisateur / Artiste" />
    <Column id=rating title="Note" />
</DataTable>
