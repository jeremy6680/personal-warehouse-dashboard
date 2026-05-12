---
title: Manga — Statistiques
---

```sql by_genre
select
    coalesce(nullif(genre, ''), 'Non renseigné') as genre,
    count(*) as manga,
    round(avg(rating), 2) as avg_rating
from personal_warehouse.mrt_manga__collection
group by coalesce(nullif(genre, ''), 'Non renseigné')
order by manga desc
limit 20
```

```sql by_country
select
    coalesce(country, 'Non renseigné') as country,
    count(*) as manga,
    round(avg(rating), 2) as avg_rating
from personal_warehouse.mrt_manga__collection
group by coalesce(country, 'Non renseigné')
order by manga desc
limit 20
```

```sql rating_dist
select
    coalesce(cast(cast(rating as decimal(2, 1)) as varchar), 'Non noté') as rating_label,
    count(*) as manga
from personal_warehouse.mrt_manga__collection
group by coalesce(cast(cast(rating as decimal(2, 1)) as varchar), 'Non noté')
order by
    case when rating_label = 'Non noté' then 1 else 0 end,
    rating_label desc
```

```sql top_authors
select
    author,
    count(*) as manga,
    countif(is_rated) as rated,
    round(avg(rating), 2) as avg_rating
from personal_warehouse.mrt_manga__collection
where author is not null
group by author
order by manga desc, avg_rating desc
limit 15
```


## Par genre

<BarChart data={by_genre} x=genre y=manga title="Manga par genre" swapXY=true />

## Par pays

<BarChart data={by_country} x=country y=manga title="Manga par pays de l'auteur" swapXY=true />

## Distribution des notes

<BarChart data={rating_dist} x=rating_label y=manga title="Distribution des notes" />

## Top auteurs

<DataTable data={top_authors} rows=15>
    <Column id=author title="Auteur" />
    <Column id=manga title="Manga" />
    <Column id=rated title="Notés" />
    <Column id=avg_rating title="Note moyenne" />
</DataTable>
