FROM golang:1.21-alpine

RUN mkdir /app
ADD . /app
WORKDIR /app
RUN CGO_ENABLED=0 go build -o readonly .

FROM alpine:latest AS setcap

COPY --from=0 /app/readonly /usr/local/bin/readonly
COPY --from=0 /app/readonly /usr/local/bin/readonly-setcap

RUN apk add libcap
RUN setcap CAP_NET_BIND_SERVICE=+ep /usr/local/bin/readonly-setcap

FROM gcr.io/distroless/base-debian11

COPY --from=setcap /usr/local/bin/readonly /usr/local/bin/
COPY --from=setcap /usr/local/bin/readonly-setcap /usr/local/bin/

USER 100

ENTRYPOINT ["/usr/local/bin/readonly"]