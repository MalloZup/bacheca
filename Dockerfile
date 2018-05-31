FROM ruby:2.3.3
ENV APP bacheca
RUN apt-get update -qq && apt-get install -y build-essential libpq-dev nodejs
RUN mkdir /$APP
WORKDIR /$APP
COPY Gemfile /$APP/Gemfile
COPY Gemfile.lock /$APP/Gemfile.lock
RUN bundle install
COPY . /$APP
RUN  /$APP/bin/rails db:migrate
RUN  /$APP/bin/rails db:seed

EXPOSE 3000

# The main command to run when the container starts. Also 
# tell the Rails dev server to bind to all interfaces by 
# default.
CMD ["bundle", "exec", "rails", "server", "-b", "0.0.0.0"]
