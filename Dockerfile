FROM rocker/r-ver:4.1.2 AS base
RUN set -xe \
    && apt-get update \
    && apt-get install -y \
        make \
        git-core \
        libssl-dev \
        libcurl4-openssl-dev \
        libgit2-dev \
        libicu-dev \
        libxml2-dev \
    && rm -rf /var/lib/apt/lists/* \
    && R -e 'install.packages("renv")'
WORKDIR app

FROM base AS with-packages
COPY renv.lock renv.lock
RUN set -xe \
	&& R -e 'renv::restore()'
COPY . .
