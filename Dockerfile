FROM quay.io/keycloak/keycloak:22.0.3

COPY cache-ispn-jdbc-ping.xml /opt/keycloak/conf/cache-ispn-jdbc-ping.xml
COPY keycloak.pem /opt/keycloak/conf/
COPY keycloakkey.pem /opt/keycloak/conf/
COPY quarkus.properties /opt/keycloak/conf/quarkus.properties

COPY entrypoint.sh /opt/keycloak/bin/entrypoint.sh
COPY keycloak.conf /opt/keycloak/conf/keycloak.conf

USER 0
RUN sed -i 's/keycloak:x:1000:0/keycloak:x:310:0/g' /etc/passwd
RUN chown -R 310:0 /opt/keycloak
USER 310

ENV KC_CACHE_CONFIG_FILE=cache-ispn-jdbc-ping.xml

ENV KC_HTTPS_CERTIFICATE_FILE=/opt/keycloak/conf/keycloak.pem
ENV KC_HTTPS_CERTIFICATE_KEY_FILE=/opt/keycloak/conf/keycloakkey.pem

ENTRYPOINT ["/opt/keycloak/bin/entrypoint.sh"]
CMD ["start"]
