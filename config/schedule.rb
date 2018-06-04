every 15.minute do
  command 'cd /bacheca && rake db:migrate'
  command 'cd /bacheca && rake db:seed'
  command "date > /tmp/current_date_bacheca"
end
