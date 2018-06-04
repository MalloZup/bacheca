every 15.minute do
  rake 'db:migrate'
  rake 'db:seed'
end
