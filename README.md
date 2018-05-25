# Bacheca

## Setup

1) Configuration
Add the jenkins credentials you will need to setup

```bash
touch db/login_jenkins.yml
```
here is how it should like the login_jenkins.yml

```yml
server_url: '0.0.0.0'
username: 'somename', 
password: 'secret password'
```

the jobs_jenkins.yml should contain a list of jobs.
```yml
jenkins_jobs: ["manager-3.1-cucumber", "manager-3.0-cucumber"]
```

2) Feed database
WIP

3) Visualize it
WIP
