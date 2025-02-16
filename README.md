# docker-recursive-bind
docker-recursive-bind provides a bind9 named setup for self hosted recursive dns
out of the box, clean and simple.

## installation
### 1. get the compose file
```
curl -LO \
    https://raw.githubusercontent.com/gottaeat/docker-recursive-bind/master/docker-compose.yml
```

### 2. compose up
```sh
docker compose up -d
```

### 3. test
```sh
dig example.com @127.0.0.1 -p53
```

extra configuration details can be added to `/data/extra.conf`.
