FROM quay.io/keycloak/keycloak:latest

USER root
COPY themes/src/main/resources/theme/mattercall /opt/keycloak/themes/mattercall
RUN chown -R keycloak:keycloak /opt/keycloak/themes/mattercall
USER keycloak
