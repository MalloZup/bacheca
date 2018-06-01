every 30.minute do
  rake 'db:migrate'
  rake 'db:seed'
end
