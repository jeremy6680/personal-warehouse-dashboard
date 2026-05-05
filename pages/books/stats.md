---
title: Books — Stats
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

# Books — Stats

## By status

<BarChart data={by_status} x=status y=books title="Books by status" swapXY=true />

## By genre

<BarChart data={by_genre} x=genre y=books title="Books by genre" swapXY=true />

## By country

<BarChart data={by_country} x=country y=books title="Books by country of author" swapXY=true />

## By decade published

<BarChart data={by_decade} x=decade y=books title="Books by decade published" sort=false />

## Rating distribution

<BarChart data={rating_dist} x=rating y=books title="Rating distribution (read books)" />

## Top authors (by book count)

<DataTable data={top_authors} rows=15>
    <Column id=author />
    <Column id=books />
    <Column id=read />
    <Column id=avg_rating title="Avg rating" />
</DataTable>
