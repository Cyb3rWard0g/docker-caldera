#!/bin/bash

# Author: Roberto Rodriguez (@Cyb3rWard0g)
# License: GPL-3.0

# Caldera Home
CALDERA_HOME=/usr/src/app

# *********** Configuring Caldera **************
echo "Processing Caldera environment variables.."
if [[ -z "$CALDERA_API_KEY_BLUE" ]]; then
  CALDERA_API_KEY_BLUE=$(cat /proc/sys/kernel/random/uuid)
fi
echo "Setting Caldera API key blue to $CALDERA_API_KEY_BLUE"

if [[ -z "$CALDERA_API_KEY_RED" ]]; then
  CALDERA_API_KEY_RED=$(cat /proc/sys/kernel/random/uuid)
fi
echo "Setting Caldera API key red to $CALDERA_API_KEY_RED"

if [[ -z "$CALDERA_ENCRYPTION_KEY" ]]; then
  CALDERA_ENCRYPTION_KEY=$(cat /proc/sys/kernel/random/uuid)
fi
echo "Setting Caldera encryption key to $CALDERA_ENCRYPTION_KEY"

if [[ -z "$CALDERA_APP_CONTACT_GIST" ]]; then
  CALDERA_APP_CONTACT_GIST=$(cat /proc/sys/kernel/random/uuid)
fi
echo "Setting Caldera app contact gist API key to $CALDERA_APP_CONTACT_GIST"

if [[ -z "$CALDERA_IP" ]]; then
  CALDERA_IP=0.0.0.0
fi
echo "Setting Caldera IP to $CALDERA_IP"

if [[ -z "$CALDERA_HTTP_PORT" ]]; then
  CALDERA_HTTP_PORT=8888
fi
echo "Setting Caldera HTTP port to $CALDERA_HTTP_PORT"

if [[ -z "$CALDERA_TCP_PORT" ]]; then
  CALDERA_TCP_PORT=7010
fi
echo "Setting Caldera TCP port to $CALDERA_TCP_PORT"

if [[ -z "$CALDERA_UDP_PORT" ]]; then
  CALDERA_UDP_PORT=7011
fi
echo "Setting Caldera UDP port to $CALDERA_UDP_PORT"

if [[ -z "$CALDERA_WEBSOCKET_PORT" ]]; then
  CALDERA_WEBSOCKET_PORT=7012
fi
echo "Setting Caldera Websocket port to $CALDERA_WEBSOCKET_PORT"

if [[ -z "$CALDERA_CRYPT_SALT" ]]; then
  CALDERA_CRYPT_SALT=$(cat /proc/sys/kernel/random/uuid)
fi
echo "Setting Caldera crypt salt to $CALDERA_CRYPT_SALT"

if [[ -z "$CALDERA_EXFIL_DIR" ]]; then
  CALDERA_EXFIL_DIR=/tmp
fi
echo "Setting Caldera exfil directory to $CALDERA_EXFIL_DIR"

if [[ -z "$CALDERA_PORT" ]]; then
  CALDERA_PORT=8888
fi
echo "Setting Caldera port to $CALDERA_PORT"

if [[ -z "$CALDERA_REPORTS_DIR" ]]; then
  CALDERA_REPORTS_DIR=/tmp
fi
echo "Setting Caldera reports directory to $CALDERA_REPORTS_DIR"

if [[ -z "$CALDERA_BLUE_USER_NAME" ]]; then
  CALDERA_BLUE_USER_NAME=blue
fi
echo "Setting Caldera blue admin user to $CALDERA_BLUE_USER_NAME"

if [[ -z "$CALDERA_BLUE_USER_PASSWORD" ]]; then
  CALDERA_BLUE_USER_PASSWORD=adminpwd
fi
echo "Setting Caldera blue admin password to $CALDERA_BLUE_USER_PASSWORD"

if [[ -z "$CALDERA_RED_ADMIN_NAME" ]]; then
  CALDERA_RED_ADMIN_NAME=admin
