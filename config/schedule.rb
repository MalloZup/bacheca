# Use this file to easily define all of your cron jobs.
#
# It's helpful, but not entirely necessary to understand cron before proceeding.
# http://en.wikipedia.org/wiki/Cron

every 30.minute do
   rake "db:migrate"
   rake "db:seed"
   command '/usr/bin/echo updated_db_!!'
end
