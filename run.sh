#!/bin/sh

# Nome de DNS
    NAME="chatwoot-minisite"
    FQDN="chatwoot-minisite.$(hostname -f)"
    LOCAL="$NAME.intranet.br"
    TZ="America/Sao_Paulo"

    # Imagem construida localmente
    #IMAGE="chatwoot-minisite-dev";
    IMAGE="chatwoot-minisite";

# Variaveis de ambiente
    # Apontar para URL do chatwoot
    # CHATWOOT_BASE_URL="https://chat.dominio.com";
    # CHATWOOT_BASE_URL="https://chat.dominio.com:9380";
    CHATWOOT_BASE_URL="https://chat.dominio.com";

    # Token para obter o codigo
    CHATWOOT_WEBSITE_TOKEN="edVZaDsveSTUjNIged1ahn2S";

    # Puxar de arquivo local, se presente
    [ -f /etc/chatwoot-url ] && CHATWOOT_BASE_URL=$(head -1 /etc/chatwoot-url);
    [ -f /etc/chatwoot-wtk ] && CHATWOOT_WEBSITE_TOKEN=$(head -1 /etc/chatwoot-wtk);


# Renovar/rodar:
    docker rm -f $NAME 2>/dev/null;
    docker run \
        -d --restart=always \
        --name $NAME -h $LOCAL \
        --network network_public \
        \
        --tmpfs /run:rw,noexec,nosuid,size=1m \
        --read-only \
        --cpus="1.0" --memory=512m --memory-swap=512m \
        \
        -e TZ=$TZ \
        \
        -e "CHATWOOT_BASE_URL=$CHATWOOT_BASE_URL" \
        -e "CHATWOOT_WEBSITE_TOKEN=$CHATWOOT_WEBSITE_TOKEN" \
        \
        -p 32080:80 \
        \
        --label "traefik.enable=true" \
        --label "traefik.enable=true" \
        --label "traefik.http.routers.$NAME.rule=Host(\`$FQDN\`)" \
        --label "traefik.http.routers.$NAME.entrypoints=web,websecure" \
        --label "traefik.http.routers.$NAME.tls=true" \
        --label "traefik.http.routers.$NAME.tls.certresolver=letsencrypt" \
        --label "traefik.http.services.$NAME.loadbalancer.server.port=80" \
        \
        $IMAGE #sleep 9999999



exit 0;



