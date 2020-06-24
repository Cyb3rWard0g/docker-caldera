# Author: Roberto Rodriguez (@Cyb3rWard0g)
# License: GPL-3.0

# Referneces:
# https://github.com/mitre-attack/attack-arsenal/tree/master/adversary_emulation/APT29

FROM cyb3rward0g/docker-caldera:2.6.6
LABEL maintainer="Roberto Rodriguez @Cyb3rWard0g"
LABEL description="Dockerfile Mordor Caldera Evals"

USER ${USER}

RUN git clone https://github.com/mitre-attack/attack-arsenal \
  && cp -r attack-arsenal/adversary_emulation/APT29/CALDERA_DIY/evals $CALDERA_HOME/plugins/evals

COPY conf/local.yml ${CALDERA_HOME}/conf/local.yml