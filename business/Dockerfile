ARG RUBY_VERSION=3.3.6

FROM ruby:${RUBY_VERSION}-bullseye

ARG NODE_VERSION=22

# Install dependencies
RUN apt-get clean all && \
    apt-get update -qq && \
    apt-get install -y build-essential \
    libssl-dev \
    libreadline-dev \
    zlib1g-dev \
    tzdata \
    libffi-dev \
    postgresql \
    curl \
    git \
    libpq-dev \
    libvips \
    pkg-config \
    build-essential \
    gnupg2 \
    apt-utils \
    libcurl3-dev \
    cmake \
    openssl \
    file \
    nano

# Add permissions for the user
RUN mkdir /app
#&& chown -R dockeruser:dockergroup /app

# Set the working directory
WORKDIR /app

# Copy the Gemfile and Gemfile.lock
COPY Gemfile /app/Gemfile
COPY Gemfile.lock /app/Gemfile.lock

# Install packages needed to build gems
RUN gem install bundler && bundle install

# Install NodeJS and yarn
RUN curl -fsSL https://deb.nodesource.com/setup_${NODE_VERSION}.x | bash - && \
    apt-get install -y nodejs

RUN corepack enable

COPY package.json /app/package.json
COPY package-lock.json /app/package-lock.json
RUN yarn install

# Copy application code
COPY . /app

# https://github.com/Shopify/bootsnap#precompilation
RUN bundle exec bootsnap precompile --gemfile app/ lib/

# Precompiling assets without requiring secret RAILS_MASTER_KEY
# RUN SECRET_KEY_BASE_DUMMY=1 bundle exec rails assets:precompile

# Entrypoint prepares the database.
ENTRYPOINT ["/app/bin/docker-entrypoint"]

# Start the server by default, this can be overwritten at runtime
EXPOSE 5000

# Command to run the server
CMD ["rails", "server", "-b", "0.0.0.0", "-p", "5000"]
