FROM alpine:3.19.1

RUN apk add nginx certbot bash

CMD python3 /nginx/etc/_run

