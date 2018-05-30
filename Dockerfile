FROM ruby:2.3.3
RUN apt-get update -qq && apt-get install -y build-essential libpq-dev nodejs
RUN mkdir /bacheca
WORKDIR /bacheca
COPY Gemfile /bacheca/Gemfile
COPY Gemfile.lock /myapp/Gemfile.lock
RUN bundle install
COPY . /bacheca
# Expose port 3000 to the Docker host, so we can access it 
# from the outside.
EXPOSE 9000

# The main command to run when the container starts. Also 
# tell the Rails dev server to bind to all interfaces by 
# default.
CMD ["bundle", "exec", "rails", "server", "-b", "0.0.0.0"]
