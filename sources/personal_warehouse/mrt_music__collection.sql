select
    album_id,
    title,
    artist,
    genres,
    release_year,
    rating,
    country,
    source_name,
    spotify_album_id,
    total_tracks,
    spotify_added_at,
    is_rated,
    discogs_release_id
from personal_warehouse.mrt_music__collection
