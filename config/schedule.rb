ENV.each { |k, v| env(k, v) }
every 15.minute do
  command 'cd /bacheca && rake db:migrate &> /tmp/bacheca_migrate_logs'
  command 'cd /bacheca && rake db:seed &> /tmp/bacheca_seed_log '
  command "date > /tmp/current_date_bacheca"
end
