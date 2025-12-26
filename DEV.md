
# Guia de desenvolvimento

Usei o arquivo Dockerfile.dev para criar a primeira versao e depois criei o Dockerfile minimalista.


## Rodar container Alpine para teste de construcao do container

```bash
    docker rm -f minisite-dev;
    docker run \
        -d --restart=always \
        --name minisite-dev -h minisite-dev.intranet.br \
        \
        -e TERM=xterm \
        -e SHELL=/bin/ash \
        -e TZ=America/Sao_Paulo \
        -e PS1='\u@\h:\w\$ ' \
        -e LANG=en_US.UTF-8 \
        -e LANGUAGE=en_US.UTF-8 \
        \
        -p 33080:80 \
        \
        --label "traefik.enable=true" \
        --label "traefik.enable=true" \
        --label "traefik.http.routers.minisite-dev.rule=Host(\`minisite-dev.$(hostname -f)\`)" \
        --label "traefik.http.routers.minisite-dev.entrypoints=web,websecure" \
        --label "traefik.http.routers.minisite-dev.tls=true" \
        --label "traefik.http.routers.minisite-dev.tls.certresolver=letsencrypt" \
        --label "traefik.http.services.minisite-dev.loadbalancer.server.port=80" \
        \
        alpine:3.23.0 tail -f /dev/null;

    # Entrar no container
    docker exec -it --user root minisite-dev ash;


```

