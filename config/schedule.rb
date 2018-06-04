every 15.minute do
  rake 'db:migrate'
  rake 'db:seed'
  command "date > /tmp/current_date_bacheca"
end
