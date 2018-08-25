# Slim (~ 190 MB) AlpineLinux with latest stable Oracle Java 10 Server JRE

FROM alpine:3.8

MAINTAINER Zoran Kikic <zoran@kikic.name>

ENV JAVA_SE_VERSION_MAJOR=10 \
    JAVA_SE_VERSION_MINOR=0 \
    JAVA_SE_VERSION_SECURITY=2 \
    JAVA_SE_VERSION_PATCH=13 \
    JAVA_DOWNLOAD_HASH=19aef61b38124481863b1413dce1855f \
    GLIBC_REPO=https://github.com/sgerrand/alpine-pkg-glibc \
    GLIBC_VERSION=2.28-r0

ENV JAVA_HOME /opt/jdk
ENV PATH ${JAVA_HOME}/bin:$PATH
ENV LANG C.UTF-8

RUN set -ex && \
    apk -U upgrade && \
    apk add libstdc++ curl ca-certificates bash java-cacerts && \
    for pkg in glibc-${GLIBC_VERSION} glibc-bin-${GLIBC_VERSION} glibc-i18n-${GLIBC_VERSION}; do curl -sSL ${GLIBC_REPO}/releases/download/${GLIBC_VERSION}/${pkg}.apk -o /tmp/${pkg}.apk; done && \
    apk add --allow-untrusted /tmp/*.apk && \
    rm -v /tmp/*.apk && \
    ( /usr/glibc-compat/bin/localedef --quiet --force --inputfile POSIX --charmap UTF-8 C.UTF-8 || true ) && \
    echo "export LANG=${LANG}" > /etc/profile.d/locale.sh && \
    /usr/glibc-compat/sbin/ldconfig /lib /usr/glibc-compat/lib

RUN wget "https://www.archlinux.org/packages/core/x86_64/zlib/download" -O /tmp/libz.tar.xz && \
    mkdir -p /tmp/libz && \
    tar -xf /tmp/libz.tar.xz -C /tmp/libz && \
    cp /tmp/libz/usr/lib/libz.so.1.2.11 /usr/glibc-compat/lib && \
    /usr/glibc-compat/sbin/ldconfig && \
    rm -rf /tmp/libz /tmp/libz.tar.xz

RUN mkdir /opt && \
    curl -jksSLH "Cookie: oraclelicense=accept-securebackup-cookie" -o /tmp/java.tar.gz \
    http://download.oracle.com/otn-pub/java/jdk/${JAVA_SE_VERSION_MAJOR}.${JAVA_SE_VERSION_MINOR}.${JAVA_SE_VERSION_SECURITY}+${JAVA_SE_VERSION_PATCH}/${JAVA_DOWNLOAD_HASH}/serverjre-${JAVA_SE_VERSION_MAJOR}.${JAVA_SE_VERSION_MINOR}.${JAVA_SE_VERSION_SECURITY}_linux-x64_bin.tar.gz && \
    JAVA_PACKAGE_SHA256=$(curl -sSL https://www.oracle.com/webfolder/s/digest/${JAVA_SE_VERSION_MAJOR}-${JAVA_SE_VERSION_MINOR}-${JAVA_SE_VERSION_SECURITY}checksum.html | grep -w "serverjre-${JAVA_SE_VERSION_MAJOR}.${JAVA_SE_VERSION_MINOR}.${JAVA_SE_VERSION_SECURITY}_linux-x64_bin\.tar\.gz" | grep -Eo '(sha256: )[^<]+' | cut -d: -f2 | xargs) && \
    echo "${JAVA_PACKAGE_SHA256}  /tmp/java.tar.gz" > /tmp/java.tar.gz.sha256 && \
    sha256sum -c /tmp/java.tar.gz.sha256 && \
    tar -xzf /tmp/java.tar.gz -C /opt && \
    ln -s ${JAVA_HOME}-${JAVA_SE_VERSION_MAJOR}.${JAVA_SE_VERSION_MINOR}.${JAVA_SE_VERSION_SECURITY} ${JAVA_HOME} && \
    sed -i s/#networkaddress.cache.ttl=-1/networkaddress.cache.ttl=10/ $JAVA_HOME/lib/security/default.policy && \
    apk del curl glibc-i18n && \
    rm -rf /tmp/* /var/cache/apk/* && \
    ln -sf /etc/ssl/certs/java/cacerts $JAVA_HOME/lib/security/cacerts && \
    echo 'hosts: files mdns4_minimal [NOTFOUND=return] dns mdns4' >> /etc/nsswitch.conf
