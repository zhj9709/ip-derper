FROM alpine:latest
WORKDIR /app

ENV DERP_HOST=127.0.0.1 \
    DERP_CERT_DIR=/app/certs \
    DERP_ADDR=:443 \
    DERP_STUN=true \
    DERP_STUN_PORT=3478 \
    DERP_HTTP_PORT=80 \
    DERP_VERIFY_CLIENTS=false

COPY --chmod=755 build_cert.sh /app/
COPY --chmod=755 derper /app/derper

RUN apk add openssl \
    && /app/build_cert.sh $DERP_HOST $DERP_CERT_DIR /app/san.conf

CMD /app/derper --hostname=$DERP_HOST \
    --certdir=$DERP_CERT_DIR \
    --certmode=manual \
    --a=$DERP_ADDR \
    --stun=$DERP_STUN \
    --stun-port=$DERP_STUN_PORT \
    --http-port=$DERP_HTTP_PORT \
    --verify-clients=$DERP_VERIFY_CLIENTS
