FROM ruby:2.3.3
ENV APP bacheca
# rails  and whenever cron
RUN apt-get update -qq && apt-get install -y build-essential libpq-dev nodejs cron
RUN mkdir /$APP
WORKDIR /$APP
COPY Gemfile /$APP/Gemfile
COPY Gemfile.lock /$APP/Gemfile.lock
RUN bundle install
COPY . /$APP
RUN  /$APP/bin/rails db:migrate
RUN  /$APP/bin/rails db:seed
# update the db regularly
RUN service cron start
RUN whenever --update-crontab
# expose rails
EXPOSE 3000
# tell the Rails to bind to all interfaces by default.
CMD ["bundle", "exec", "rails", "server", "-b", "0.0.0.0"]
