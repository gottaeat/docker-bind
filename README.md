# docker-bind
docker-bind provides a bind9 named setup on an alpine image for self hosted
dns, clean and simple.

it can be set up to do recursion.

## installation
### 1. get the compose file, set bind mount dir
```sh
curl -LO \
    https://raw.githubusercontent.com/gottaeat/docker-recursive-bind/master/\
docker-compose.yml

mkdir data/
```

### 2. set up `extra.conf`
#### 2.1. configure for recursive
```sh
cat << EOF > ./data/extra.conf
zone "." {
    type hint;
    file "/etc/bind/root-nov6";
};
EOF
```

#### 2.2. configure for forwarding
CF nameservers are used for an example, can be swapped out.
```sh
cat << EOF > ./data/extra.conf
zone "." {
    type forward;
    forwarders { 1.1.1.1; 1.0.0.1; };
};
EOF
```

extra configuration details can also be added to `./data/extra.conf`.

### 3. compose up
```sh
docker compose up -d
```

### 4. test
```sh
dig example.com @127.0.0.1 -p53
```
