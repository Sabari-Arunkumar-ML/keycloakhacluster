FROM quay.io/keycloak/keycloak:22.0.3

COPY cache-ispn-jdbc-ping.xml /opt/keycloak/conf/cache-ispn-jdbc-ping.xml
COPY snappyflow.pem /opt/keycloak/conf/
COPY snappyflowkey.pem /opt/keycloak/conf/

ENV KC_CACHE_CONFIG_FILE=cache-ispn-jdbc-ping.xml

ENV KC_HTTPS_CERTIFICATE_FILE=/opt/keycloak/conf/keycloak.pem
ENV KC_HTTPS_CERTIFICATE_KEY_FILE=/opt/keycloak/conf/keycloakkey.pem
