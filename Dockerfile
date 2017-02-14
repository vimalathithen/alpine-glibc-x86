FROM alpine:3.5

ENV GLIB_VERSION=2.24-2
ENV GLIB_ARCH=i686

ADD ./ld.so.conf ./tmp/ld.so.conf

RUN apk add --update --no-cache bash wget tar ca-certificates libarchive-tools && \
    mkdir -p glibc-${GLIBC_VERSION} \
    /usr/glibc \
    /usr/share/locale && \
    ln -s /bin/bash /usr/bin/bash && \
    wget http://mirrors.kernel.org/archlinux/core/os/${GLIB_ARCH}/glibc-${GLIB_VERSION}-${GLIB_ARCH}.pkg.tar.xz -O glibc-${GLIB_VERSION}-${GLIB_ARCH}.pkg.tar.xz && \
    bsdtar xjf glibc-${GLIB_VERSION}-${GLIB_ARCH}.pkg.tar.xz -C glibc-${GLIBC_VERSION} && \
    cp tmp/ld.so.conf /etc/ld.so.conf && \
    cp -a glibc-${GLIBC_VERSION}/usr /usr/glibc/ && \
    glibc-${GLIBC_VERSION}/usr/bin/ldconfig /usr/glibc/usr /usr/glibc/usr/lib && \
    ln -s /usr/glibc/usr/lib/ld-linux.so.2 /lib/ld-linux.so.2  && \
    apk del wget tar ca-certificates libarchive-tools
