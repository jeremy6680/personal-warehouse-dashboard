---
title: Summary
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

# Summary

<BigValue data={totals} value=total_items title="Total items" />
<BigValue data={totals} value=total_rated title="Rated" />
<BigValue data={totals} value=avg_rating title="Avg rating across all domains" />

---

## Books

<BigValue data={books} value=total_items title="Total" />
<BigValue data={books} value=items_consumed title="Read" />
<BigValue data={books} value=items_pending title="To read" />
<BigValue data={books} value=avg_rating title="Avg rating" />

## Movies

<BigValue data={movies} value=total_items title="Total" />
<BigValue data={movies} value=items_consumed title="Watched" />
<BigValue data={movies} value=items_pending title="Wishlist" />
<BigValue data={movies} value=avg_rating title="Avg rating" />

## Music

<BigValue data={music} value=total_items title="Albums" />
<BigValue data={music} value=items_rated title="Rated" />
<BigValue data={music} value=avg_rating title="Avg rating" />

---

## Collection size by domain

<BarChart
    data={by_domain}
    x=domain
    y=total_items
    title="Total items per domain"
/>

## Avg rating by domain

<BarChart
    data={by_domain}
    x=domain
    y=avg_rating
    title="Average rating per domain"
    yMin=0
    yMax=5
/>
