# keycloakhacluster

Pre-requisites:

	docker 
	n-node vms, reachable to each other, 7600 port should be open.
	psotgresql installed.

Download docker file and cache.xml file


Create docker image

	docker build . -t keycloak:latest


Run docker command in each node to form the keycloak cluster(Replace {IP} with you IP adddress)

	docker run --name mykeycloak1 -p 8080:8080 -p 7600:7600 \
	        -e KEYCLOAK_ADMIN=admin -e KEYCLOAK_ADMIN_PASSWORD=admin \
	        -e KEYCLOAK_FRONTEND_URL="http://{IP}:8080/auth" \
	        -e PROXY_ADDRESS_FORWARDING=true \
	        -e CACHE_OWNERS=2 \
	        -e KC_CACHE=ispn \
	         -e KC_DB_URL_DATABASE=keycloak2 \
	        -e KC_DB_USERNAME=keycloak \
	        -e KC_DB_PASSWORD=password \
	        -e KC_DB=postgres \
	        -e KC_DB_URL_HOST={IP} \
	        -e KC_DB_URL_PORT=5432 \
	        -e CACHE_OWNERS_AUTH_SESSIONS_COUNT=2 \
	        -e JGROUPS_DISCOVERY_PROTOCOL=JDBC_PING \
	        -e JGROUPS_DISCOVERY_EXTERNAL_IP={IP} \
	        keycloak1 \
	        start --http-enabled=true \
	        --hostname={IP} \
	        --hostname-port=8080 \
	        --db=postgres --features=token-exchange \
	        --db-url=jdbc:postgresql://{IP}:5432/keycloak2 --db-username=keycloak --db-password=password
       
       


