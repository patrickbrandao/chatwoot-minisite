#!/bin/ash

# env defaults
    export CHATWOOT_BASE_URL=${CHATWOOT_BASE_URL:-https://chat.intranet.br};
    export CHATWOOT_WEBSITE_TOKEN=${CHATWOOT_WEBSITE_TOKEN:-missedwebsitetoken000000};

# lighttpd template replace
    mkdir -p /run/lighttpd;
    mkdir -p /run/htdocs;
    cp /opt/splash.png /run/htdocs/splash.png;
    cat /opt/index.html \
        | sed "s#CHATWOOT_BASE_URL#$CHATWOOT_BASE_URL#g" \
        | sed "s#CHATWOOT_WEBSITE_TOKEN#$CHATWOOT_WEBSITE_TOKEN#g" \
        > /run/htdocs/index.html;

# cmd
    EXEC_CMD=${@:-sleep 7666555444};
    FULL_CMD="exec $EXEC_CMD";
    echo "Start CMD: [$EXEC_CMD] [$FULL_CMD]";
    eval $FULL_CMD;
