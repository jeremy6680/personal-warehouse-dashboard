select
    movie_id,
    title,
    content_type,
    release_year,
    is_watched,
    is_rated,
    first_watched_date,
    last_watched_date,
    rating,
    directors,
    genres,
    runtime_minutes,
    tmdb_id,
    letterboxd_uri,
    country,
    source
from personal_warehouse.mrt_movies__collection
