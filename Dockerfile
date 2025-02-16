FROM alpine:3.21.3 AS bind

RUN \
    apk update && apk upgrade && \
    apk --no-cache add iproute2 tcpdump bind bind-plugins && \
    rm -rfv \
        /etc/bind/* \
        /usr/lib/bind/filter-a.so \
        /var/bind/*

COPY ./static/bind/ /etc/bind/
COPY ./static/docker /static

RUN \
    rndc-confgen -a -c /etc/bind/rndc.key && \
    mkdir /data && touch /data/extra.conf && \
    chown -Rh named:named /etc/bind /var/bind /data && \
    find /etc/bind /var/bind /data -type d -exec chmod 0750 {} ';' && \
    find /etc/bind /var/bind /data -type f -exec chmod 0640 {} ';'

WORKDIR /etc/bind

EXPOSE 53/tcp
EXPOSE 53/udp

CMD ["/static/entrypoint.sh"]
