# docker compose down --rmi all -v --remove-orphans
docker compose build
docker compose run --rm ol ./worker.sh