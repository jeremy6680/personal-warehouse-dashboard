---
title: Résumé
---

```sql totals
select
    sum(total_items) as total_items,
    sum(items_rated) as total_rated,
    count(distinct domain) as domains,
    round(avg(avg_rating), 2) as avg_rating
from personal_warehouse.mrt_media__summary
```

```sql by_domain
select domain, total_items, items_consumed, items_pending, items_rated, avg_rating
from personal_warehouse.mrt_media__summary
order by total_items desc
```

```sql books
select total_items, items_consumed, items_pending, items_rated, avg_rating
from personal_warehouse.mrt_media__summary
where domain = 'books'
```

```sql movies
select total_items, items_consumed, items_pending, items_rated, avg_rating
from personal_warehouse.mrt_media__summary
where domain = 'movies'
```

```sql music
select total_items, items_rated, avg_rating
from personal_warehouse.mrt_media__summary
where domain = 'music'
```


<BigValue data={totals} value=total_items title="Œuvres au total" />
<BigValue data={totals} value=total_rated title="Notées" />
<BigValue data={totals} value=avg_rating title="Note moyenne (tous domaines)" />

---

## Livres

<BigValue data={books} value=total_items title="Total" />
<BigValue data={books} value=items_consumed title="Lus" />
<BigValue data={books} value=items_pending title="À lire" />
<BigValue data={books} value=avg_rating title="Note moyenne" />

## Films

<BigValue data={movies} value=total_items title="Total" />
<BigValue data={movies} value=items_consumed title="Vus" />
<BigValue data={movies} value=items_pending title="Wishlist" />
<BigValue data={movies} value=avg_rating title="Note moyenne" />

## Musique

<BigValue data={music} value=total_items title="Albums" />
<BigValue data={music} value=items_rated title="Notés" />
<BigValue data={music} value=avg_rating title="Note moyenne" />

---

## Taille de la collection par domaine

<BarChart
    data={by_domain}
    x=domain
    y=total_items
    title="Nombre d'œuvres par domaine"
/>

## Note moyenne par domaine

<BarChart
    data={by_domain}
    x=domain
    y=avg_rating
    title="Note moyenne par domaine"
    yMin=0
    yMax=5
/>
