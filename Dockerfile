FROM ruby:2.5.0

ENV BUNDLER_VERSION=2.1.4

RUN apt-get update -qq && apt-get install -y build-essential libpq-dev nodejs

RUN mkdir /code
WORKDIR /code
COPY Gemfile /code/Gemfile
COPY Gemfile.lock /code/Gemfile.lock

RUN gem update --system && \
    gem install bundler:2.1.4 && \
    bundle install

COPY . /code
COPY entrypoint.sh /usr/bin/
RUN chmod +x /usr/bin/entrypoint.sh
ENTRYPOINT ["entrypoint.sh"]

EXPOSE 3000

CMD ["rails", "server", "-b", "0.0.0.0"]
