 # Let's NGINX!

<img src="lets-nginx.png" width="32px">
Let's NGINX é um container docker (compose) que roda um NGINX capaz de gerar certificados HTTPS usando o Let's Encrypt.


## Estrutura de arquivos
```
/
| app/                  - aplicação
| nginx/                - esse repositório clonado como submódulo
| nginx_conf/           - pasta com os configs do NGINX (veja nginx_conf.exemplo)
| docker-compose.yml    - yaml do docker compose
```


## Clonando como submodule
Para utilizar como submódulo de um projeto, rode o seguinte comando na raiz:
```
git submodule add https://github.com/l31rb4g/lets-nginx.git nginx
```
⚠ Atenção para o `nginx` no final do comando.


## Configuração do NGINX
Crie uma pasta chamada `nginx_conf` na raiz do projeto (veja nginx_conf.exemplo). Essa pasta deve ter 2 arquivos:
  - default.conf

    Esse arquivo deve conter apenas configurações para plain http. Esse arquivo sempre é carregado pelo NGINX.
<br>

  - https.conf

    Esse arquivo deve conter todas as configurações de https. Esse arquivo só será carregado se todos os certificados já tiverem sido gerados. Se os certificados não forem encontrados, o NGINX não carregará o https.conf e servirá apenas plain http (default.conf).


## docker-compose.yml
Adicione o seguinte trecho ao seu `docker-compose.yml`
```
nginx:
restart: always
build:
  context: ./nginx
volumes:
  - ./nginx:/nginx
  - ./nginx/etc/letsencrypt:/etc/letsencrypt
  - ./nginx_conf:/nginx_conf
```


## Como gerar um certificado
Utilize o script `lets-nginx` da seguinte maneira:
```
./nginx/lets-nginx [nome] [domínio] [email]
```

Exemplo:
```
./nginx/lets-nginx default example.com admin@example.com
```

Quando você rodar esse comando, o certbot tentará gerar o certificado para o domínio informado. Se o certificado for gerado com sucesso, o NGINX carregará o arquivo `https.conf`. Ao final do processo o NGINX reiniciará sozinho.


## Exemplo de arquivo default.conf
```
server {
    listen       80;
    server_name  default;

    location / {
        proxy_pass http://nginx:8000;
    }
}
```


## Exemplo de arquivo https.conf
```
server {
    listen       443 ssl;
    server_name  default;

    ssl_certificate     /nginx/certs/backend/fullchain.pem;
    ssl_certificate_key /nginx/certs/backend/privkey.pem;

    location / {
        proxy_pass http://nginx:8000;
    }
```

