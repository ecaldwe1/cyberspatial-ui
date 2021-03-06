#!/bin/bash
set -e
cmd="$@"

# This entrypoint is used to play nicely with the current cookiecutter configuration.
# Since docker-compose relies heavily on environment variables itself for configuration, we'd have to define multiple
# environment variables just to support cookiecutter out of the box. That makes no sense, so this little entrypoint
# does all this for us.

function postgres_ready(){
python << END
import sys
import psycopg2
try:
    conn = psycopg2.connect(dbname="$DATABASE_NAME", user="$DATABASE_USER", password="$DATABASE_PASSWORD", host="$DATABASE_HOST")
except psycopg2.OperationalError:
    sys.exit(-1)
sys.exit(0)
END
}

until postgres_ready; do
 >&2 echo "Postgres is unavailable - sleeping"
 sleep 1
done

>&2 echo "Postgres is up - continuing..."
python manage.py migrate --noinput
exec python manage.py runserver 0.0.0.0:8000
