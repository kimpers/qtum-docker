FROM alpine:latest

# Pass in url to latest qtum-0.X.Y-x86_64-linux-gnu.tar.gz
# which can be found at https://github.com/qtumproject/qtum/releases
ARG QTUM_URL

RUN addgroup -S qtum && adduser -S -g qtum qtum

RUN set -ex \
  && apk add --update \
  tar \
  curl \
  && cd /tmp \
  && curl --location ${QTUM_URL} -o /tmp/qtum.tar.gz \
	&& tar -xzvf qtum.tar.gz -C /usr/local --strip-components=1 --exclude=qtum-qt --exclude=test_qtum \
	&& rm -rf /tmp/*

VOLUME /qtum

# Use volume dir as data directory
ENTRYPOINT ["qtumd", "--datadir=", "/qtum"]
EXPOSE 3888 3889
