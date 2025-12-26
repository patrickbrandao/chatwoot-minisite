#!/bin/sh

# Remover containers
    docker ps -a | egrep chatwoot-minisite | sort -R | awk '{print $1}' | \
	    while read did; do docker stop $did  2>/dev/null; docker rm $did  2>/dev/null; done

# Remover imagens
    docker rmi chatwoot-minisite 2>/dev/null;
    docker rmi -f chatwoot-minisite 2>/dev/null;
    docker rmi -f tmsoftbrasil/chatwoot-minisite:0.0.1 2>/dev/null;
    docker rmi -f tmsoftbrasil/chatwoot-minisite:latest 2>/dev/null;

# Limpar geral
#   docker system prune -f


exit 0;

