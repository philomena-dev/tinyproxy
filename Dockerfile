# Based off https://github.com/tinyproxy/tinyproxy/issues/501#issuecomment-2256073227
FROM debian:trixie-slim AS build-stage

ENV DEBIAN_FRONTEND=noninteractive

RUN apt update \
    && apt --yes upgrade \
    && apt --yes install git build-essential automake

RUN adduser --shell /bin/false builder

USER builder

WORKDIR /home/builder

RUN git clone --depth 1 https://github.com/tinyproxy/tinyproxy.git --branch 1.11.3 tinyproxy \
    && cd /home/builder/tinyproxy \
    && ./autogen.sh \
    && LDFLAGS=-static ./configure \
      --prefix= \
      --disable-xtinyproxy \
      --disable-reverse \
      --disable-manpage_support \
    && make

FROM scratch AS run-stage

COPY --from=build-stage --chown=0 /home/builder/tinyproxy/src/tinyproxy /usr/local/bin/tinyproxy

USER 1000

EXPOSE 3128

CMD ["/usr/local/bin/tinyproxy", "-d", "-c", "/tinyproxy.conf"]
