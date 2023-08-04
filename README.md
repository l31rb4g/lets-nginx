 # Let's NGINX!

<img src="lets-nginx.png" width="32px">
Let's NGINX é um container docker (compose) que roda um NGINX capaz de gerar certificados HTTPS usando o Let's Encrypt.


## Estrutura de arquivos
```
/
| app/                  - aplicação
| nginx/                - esse repositório clonado como submódulo
| nginx_conf/           - pasta com os configs do NGINX (veja o exemplo)
| docker-compose.yml    - yaml do docker compose
```


## Clonando como submodule
Para utilizar como submódulo de um projeto, rode o seguinte comando na raiz:
```
git submodule add git@gitlab.wbrain.me:magmalab/lets-nginx.git nginx
```
⚠ Atenção para o `nginx` no final do comando.


## Configuração do NGINX
Crie uma pasta chamada `nginx_conf` na raiz do projeto Essa pasta deve ter 2 arquivos:
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
  dockerfile: dockerfile-nginx
volumes:
  - ./nginx:/nginx
  - ./nginx_conf:/nginx_conf
```


## Como gerar/renovar o certificado
Utilize o script `scripts/gerar_certificado` da seguinte maneira:
```
./scripts/gerar_certificado [nome] [domínio] [email]
```

Exemplo:
```
./scripts/gerar_certificado default example.com admin@example.com
```

Quando você rodar esse comando, o certbot tentará gerar o certificado para o domínio informado. Se o certificado for gerado com sucesso, o NGINX carregará o arquivo `https.conf` e será reiniciado sozinho.


Os certificados serão gerados na pasta `certs/`
