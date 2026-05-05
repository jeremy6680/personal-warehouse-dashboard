---
title: Personal Warehouse
---

```sql summary
select
    'Music' as domain,
    count(*) as total_items,
    round(avg(rating), 1) as avg_rating,
    countif(is_rated) as rated_items
from personal_warehouse.mrt_music__collection
```

# Personal Warehouse

A data-driven view of my media collection — books, music, and films —
built with dbt + BigQuery + Evidence.

---

## Collection at a glance

<BigValue data={summary} value=total_items title="Albums" />

---

## Explore

- [Music → Collection](/music/collection)
- [Music → Stats](/music/stats)
- [Books → Collection](/books/collection)
- [Books → Stats](/books/stats)
- [Movies → Collection](/movies/collection)
- [Movies → Stats](/movies/stats)
- [Summary](/summary)
- [World Map](/map)

