FROM ruby:2.6.0

# timezone
RUN cp /usr/share/zoneinfo/Asia/Tokyo /etc/localtime

EXPOSE 3000

RUN curl -sL https://deb.nodesource.com/setup_11.x | bash -
RUN curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add -
RUN echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list
RUN apt-get update && apt-get install -y --no-install-recommends \
    nodejs \
    yarn \
    mysql-client \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

RUN mkdir /app
WORKDIR /app

COPY Gemfile /app/Gemfile
COPY Gemfile.lock /app/Gemfile.lock
RUN bundle install
COPY . /app

#ENV BUNDLE_GEMFILE=/app/Gemfile \
#    BUNDLE_PATH=vendor/bundle

#RUN unset BUNDLE_APP_CONFIG \
#    && unset BUNDLE_BIN \
#    && unset BUNDLE_PATH \
#    && unset BUNDLE_GEMFILE \
#    && bundle install --path vendor/bundle

RUN yarn install

