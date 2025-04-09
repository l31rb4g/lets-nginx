 # Let's NGINX!

<img src="lets-nginx.png" width="32px">
Let's NGINX é um container docker (compose) que roda um NGINX capaz de gerar certificados HTTPS usando o Let's Encrypt.


## Estrutura de arquivos
```
/
| lets/                 - diretório de configuração
      | certs/          - diretório com as configurações de certificado
      | conf/           - diretório com as configurações do NGINX
| nginx/                - esse repositório clonado como submódulo
| docker-compose.yml    - yaml do docker compose
```


## Clonando como submodule
Para utilizar como submódulo de um projeto, rode o seguinte comando na raiz:
```
git submodule add https://github.com/l31rb4g/lets-nginx.git nginx
```
⚠ Atenção para o `nginx` no final do comando.


## Configuração do NGINX
Crie um diretório chamada `lets` na raiz do projeto. Esse diretório deve ter 2 arquivos:
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
        - ./lets:/lets
        - ./nginx:/nginx
        - ./nginx/etc/letsencrypt:/etc/letsencrypt
```


## Exemplo de arquivo de certificado
```
example.com
sub.example.com

user@example.com
```


## Exemplo de arquivo default.conf
```
server {
    listen       80;
    server_name  default;

    location / {
        proxy_pass http://app:8000;
    }
}
```


## Exemplo de arquivo https.conf
```
server {
    listen       443 ssl;
    server_name  default;

    ssl_certificate     /certs/example/fullchain.pem;
    ssl_certificate_key /certs/example/privkey.pem;

    location / {
        proxy_pass http://app:8000;
    }
}
```

