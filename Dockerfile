FROM ruby:3.3-slim

RUN apt-get update -qq && apt-get install -y \
  build-essential \
  libsqlite3-dev \
  libyaml-dev \
  nodejs \
  npm \
  curl \
  git \
  && rm -rf /var/lib/apt/lists/*

WORKDIR /app

COPY app/Gemfile app/Gemfile.lock* ./

RUN bundle install --without development test \
  && bundle exec bootsnap precompile --gemfile

COPY app/ .

RUN bundle exec bootsnap precompile app/ lib/

RUN mkdir -p tmp/pids tmp/sockets log public/assets /data

COPY entrypoint.sh /usr/bin/entrypoint.sh
RUN chmod +x /usr/bin/entrypoint.sh

EXPOSE 3000

ENTRYPOINT ["entrypoint.sh"]
CMD ["bundle", "exec", "puma", "-C", "config/puma.rb"]
