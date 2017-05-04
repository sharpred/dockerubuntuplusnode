FROM ubuntu
# Replace shell with bash so we can source files
RUN rm /bin/sh && ln -s /bin/bash /bin/sh
# Set debconf to run non-interactively
RUN echo 'debconf debconf/frontend select Noninteractive' | debconf-set-selections
# install prereqs
RUN apt-get update && apt-get install -y \
    -q --no-install-recommends \
    nodejs \
    npm \
    git \
    ssh \
    ruby \
    ruby-dev \
    gem \
    curl \
    build-essential \
    libssl-dev \
    mysql* \
    && rm -rf /var/lib/apt/lists/*
# nvm
ENV NVM_DIR /usr/local/nvm
ENV NODE_VERSION v6.10.3

# Install nvm with node and npm
RUN curl https://raw.githubusercontent.com/creationix/nvm/v0.20.0/install.sh | bash \
    && source $NVM_DIR/nvm.sh \
    && nvm install $NODE_VERSION \
    && nvm alias default $NODE_VERSION \
    && nvm use default

ENV NODE_PATH $NVM_DIR/v$NODE_VERSION/lib/node_modules
ENV PATH $NVM_DIR/v$NODE_VERSION/bin:$PATH