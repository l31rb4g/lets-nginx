# Let's NGINX!

NGINX capaz de gerar certificados HTTPs magicamente usando o Let's Encrypt.
Preparado para rodar em stack Docker Compose.


## Clonando como submodule
```
git submodule add git@gitlab.wbrain.me:magmalab/gitlab.git nginx
```
/!\ Atenção para o `nginx` no final do comando.


## Configuração do NGINX
Crie uma pasta chamada `nginx_conf` na raiz do docker-compose. Essa pasta deve ter 2 arquivos:
  - default.conf
  - https.conf

O arquivo `default.conf` deve conter apenas configurações para plain http. Esse arquivo sempre é carregado pelo NGINX. O arquivo `https.conf` deve conter todas as configurações de https.


## docker-compose.yml
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
./scripts/gerar_certificado default example.com admin@example.com
```