fi
echo "Setting Caldera red admin user to $CALDERA_RED_ADMIN_NAME"

if [[ -z "$CALDERA_RED_ADMIN_PASSWORD" ]]; then
  CALDERA_RED_ADMIN_PASSWORD=adminpwd
fi
echo "Setting Caldera red admin password to $CALDERA_RED_ADMIN_PASSWORD"

if [[ -z "$CALDERA_RED_USER_NAME" ]]; then
  CALDERA_RED_USER_NAME=red
fi
echo "Setting Caldera red admin user to $CALDERA_RED_USER_NAME"

if [[ -z "$CALDERA_RED_ADMIN_PASSWORD" ]]; then
  CALDERA_RED_USER_PASSWORD=adminpwd
fi
echo "Setting Caldera red admin password to $CALDERA_RED_USER_PASSWORD"

echo "Updating properties of the caldera local conf file .."
sed -i "s/^api_key_blue\:.*$/api_key_blue\: ${CALDERA_API_KEY_BLUE}/g" ${CALDERA_HOME}/conf/local.yml
sed -i "s/^api_key_red\:.*$/api_key_red\: ${CALDERA_API_KEY_RED}/g" ${CALDERA_HOME}/conf/local.yml
sed -i "s/^encryption_key\:.*$/encryption_key\: ${CALDERA_ENCRYPTION_KEY}/g" ${CALDERA_HOME}/conf/local.yml
sed -i "s/^app.contact.gist\:.*$/app.contact.gist\: ${CALDERA_APP_CONTACT_GIST}/g" ${CALDERA_HOME}/conf/local.yml
sed -i "s/^app.contact.http\: http\://127.0.0.1\:.*$/app.contact.http\: http\://127.0.0.1\:${CALDERA_HTTP_PORT}/g" ${CALDERA_HOME}/conf/local.yml
sed -i "s/^app.contact.tcp\: 127.0.0.1\:.*$/app.contact.tcp\: 127.0.0.1\:${CALDERA_TCP_PORT}/g" ${CALDERA_HOME}/conf/local.yml
sed -i "s/^app.contact.udp: 127.0.0.1\:.*$/app.contact.udp: 127.0.0.1\:${CALDERA_UDP_PORT}/g" ${CALDERA_HOME}/conf/local.yml
sed -i "s/^app.contact.websocket: 127.0.0.1\:.*$/app.contact.websocket: 127.0.0.1\:${CALDERA_WEBSOCKET_PORT}/g" ${CALDERA_HOME}/conf/local.yml
sed -i "s/^crypt_salt\:.*$/crypt_salt\: ${CALDERA_CRYPT_SALT}/g" ${CALDERA_HOME}/conf/local.yml
sed -i "s/^exfil_dir\:.*$/exfil_dir\: \\${CALDERA_EXFIL_DIR}/g" ${CALDERA_HOME}/conf/local.yml
sed -i "s/^port\:.*$/port\: ${CALDERA_PORT}/g" ${CALDERA_HOME}/conf/local.yml
sed -i "s/^reports_dir\:.*$/reports_dir\: \\${CALDERA_REPORTS_DIR}/g" ${CALDERA_HOME}/conf/local.yml
sed -i "s/    blue\: admin/   ${CALDERA_BLUE_USER_NAME}\: ${CALDERA_BLUE_USER_PASSWORD}/g" ${CALDERA_HOME}/conf/local.yml
sed -i "s/    admin\: admin/    ${CALDERA_RED_ADMIN_NAME}\: ${CALDERA_RED_ADMIN_PASSWORD}/g" ${CALDERA_HOME}/conf/local.yml
sed -i "s/    red\: admin/    ${CALDERA_RED_USER_NAME}\: ${CALDERA_RED_USER_PASSWORD}/g" ${CALDERA_HOME}/conf/local.yml

echo "Final local conf file .."
cat ${CALDERA_HOME}/conf/local.yml
echo " "

exec "$@"