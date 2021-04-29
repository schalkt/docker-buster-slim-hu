FROM debian:buster-slim

# environments
ENV TERM xterm
ENV DEBIAN_FRONTEND noninteractive

# timezone
ARG TIMEZONE=Europe/Budapest

# apt-get update and upgrade, set timezone and locale
RUN apt-get update \
    && apt-get upgrade -y --no-install-recommends \
    && apt-get install -y --no-install-recommends unzip gnupg curl wget telnet net-tools iputils-ping ca-certificates apt-transport-https htop locales tzdata \
    && rm -f /etc/localtime \
    && ln -snf /usr/share/zoneinfo/${TIMEZONE} /etc/localtime \
    && echo ${TIMEZONE} > /etc/timezone \
    && sed -i 's/# en_US.UTF-8 UTF-8/en_US.UTF-8 UTF-8/g' /etc/locale.gen \
    && sed -i 's/# hu_HU.UTF-8 UTF-8/hu_HU.UTF-8 UTF-8/g' /etc/locale.gen \
    && sed -i 's/# hu_HU ISO-8859-2/hu_HU ISO-8859-2/g' /etc/locale.gen \
    && dpkg-reconfigure -f noninteractive locales \
    && dpkg-reconfigure -f noninteractive tzdata

# environments
ENV LANG hu_HU.UTF-8
ENV LC_ALL hu_HU.UTF-8
ENV LANGUAGE hu_HU:en
