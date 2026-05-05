---
title: Livres — Statistiques
---

```sql by_status
select
    status,
    count(*) as books
from personal_warehouse.mrt_books__collection
where status is not null
group by status
order by books desc
```

```sql by_genre
select
    genre,
    count(*) as books,
    round(avg(rating), 2) as avg_rating
from personal_warehouse.mrt_books__collection
where genre is not null and genre != ''
group by genre
order by books desc
limit 20
```

```sql by_country
select
    country,
    count(*) as books,
    round(avg(rating), 2) as avg_rating
from personal_warehouse.mrt_books__collection
where country is not null
group by country
order by books desc
limit 20
```

```sql by_decade
select
    cast(cast(floor(year_published / 10) * 10 as bigint) as varchar) as decade,
    count(*) as books,
    round(avg(rating), 2) as avg_rating
from personal_warehouse.mrt_books__collection
where year_published is not null
group by floor(year_published / 10) * 10
order by floor(year_published / 10) * 10
```

```sql rating_dist
select
    rating,
    count(*) as books
from personal_warehouse.mrt_books__collection
where rating is not null
group by rating
order by rating desc
```

```sql top_authors
select
    author,
    count(*) as books,
    countif(is_read) as read,
    round(avg(rating), 2) as avg_rating
from personal_warehouse.mrt_books__collection
where author is not null
group by author
order by books desc, avg_rating desc
limit 15
```


## Par statut

<BarChart data={by_status} x=status y=books title="Livres par statut" swapXY=true />

## Par genre

<BarChart data={by_genre} x=genre y=books title="Livres par genre" swapXY=true />

## Par pays de l'auteur

<BarChart data={by_country} x=country y=books title="Livres par pays de l'auteur" swapXY=true />

## Par décennie de publication

<BarChart data={by_decade} x=decade y=books title="Livres par décennie de publication" sort=false />

## Distribution des notes

<BarChart data={rating_dist} x=rating y=books title="Distribution des notes (livres lus)" />

## Top auteurs (par nombre de livres)

<DataTable data={top_authors} rows=15>
    <Column id=author title="Auteur" />
    <Column id=books title="Livres" />
    <Column id=read title="Lus" />
    <Column id=avg_rating title="Note moyenne" />
</DataTable>
