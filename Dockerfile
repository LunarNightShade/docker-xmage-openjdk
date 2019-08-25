#XMage Version: 1.4.37v4
# Based on official OpenJDK Docker library image
FROM openjdk:8-jre-alpine

# Build and config ENVs

ENV JAVA_MIN_MEMORY=256M \
	JAVA_MAX_MEMORY=512M \
    GLIBC_VERSION=2.27-r0 \
	GLIBC_REPO=https://github.com/sgerrand/alpine-pkg-glibc \
    LANG=C.UTF-8 \
    XMAGE_DOCKER_SERVER_ADDRESS="0.0.0.0" \
    XMAGE_DOCKER_PORT="17171" \
    XMAGE_DOCKER_SEONDARY_BIND_PORT="17179" \
    XMAGE_DOCKER_MAX_SECONDS_IDLE="600" \
    XMAGE_DOCKER_AUTHENTICATION_ACTIVATED="false" \
    XMAGE_DOCKER_SERVER_NAME="mage-server" \
	XMAGE_DOCKER_ADMIN_PASSWORD="hunter2" \
	XMAGE_DOCKER_MAX_GAME_THREADS="10" \
	XMAGE_DOCKER_MIN_USERNAME_LENGTH="3" \
	XMAGE_DOCKER_MAX_USERNAME_LENGTH="14" \
	XMAGE_DOCKER_MIN_PASSWORD_LENGTH="8" \
	XMAGE_DOCKER_MAX_PASSWORD_LENGTH="100" \
	XMAGE_DOCKER_MAILGUN_API_KEY="X" \
	XMAGE_DOCKER_MAILGUN_DOMAIN="X"

#RUN based on anapsix/docker-alpine-java:8u172b11_server-jre
RUN set -ex && \
    apk -U upgrade && \
    apk add libstdc++ curl ca-certificates bash jq && \
    for pkg in glibc-${GLIBC_VERSION} glibc-bin-${GLIBC_VERSION} glibc-i18n-${GLIBC_VERSION}; do curl -sSL ${GLIBC_REPO}/releases/download/${GLIBC_VERSION}/${pkg}.apk -o /tmp/${pkg}.apk; done && \
    apk add --allow-untrusted /tmp/*.apk && \
    rm -v /tmp/*.apk && \
    ( /usr/glibc-compat/bin/localedef --force --inputfile POSIX --charmap UTF-8 C.UTF-8 || true ) && \
    echo "export LANG=C.UTF-8" > /etc/profile.d/locale.sh && \
    /usr/glibc-compat/sbin/ldconfig /lib /usr/glibc-compat/lib
 
#Following code based on Dockerfile from goesta/docker-xmage-alpine 
WORKDIR /xmage

RUN curl --silent --show-error http://xmage.de/xmage/config.json | jq '.XMage.location' | xargs curl -# -L > xmage.zip \
 && unzip xmage.zip -x "mage-client*" \
 && rm xmage.zip \
 && apk del curl jq

COPY dockerStartServer.sh /xmage/mage-server/

RUN chmod +x \
    /xmage/mage-server/startServer.sh \
    /xmage/mage-server/dockerStartServer.sh

EXPOSE 17171 17179

WORKDIR /xmage/mage-server

CMD [ "./dockerStartServer.sh" ]
