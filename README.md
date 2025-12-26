
# ChatWoot Minisite

Mini site para incluir chat do ChatWoot

Container com Lighttpd minimalista com HTML template.

![ChatWoot Mini Site - Screenshot](https://raw.githubusercontent.com/patrickbrandao/chatwoot-minisite/master/contrib/chatwoot-minisite-banner-01.png)

## Instalar usando docker run

```bash
#!/bin/sh

# Nome de DNS
    FQDN="chatwoot-minisite.$(hostname -f)"

    # Variaveis de ambiente
    # Apontar para URL do ChatWoot (https:// + (nome ou IP) + :porta-se-houver )
    CHATWOOT_BASE_URL="https://chatwoot.meusite.com.br";

    # Token para obter o codigo
    CHATWOOT_WEBSITE_TOKEN="_coloque_o_token_aqui_";

# Obter imagem atualizada
    docker pull "tmsoftbrasil/chatwoot-minisite:latest";

# Renovar/rodar:
    docker rm -f chatwoot-minisite 2>/dev/null;
    docker run \
        -d --restart=always \
        --name chatwoot-minisite \
        -h chatwoot-minisite.intranet.br \
        --network network_public \
        \
        --tmpfs /run:rw,noexec,nosuid,size=1m \
        --read-only \
        --cpus="1.0" --memory=512m --memory-swap=512m \
        \
        -e "CHATWOOT_BASE_URL=$CHATWOOT_BASE_URL" \
        -e "CHATWOOT_WEBSITE_TOKEN=$CHATWOOT_WEBSITE_TOKEN" \
        \
        -p 32080:80 \
        \
        --label "traefik.enable=true" \
        --label "traefik.enable=true" \
        --label "traefik.http.routers.chatwoot-minisite.rule=Host(\`$FQDN\`)" \
        --label "traefik.http.routers.chatwoot-minisite.entrypoints=web,websecure" \
        --label "traefik.http.routers.chatwoot-minisite.tls=true" \
        --label "traefik.http.routers.chatwoot-minisite.tls.certresolver=letsencrypt" \
        --label "traefik.http.services.chatwoot-minisite.loadbalancer.server.port=80" \
        \
        tmsoftbrasil/chatwoot-minisite:latest;

```

## Versão usando stack

```yaml
version: '3.8'

services:
  chatwoot-minisite:
    image: tmsoftbrasil/chatwoot-minisite:latest
    container_name: chatwoot-minisite
    hostname: chatwoot-minisite.intranet.br
    restart: always
    
    environment:
      - CHATWOOT_BASE_URL=https://chatwoot.meusite.com.br
      - CHATWOOT_WEBSITE_TOKEN=_coloque_o_token_aqui_
    
    ports:
      - "32080:80"
    
    networks:
      - network_public
    
    tmpfs:
      - /run:rw,noexec,nosuid,size=1m
    
    read_only: true
    
    deploy:
      resources:
        limits:
          cpus: '1.0'
          memory: 512M
        reservations:
          memory: 512M
    
    labels:
      - "traefik.enable=true"
      - "traefik.http.routers.chatwoot-minisite.rule=Host(`chatwoot-minisite.${HOSTNAME}`)"
      - "traefik.http.routers.chatwoot-minisite.entrypoints=web,websecure"
      - "traefik.http.routers.chatwoot-minisite.tls=true"
      - "traefik.http.routers.chatwoot-minisite.tls.certresolver=letsencrypt"
      - "traefik.http.services.chatwoot-minisite.loadbalancer.server.port=80"

networks:
  network_public:
    external: true
```


## Construir localmente

Na pasta com os arquivos desse projeto, execute:

```bash

# Construir nova imagem
docker build . -t chatwoot-minisite;

```

Troque "tmsoftbrasil/chatwoot-minisite" por "chatwoot-minisite" para usar sua imagem local.
