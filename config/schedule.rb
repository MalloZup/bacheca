ENV.each { |k, v| env(k, v) }
every 15.minute do
  command '/bacheca/bin/rails db:migrate &> /tmp/bacheca_migrate_logs'
  command '/bacheca/bin/rails db:seed &> /tmp/bacheca_seed_log '
  command "date > /tmp/current_date_bacheca"
end
