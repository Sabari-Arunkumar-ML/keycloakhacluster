#!/bin/sh

if [ -f "/opt/keycloak/config/keycloak.conf" ]; then
    conf_file="/opt/keycloak/config/keycloak.conf"
else
    conf_file="/opt/keycloak/conf/keycloak.conf"
fi

while IFS='=' read -r key value
do
    export ${key}=${value}
done < "${conf_file}"

/opt/keycloak/bin/kc.sh "$@"
