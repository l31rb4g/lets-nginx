# Let's NGINX!

NGINX capaz de gerar certificados HTTPs magicamente usando o Let's Encrypt.
Preparado para rodar em stack Docker Compose.

## Clonando como submodule
```
git submodule add git@gitlab.wbrain.me:magmalab/gitlab.git nginx
```
/!\ Atenção para o `nginx` no final do comando.


## docker-compose
```
nginx:
restart: always
build:
  context: ./nginx
  dockerfile: dockerfile-nginx
volumes:
  - ./nginx:/nginx
  - ./nginx_conf:/nginx_conf
```

## Como gerar/renovar o certificado
```
./scripts/gerar_certificado example.com admin@example.com
```
