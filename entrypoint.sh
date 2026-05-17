#!/bin/bash
set -e

rm -f /app/tmp/pids/server.pid

echo "Iniciando banco de dados e rodando migrations..."
bundle exec rails db:create db:migrate

echo "Compilando assets..."
bundle exec rails assets:precompile

exec "$@"
