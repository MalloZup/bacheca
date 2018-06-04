FROM ruby:2.3.3
# rails  and whenever cron
RUN apt-get update -qq && apt-get install -y build-essential libpq-dev nodejs cron sqlite3 
RUN mkdir /bacheca
WORKDIR /bacheca
COPY Gemfile /bacheca/Gemfile
COPY Gemfile.lock /bacheca/Gemfile.lock
RUN bundle install
COPY . /bacheca
# create tables in db
RUN /bacheca/bin/rails db:migrate
# update the db regularly
RUN whenever --update-crontab
# expose rails
EXPOSE 3000
# initialize database and run server
CMD /bacheca/bin/rails db:seed && cron && bundle exec rails server -b 0.0.0.0
