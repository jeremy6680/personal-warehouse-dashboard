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


Une vue data de ma médiathèque — livres, musique, films, manga et animé —
construite avec dbt + BigQuery + Evidence.

---

## Ma collection en un coup d'œil

<BigValue data={summary} value=total_items title="Albums" />

---

## Explorer

- [Musique → Collection](/music/collection)
- [Musique → Statistiques](/music/stats)
- [Livres → Collection](/books/collection)
- [Livres → Statistiques](/books/stats)
- [Films → Collection](/movies/collection)
- [Films → Statistiques](/movies/stats)
- [Manga → Collection](/manga/collection)
- [Manga → Statistiques](/manga/stats)
- [Animé → Collection](/anime/collection)
- [Animé → Statistiques](/anime/stats)
- [Résumé](/summary)
- [Carte du monde](/map)

---
