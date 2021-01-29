FROM alpine:3.9.6

RUN apk add --virtual .build-deps libgcc git build-base automake autoconf libtool mariadb-dev mariadb-connector-c-dev mariadb-connector-c mariadb-client --update \
  && git clone --branch 1.0.17 https://github.com/akopytov/sysbench.git \
  && cd sysbench \
  && ./autogen.sh \
  && ./configure --disable-shared --without-mysql\
  && make \
  && make install \
  && apk del .build-deps \
  && apk add bash mariadb-client

CMD ["sysbench"]
