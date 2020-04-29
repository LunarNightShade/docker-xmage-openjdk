#!/bin/sh

XMAGE_CONFIG=/xmage/mage-server/config/config.xml

sed -i -e "s#\(serverAddress=\)[\"].*[\"]#\1\"$XMAGE_DOCKER_SERVER_ADDRESS\"#g" ${XMAGE_CONFIG}
sed -i -e "s#\(serverName=\)[\"].*[\"]#\1\"$XMAGE_DOCKER_SERVER_NAME\"#g" ${XMAGE_CONFIG}
sed -i -e "s#\(port=\)[\"].*[\"]#\1\"$XMAGE_DOCKER_PORT\"#g" ${XMAGE_CONFIG}
sed -i -e "s#\(secondaryBindPort=\)[\"].*[\"]#\1\"$XMAGE_DOCKER_SEONDARY_BIND_PORT\"#g" ${XMAGE_CONFIG}
sed -i -e "s#\(maxSecondsIdle=\)[\"].*[\"]#\1\"$XMAGE_DOCKER_MAX_SECONDS_IDLE\"#g" ${XMAGE_CONFIG}
sed -i -e "s#\(authenticationActivated=\)[\"].*[\"]#\1\"$XMAGE_DOCKER_AUTHENTICATION_ACTIVATED\"#g" ${XMAGE_CONFIG}
sed -i -e "s#\(maxGameThreads=\)[\"].*[\"]#\1\"$XMAGE_DOCKER_MAX_GAME_THREADS\"#g" ${XMAGE_CONFIG}
sed -i -e "s#\(minUserNameLength=\)[\"].*[\"]#\1\"$XMAGE_DOCKER_MIN_USERNAME_LENGTH\"#g" ${XMAGE_CONFIG}
sed -i -e "s#\(maxUserNameLength=\)[\"].*[\"]#\1\"$XMAGE_DOCKER_MAX_USERNAME_LENGTH\"#g" ${XMAGE_CONFIG}
sed -i -e "s#\(minPasswordLength=\)[\"].*[\"]#\1\"$XMAGE_DOCKER_MIN_PASSWORD_LENGTH\"#g" ${XMAGE_CONFIG}
sed -i -e "s#\(maxPasswordLength=\)[\"].*[\"]#\1\"$XMAGE_DOCKER_MAX_PASSWORD_LENGTH\"#g" ${XMAGE_CONFIG}
sed -i -e "s#\(mailgunApiKey=\)[\"].*[\"]#\1\"$XMAGE_DOCKER_MAILGUN_API_KEY\"#g" ${XMAGE_CONFIG}
sed -i -e "s#\(mailgunDomain=\)[\"].*[\"]#\1\"$XMAGE_DOCKER_MAILGUN_DOMAIN\"#g" ${XMAGE_CONFIG}

java -Xms$JAVA_MIN_MEMORY -Xmx$JAVA_MAX_MEMORY -Djava.security.policy=./config/security.policy -Djava.util.logging.config.file=./config/logging.config -Dlog4j.configuration=file:./config/log4j.properties -jar ./lib/mage-server-*.jar -adminPassword=$XMAGE_DOCKER_ADMIN_PASSWORD