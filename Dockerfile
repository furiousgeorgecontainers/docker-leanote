FROM alpine:3.3

ARG BUILD_DATE
ARG VERSION
LABEL build_date="${BUILD_DATE}"
LABEL version="${VERSION}"

ENV GOPATH /app
RUN apk --update add curl && \
    curl -L https://sourceforge.net/projects/leanote-bin/files/2.6.1/leanote-linux-amd64-v2.6.1.bin.tar.gz/download >> \
    /tmp/leanote.tar.gz && \
    apk del --purge curl && \
    rm -rf /var/cache/apk/*

RUN mkdir -p /src  /app/src/github.com/leanote \
    && tar -xzvf /tmp/leanote.tar.gz -C /src \
    && ln -s /src/leanote/bin/src/github.com/revel /app/src/github.com/revel \
    && ln -s /src/leanote /app/src/github.com/leanote/leanote \
    && ln -s /src/leanote/bin/leanote-linux-amd64 /app/leanote-linux-amd64 \
    && rm /tmp/leanote.tar.gz

EXPOSE 9000
WORKDIR  /app
CMD ["/app/leanote-linux-amd64","-importPath","github.com/leanote/leanote"]

