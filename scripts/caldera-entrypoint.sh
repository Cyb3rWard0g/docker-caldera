#!/bin/bash

# Author: Roberto Rodriguez (@Cyb3rWard0g)
# License: GPL-3.0

# Caldera Home
CALDERA_HOME=/usr/src/app

# *********** Configuring Caldera **************
echo "Processing Caldera environment variables.."
if [[ "$CALDERA_ABILITY_REFRESH" ]]; then
  echo "[+] Setting Caldera ability refresh to $CALDERA_ABILITY_REFRESH"
  sed -i "s/^ability_refresh\:.*$/ability_refresh\: ${CALDERA_ABILITY_REFRESH}/g" ${CALDERA_HOME}/conf/local.yml
fi

if [[ -z "$CALDERA_API_KEY_BLUE" ]]; then
  CALDERA_API_KEY_BLUE=$(cat /proc/sys/kernel/random/uuid)
  echo "[+] Updating default Caldera API key blue to $CALDERA_API_KEY_BLUE"
  sed -i "s/^api_key_blue\: BLUEADMIN123/api_key_blue\: ${CALDERA_API_KEY_BLUE}/g" ${CALDERA_HOME}/conf/local.yml
else
  echo "[+] Setting Caldera API key blue to $CALDERA_API_KEY_BLUE"
  sed -i "s/^api_key_blue\:.*$/api_key_blue\: ${CALDERA_API_KEY_BLUE}/g" ${CALDERA_HOME}/conf/local.yml
fi

if [[ -z "$CALDERA_API_KEY_RED" ]]; then
  CALDERA_API_KEY_RED=$(cat /proc/sys/kernel/random/uuid)
  echo "[+] Updating default Caldera API key red to $CALDERA_API_KEY_RED"
  sed -i "s/^api_key_red\: ADMIN123/api_key_red\: ${CALDERA_API_KEY_RED}/g" ${CALDERA_HOME}/conf/local.yml
else
  echo "[+] Setting Caldera API key red to $CALDERA_API_KEY_RED"
  sed -i "s/^api_key_red\:.*$/api_key_red\: ${CALDERA_API_KEY_RED}/g" ${CALDERA_HOME}/conf/local.yml
fi

if [[ -z "$CALDERA_ENCRYPTION_KEY" ]]; then
  CALDERA_ENCRYPTION_KEY=$(cat /proc/sys/kernel/random/uuid)
  echo "[+] Updating default Caldera encryption key to $CALDERA_ENCRYPTION_KEY"
  sed -i "s/^encryption_key\: ADMIN123/encryption_key\: ${CALDERA_ENCRYPTION_KEY}/g" ${CALDERA_HOME}/conf/local.yml
else
  echo "[+] Setting Caldera encryption key to $CALDERA_ENCRYPTION_KEY"
  sed -i "s/^encryption_key\:.*$/encryption_key\: ${CALDERA_ENCRYPTION_KEY}/g" ${CALDERA_HOME}/conf/local.yml
fi

if [[ -z "$CALDERA_APP_CONTACT_GIST" ]]; then
  CALDERA_APP_CONTACT_GIST=$(cat /proc/sys/kernel/random/uuid)
  echo "[+] Updating default Caldera app contact gist API key to $CALDERA_APP_CONTACT_GIST"
  sed -i "s/^app.contact.gist\: API_KEY/app.contact.gist\: ${CALDERA_APP_CONTACT_GIST}/g" ${CALDERA_HOME}/conf/local.yml
else
  echo "[+] Setting Caldera app contact gist API key to $CALDERA_APP_CONTACT_GIST"
  sed -i "s/^app.contact.gist\:.*$/app.contact.gist\: ${CALDERA_APP_CONTACT_GIST}/g" ${CALDERA_HOME}/conf/local.yml
fi

if [[ "$CALDERA_IP" ]]; then
  echo "[+] Setting Caldera IP to $CALDERA_IP"
  sed -i "s/0.0.0.0/${CALDERA_IP}|g" ${CALDERA_HOME}/conf/local.yml
else
  CALDERA_IP=0.0.0.0
fi

if [[ "$CALDERA_HTTP_PORT" ]]; then
  echo "[+] Setting Caldera HTTP port to $CALDERA_HTTP_PORT"
  sed -i "s|^app.contact.http\: http\://${CALDERA_IP}\:.*$|app.contact.http\: http\://${CALDERA_IP}\:${CALDERA_HTTP_PORT}|g" ${CALDERA_HOME}/conf/local.yml
fi

if [[ "$CALDERA_TCP_PORT" ]]; then
  echo "[+] Setting Caldera TCP port to $CALDERA_TCP_PORT"
  sed -i "s/^app.contact.tcp\: ${CALDERA_IP}\:.*$/app.contact.tcp\: ${CALDERA_IP}\:${CALDERA_TCP_PORT}/g" ${CALDERA_HOME}/conf/local.yml
