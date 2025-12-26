#!/bin/sh

VERSION="20251226-v1";

# Tag com versão específica
docker tag chatwoot-minisite:latest tmsoftbrasil/chatwoot-minisite:$VERSION;

# Tag como latest (sempre aponta para a versão mais recente)
docker tag chatwoot-minisite:latest tmsoftbrasil/chatwoot-minisite:latest;

# Enviar versão específica
docker push tmsoftbrasil/chatwoot-minisite:$VERSION;

# Enviar latest
docker push tmsoftbrasil/chatwoot-minisite:latest;


exit 0;

