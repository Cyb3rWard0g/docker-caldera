# Author: Roberto Rodriguez (@Cyb3rWard0g)
# License: GPL-3.0

# Referneces:
# https://github.com/mitre/caldera

FROM phusion/baseimage:0.11
LABEL maintainer="Roberto Rodriguez @Cyb3rWard0g"
LABEL description="Dockerfile Caldera.."

USER root

# **** Set ARG Values ****
ARG CALDERA_USER=caldera
ARG CALDERA_UID=510
ARG CALDERA_GID=510
ARG CALDERA_HOME=/usr/src/app

ENV DEBIAN_FRONTEND noninteractive
ENV GOPATH=/usr/bin/go

# ********** Caldera User ******
ENV USER ${CALDERA_USER}
ENV CALDERA_UID ${CALDERA_UID}
ENV HOME /home/${CALDERA_USER}
ENV CALDERA_GID $CALDERA_GID
ENV CALDERA_HOME ${CALDERA_HOME}
ENV PATH ${HOME}/.local/bin:$PATH

# *********** Installing Prerequisites ***************
# -qq : No output except for errors
RUN add-apt-repository ppa:longsleep/golang-backports \
  && apt-get update && apt-get install -qqy --no-install-recommends \
  wget sudo nano git python3-pip python3-setuptools python3-dev build-essential golang-go \
  && apt-get update \
  && apt-get -qy clean \
  autoremove \
  && rm -rf /var/lib/apt/lists/* \
  # ********** Adding Caldera User **************
  && echo "auth requisite pam_deny.so" >> /etc/pam.d/su \
  # remove the sudo rights for all users with admin privileges or in admin group
  && sed -i.bak -e 's/^%admin/#%admin/' /etc/sudoers \
  && sed -i.bak -e 's/^%sudo/#%sudo/' /etc/sudoers \
  && groupadd -g ${CALDERA_GID} ${CALDERA_USER} \
  && useradd -m -s /bin/bash -u ${CALDERA_UID} -g ${CALDERA_GID} ${CALDERA_USER} \
  # Clone Caldera Repository
  && git clone --recursive https://github.com/mitre/caldera.git ${CALDERA_HOME} \
  && cd ${CALDERA_HOME} && git submodule update --recursive --remote \
  && chown -R ${USER} ${CALDERA_HOME}

USER ${USER}

RUN cd ${CALDERA_HOME} \
  && pip3 install wheel \
  && pip3 install --no-cache-dir -r requirements.txt

COPY conf/local.yml ${CALDERA_HOME}/conf/local.yml
COPY scripts/caldera-entrypoint.sh ${CALDERA_HOME}/

USER root

RUN chmod +x ${CALDERA_HOME}/caldera-entrypoint.sh \
  && chown -R ${USER} ${CALDERA_HOME} ${HOME}

WORKDIR ${CALDERA_HOME}
ENTRYPOINT ["./caldera-entrypoint.sh"]
CMD ["python3", "server.py"]

USER ${USER}