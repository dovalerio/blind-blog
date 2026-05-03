#!/bin/bash
set -e

rm -f /app/tmp/pids/server.pid

echo "Aguardando banco de dados..."
until bundle exec rails db:version &>/dev/null; do
  echo "Banco ainda não disponível, aguardando 2s..."
  sleep 2
done

echo "Rodando migrations..."
bundle exec rails db:migrate

echo "Compilando assets..."
bundle exec rails assets:precompile

exec "$@"
