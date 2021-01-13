FROM alpine:3.11 as rootfs-stage
MAINTAINER thies88

# environment for our temp builder image
ENV REL=v3.12
ENV ARCH=x86_64
ENV MIRROR=http://dl-cdn.alpinelinux.org/alpine
#ENV MIRROR=http://nl.alpinelinux.org/alpine
ENV PACKAGES=alpine-baselayout,\
alpine-keys,\
apk-tools,\
busybox,\
libc-utils,\
xz

# install packages in temp builder image
RUN \
 apk add --no-cache \
	bash \
	curl \
	tzdata \
	xz

# fetch builder script
RUN \
 curl -o \
 /mkimage-alpine.bash -L \
	https://raw.githubusercontent.com/thies88/docker-alpine/master/builder/scripts/mkimage-alpine.bash && \
 chmod +x \
	/mkimage-alpine.bash && \
 ./mkimage-alpine.bash  && \
 mkdir /root-out && \
 tar xf \
	/rootfs.tar.xz -C \
	/root-out && \
 sed -i -e 's/^root::/root:!:/' /root-out/etc/shadow

# Runtime stage: Create actual base image from scratch
FROM scratch
COPY --from=rootfs-stage /root-out/ /
ARG BUILD_DATE
ARG VERSION
LABEL build_version="Alpine-baseimage-from-scratch version:- ${VERSION} Build-date:- ${BUILD_DATE}"
LABEL MAINTAINER="thies88, Thnx to: sparkyballs,TheLamer"

# set version for s6 overlay
ARG OVERLAY_VERSION="v2.1.0.2"
ARG OVERLAY_ARCH="amd64"

# environment variables
ENV PS1="$(whoami)@$(hostname):$(pwd)\\$ " \
HOME="/root" \
TERM="xterm"

#Add some repo's
RUN echo @testing http://dl-cdn.alpinelinux.org/alpine/edge/testing >> /etc/apk/repositories && \
 echo @edge http://dl-cdn.alpinelinux.org/alpine/edge/main >> /etc/apk/repositories && \
 echo @edgecom http://dl-cdn.alpinelinux.org/alpine/edge/community >> /etc/apk/repositories && \
 echo "**** install build packages ****" && \
 apk add --no-cache --virtual=build-dependencies \
	curl \
	tar && \
 echo "**** install runtime packages ****" && \
 apk add --no-cache \
	bash \
	ca-certificates \
	coreutils \
	procps \
	shadow \
	tzdata && \
 echo "**** add s6 overlay ****" && \
 curl -o \
 /tmp/s6-overlay.tar.gz -L \
	"https://github.com/just-containers/s6-overlay/releases/download/${OVERLAY_VERSION}/s6-overlay-${OVERLAY_ARCH}.tar.gz" && \
 tar xfz \
	/tmp/s6-overlay.tar.gz -C / && \
 echo "**** create abc user and make our folders ****" && \
 groupmod -g 1000 users && \
 useradd -u 911 -U -d /config -s /bin/false abc && \
 usermod -G users abc && \
 mkdir -p \
	/app \
	/config \
	/defaults && \
 mv /usr/bin/with-contenv /usr/bin/with-contenvb && \
 echo "**** cleanup ****" && \
 apk del --purge \
	build-dependencies && \
 rm -rf \
	/tmp/* /usr/share/terminfo/* && \
echo "save packages list to /package-list/package-list.txt to later extract this and add to github" && \
mkdir -p /package-list && \
	apk info -vv|sort > /package-list/package-list.txt

# add local files
COPY root/ /

ENTRYPOINT ["/init"]
