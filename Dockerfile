FROM alpine:3.10 AS build
RUN apk add curl bzip2 bash gcc g++ libc-dev make cmake boost-dev boost-static zlib-dev
WORKDIR /workspace
RUN curl -OL https://github.com/Illumina/manta/releases/download/v1.6.0/manta-1.6.0.release_src.tar.bz2
RUN tar xjf manta-1.6.0.release_src.tar.bz2
WORKDIR /workspace/build
RUN cmake ../manta-1.6.0.release_src && make
RUN make install

FROM alpine:3.10
RUN apk add --no-cache bash zlib python2
COPY --from=build /usr/local /usr/local
