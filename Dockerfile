FROM golang:1.12.5-stretch as builder

COPY . /app

RUN cd /app && make build

FROM gcr.io/distroless/base as runnable

ENV TENERIFE_HOST 0.0.0.0
ENV TENERIFE_PORT 80
ENV TENERIFE_DIAGNOSTICS_PORT 9090

EXPOSE $TENERIFE_PORT $TENERIFE_DIAGNOSTICS_PORT

COPY --from=builder /app/bin/tenerife /bin/tenerife

CMD ["/bin/tenerife"]