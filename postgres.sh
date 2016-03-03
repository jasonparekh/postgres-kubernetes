#!/bin/bash

# expose credentials to docker-entrypoint
CREDENTIALS="/etc/postgres-credentials"

if [ -r "${CREDENTIALS}/user" ]; then
    POSTGRES_USER="$(cat ${CREDENTIALS}/user)"
fi
if [ -r "${CREDENTIALS}/password" ]; then
    POSTGRES_PASSWORD="$(cat ${CREDENTIALS}/password)"
fi

if [ -z "$POSTGRES_USER" ]; then
    if [ -z "$POSTGRES_PASSWORD" ]; then
        echo "[ERROR] Postgres username and password cannot be read from ${CREDENTIALS}/{user,password}"
        exit 1;
    else
        echo "[ERROR] Postgres username cannot be read from ${CREDENTIALS}/user"
        exit 1;
    fi
elif [ -z "$POSTGRES_PASSWORD" ]; then
    echo "[ERROR] Postgres password cannot be read from ${CREDENTIALS}/password"
    exit 1
fi

export POSTGRES_USER
export POSTGRES_PASSWORD
exec /docker-entrypoint.sh "postgres"

