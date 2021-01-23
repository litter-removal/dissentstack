#!/bin/sh

psql invidious kemal -c "ALTER TABLE videos DROP COLUMN title CASCADE"
psql invidious kemal -c "ALTER TABLE videos DROP COLUMN views CASCADE"
psql invidious kemal -c "ALTER TABLE videos DROP COLUMN likes CASCADE"
psql invidious kemal -c "ALTER TABLE videos DROP COLUMN dislikes CASCADE"
psql invidious kemal -c "ALTER TABLE videos DROP COLUMN wilson_score CASCADE"
psql invidious kemal -c "ALTER TABLE videos DROP COLUMN published CASCADE"
psql invidious kemal -c "ALTER TABLE videos DROP COLUMN description CASCADE"
psql invidious kemal -c "ALTER TABLE videos DROP COLUMN language CASCADE"
psql invidious kemal -c "ALTER TABLE videos DROP COLUMN author CASCADE"
psql invidious kemal -c "ALTER TABLE videos DROP COLUMN ucid CASCADE"
psql invidious kemal -c "ALTER TABLE videos DROP COLUMN allowed_regions CASCADE"
psql invidious kemal -c "ALTER TABLE videos DROP COLUMN is_family_friendly CASCADE"
psql invidious kemal -c "ALTER TABLE videos DROP COLUMN genre CASCADE"
psql invidious kemal -c "ALTER TABLE videos DROP COLUMN genre_url CASCADE"
psql invidious kemal -c "ALTER TABLE videos DROP COLUMN license CASCADE"
psql invidious kemal -c "ALTER TABLE videos DROP COLUMN sub_count_text CASCADE"
psql invidious kemal -c "ALTER TABLE videos DROP COLUMN author_thumbnail CASCADE"
