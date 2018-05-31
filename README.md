# Bacheca

![bacheca](.github_style/demo.png)

##### You can also select interactively via browser only specific jobs and axes will scale depending on data.
##### The jobs of which you pick the tests are configurable via yml file!
![bacheca1](.github_style/demo2.png)

Bacheca will help to analyze in deep tests.
At moment is under development, feel free to contribute at any time.

Feel free to take a look on milestones to see what is planed https://github.com/MalloZup/bacheca/milestones

#### Prerequisites:

Your Jenkins jobs need to expoert tests_results in junit format, otherwise bacheca cannot fetch results.

## Docker setups.

You can have a look at the Dockerfile and have bacheca running in container!
```bash

docker build -t bacheca .
docker run -it -p 9000:3000 bacheca
```
Then visit `http://localhost:9000/` ! up an runnning!

### Manual Setup for devel version ( only avaible currently)

0) you need to have installed rails.

```ruby
gem install rails
```

1) Configuration
Add the jenkins credentials you will need to setup

```bash
touch config/credentials_jenkins.yml
```
here is how it should like the `credentials_jenkins.yml`

As password you can use a jenkins token.
```yml
server_url: '0.0.0.0'
username: 'somename', 
password: 'secret password'
```

the `config/jobs_jenkins.yml` should contain a list of jobs.
```yml
jenkins_jobs: ["manager-3.1-cucumber", "manager-3.0-cucumber"]
```
Ensure that your jenkins user has access to the jobs

2) Feed and create database schemas with

For the first initialization, you can run manually:
```ruby
rake db:migrate
rake db:seed
```

This project is using whenever gem, so you can activate the service for getting new data every hour with:

```whenever --update-crontab```

3) run it!
```ruby
cd bacheca
rails server
```
