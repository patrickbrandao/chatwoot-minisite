
# ChatWoot Minisite

Mini site para incluir chat do ChatWoot

Container com Lighttpd minimalista com HTML template.


## Instalar usando docker run

```bash

#!/bin/sh

# Nome de DNS
    NAME="chatwoot-minisite"
    FQDN="chatwoot-minisite.$(hostname -f)"
    LOCAL="$NAME.intranet.br"
    TZ="America/Sao_Paulo"

    # Imagem
    IMAGE="tmsoftbrasil/chatwoot-minisite";

# Variaveis de ambiente
    # Apontar para URL do ChatWoot (https:// + (nome ou IP) + :porta-se-houver )
    CHATWOOT_BASE_URL="https://chatwoot.meusite.com.br";

    # Token para obter o codigo
    CHATWOOT_WEBSITE_TOKEN="_coloque_o_token_aqui_";

# Obter imagem
    docker pull $IMAGE;

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
        $IMAGE;

```


## Construir localmente

Na pasta com os arquivos desse projeto, execute:

```bash

# Construir nova imagem
docker build . -t chatwoot-minisite;

```

Troque "tmsoftbrasil/chatwoot-minisite" por "chatwoot-minisite" para usar sua imagem local.