fi

if [[ "$CALDERA_UDP_PORT" ]]; then
  echo "[+] Setting Caldera UDP port to $CALDERA_UDP_PORT"
  sed -i "s/^app.contact.udp: ${CALDERA_IP}\:.*$/app.contact.udp: ${CALDERA_IP}\:${CALDERA_UDP_PORT}/g" ${CALDERA_HOME}/conf/local.yml
fi

if [[ "$CALDERA_WEBSOCKET_PORT" ]]; then
  echo "[+] Setting Caldera Websocket port to $CALDERA_WEBSOCKET_PORT"
  sed -i "s/^app.contact.websocket: ${CALDERA_IP}\:.*$/app.contact.websocket: ${CALDERA_IP}\:${CALDERA_WEBSOCKET_PORT}/g" ${CALDERA_HOME}/conf/local.yml
fi

if [[ -z "$CALDERA_CRYPT_SALT" ]]; then
  CALDERA_CRYPT_SALT=$(cat /proc/sys/kernel/random/uuid)
fi
echo "[+] Setting Caldera crypt salt to $CALDERA_CRYPT_SALT"
sed -i "s/^crypt_salt\:.*$/crypt_salt\: ${CALDERA_CRYPT_SALT}/g" ${CALDERA_HOME}/conf/local.yml


if [[ "$CALDERA_EXFIL_DIR" ]]; then
  echo "[+] Setting Caldera exfil directory to $CALDERA_EXFIL_DIR"
  sed -i "s|^exfil_dir\:.*$|exfil_dir\: ${CALDERA_EXFIL_DIR}|g" ${CALDERA_HOME}/conf/local.yml
fi

if [[ "$CALDERA_PORT" ]]; then
  echo "[+] Setting Caldera port to $CALDERA_PORT"
  sed -i "s/^port\:.*$/port\: ${CALDERA_PORT}/g" ${CALDERA_HOME}/conf/local.yml
fi

if [[ "$CALDERA_REPORTS_DIR" ]]; then
  echo "[+] Setting Caldera reports directory to $CALDERA_REPORTS_DIR"
  sed -i "s|^reports_dir\:.*$|reports_dir\: ${CALDERA_REPORTS_DIR}|g" ${CALDERA_HOME}/conf/local.yml
fi

if [[ -z "$CALDERA_BLUE_USER_NAME" ]]; then
  CALDERA_BLUE_USER_NAME=blue
fi
echo "[+] Setting Caldera default blue username to $CALDERA_BLUE_USER_NAME"

if [[ -z "$CALDERA_BLUE_USER_PASSWORD" ]]; then
  CALDERA_BLUE_USER_PASSWORD=$(cat /proc/sys/kernel/random/uuid)
fi
echo "[+] Setting Caldera default blue user password to $CALDERA_BLUE_USER_PASSWORD"
sed -i "s/blue\: admin/${CALDERA_BLUE_USER_NAME}\: ${CALDERA_BLUE_USER_PASSWORD}/g" ${CALDERA_HOME}/conf/local.yml

if [[ -z "$CALDERA_RED_ADMIN_NAME" ]]; then
  CALDERA_RED_ADMIN_NAME=admin
fi
echo "[+] Setting Caldera default red admin username to $CALDERA_RED_ADMIN_NAME"

if [[ -z "$CALDERA_RED_ADMIN_PASSWORD" ]]; then
  CALDERA_RED_ADMIN_PASSWORD=$(cat /proc/sys/kernel/random/uuid)
fi
echo "[+] Setting Caldera default red admin password to $CALDERA_RED_ADMIN_PASSWORD"
sed -i "s/admin\: admin/${CALDERA_RED_ADMIN_NAME}\: ${CALDERA_RED_ADMIN_PASSWORD}/g" ${CALDERA_HOME}/conf/local.yml

if [[ -z "$CALDERA_RED_USER_NAME" ]]; then
  CALDERA_RED_USER_NAME=red
fi
echo "[+] Setting Caldera default red username to $CALDERA_RED_USER_NAME"

if [[ -z "$CALDERA_RED_USER_PASSWORD" ]]; then
  CALDERA_RED_USER_PASSWORD=$(cat /proc/sys/kernel/random/uuid)
fi
echo "[+] Setting Caldera default red user password to $CALDERA_RED_USER_PASSWORD"
sed -i "s/red\: admin/${CALDERA_RED_USER_NAME}\: ${CALDERA_RED_USER_PASSWORD}/g" ${CALDERA_HOME}/conf/local.yml

echo " "
echo "[+] Local conf file:"
cat ${CALDERA_HOME}/conf/local.yml
echo " "

exec "$@"