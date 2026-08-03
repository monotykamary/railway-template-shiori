#!/bin/sh
set -eu
: "${SHIORI_HTTP_SECRET_KEY:?SHIORI_HTTP_SECRET_KEY is required}"
: "${SHIORI_ADMIN_USER:?SHIORI_ADMIN_USER is required}"
: "${SHIORI_ADMIN_PASSWORD:?SHIORI_ADMIN_PASSWORD is required}"
export SHIORI_DIR=${SHIORI_DIR:-/data}
export SHIORI_HTTP_PORT=${PORT:-8080}
mkdir -p "$SHIORI_DIR"
/usr/bin/shiori server &
pid=$!
trap 'kill -TERM "$pid" 2>/dev/null || true; wait "$pid" 2>/dev/null || true' TERM INT
for i in $(seq 1 120); do
  if curl -fsS "http://127.0.0.1:$SHIORI_HTTP_PORT/" >/dev/null 2>&1; then break; fi
  sleep 1
done
marker="$SHIORI_DIR/.railway-admin-created"
if [ ! -f "$marker" ]; then
  response=$(curl -fsS -H 'Content-Type: application/json' -d '{"username":"shiori","password":"gopher","remember_me":false}' "http://127.0.0.1:$SHIORI_HTTP_PORT/api/v1/auth/login")
  token=$(printf '%s' "$response" | sed -n 's/.*"token":"\([^"]*\)".*/\1/p')
  [ -n "$token" ]
  payload=$(printf '{"username":"%s","old_password":"gopher","new_password":"%s","owner":true}' "$SHIORI_ADMIN_USER" "$SHIORI_ADMIN_PASSWORD")
  curl -fsS -X PATCH -H "Authorization: Bearer $token" -H 'Content-Type: application/json' -d "$payload" "http://127.0.0.1:$SHIORI_HTTP_PORT/api/v1/auth/account" >/dev/null
  touch "$marker"
fi
unset SHIORI_ADMIN_PASSWORD SHIORI_HTTP_SECRET_KEY
wait "$pid"
