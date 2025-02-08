ARG RUBY_VERSION=3.0.2

FROM ruby:${RUBY_VERSION}-bullseye

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

# Copy application code
COPY . /app

# Precompile assets (optional, if using Rails with assets)
# RUN bundle exec rake assets:precompile

# Entrypoint prepares the database.
ENTRYPOINT ["/app/bin/docker-entrypoint"]

# Start the server by default, this can be overwritten at runtime
EXPOSE 4000

# Command to run the server
CMD ["rails", "server", "-b", "0.0.0.0", "-p", "4000"]
