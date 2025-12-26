#========================================================================
#
# Container para Mini Site de Chat para ChatWoot
# - Alpine
# - Lighttpd
# - Splash page com chat incluido via javascript
#
#========================================================================

# Alpine 3.23.0 BUILDER
#------------------------------------------------------------------------

FROM alpine:3.23.0 AS builder

# Identifica bibliotecas necessárias
RUN ( \
    \
    apk update  || exit 11; \
    apk upgrade || exit 12; \
    apk add lighttpd || exit 21; \
    \
    mkdir -p /rootfs/usr/sbin \
        /rootfs/bin \
        /rootfs/usr/lib \
        /rootfs/usr/liblighttpd \
        /rootfs/lib \
        /rootfs/etc/lighttpd \
        /rootfs/opt \
        /rootfs/var/run; \
    \
    cp -rav /lib/ld-musl-*.so.1     /rootfs/lib/; \
    cp -rav /usr/lib/libcrypto.so*  /rootfs/usr/lib/; \
    cp -rav /usr/lib/libpcre2*      /rootfs/usr/lib/; \
    cp -rav /usr/lib/lighttpd/mod*  /rootfs/usr/lib/lighttpd/; \
    \
    cp -rav /usr/sbin/lighttpd      /rootfs/usr/sbin/; \
    cp -rav /bin/*                  /rootfs/bin/; \
    \
    cp -rav /etc/group   /rootfs/etc/; \
    cp -rav /etc/passwd  /rootfs/etc/; \
)

# Copiar arquivos e scripts do minisite
COPY static/   /rootfs/opt/

# Entrypoint executavel
RUN chmod +x /rootfs/opt/entrypoint.sh


# Alpine 3.23.0 FINAL
#------------------------------------------------------------------------

FROM scratch
COPY --from=builder /rootfs /

# Variaveis de ambiente padrao
ENV \
    MAINTAINER="Patrick Brandao <patrickbrandao@gmail.com>" \
    TERM=xterm \
    SHELL=/bin/ash \
    TZ=America/Sao_Paulo \
    PS1='\u@\h:\w\$ ' \
    LANG=en_US.UTF-8 \
    LANGUAGE=en_US.UTF-8

EXPOSE 80
ENTRYPOINT ["/opt/entrypoint.sh"]
CMD ["/usr/sbin/lighttpd", "-D", "-f", "/opt/lighttpd.conf"]
