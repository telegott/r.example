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
ENV RENV_CONFIG_REPOS_OVERRIDE='https://packagemanager.rstudio.com/all/__linux__/focal/latest'
WORKDIR app
COPY renv.lock renv.lock
RUN set -xe \
	&& R --vanilla -e 'renv::restore()'
COPY . .
