# Use this file to easily define all of your cron jobs.
#
# It's helpful, but not entirely necessary to understand cron before proceeding.
# http://en.wikipedia.org/wiki/Cron

set :output, File.join(Whenever.path, "log", "cron.log")

every 1.day, :at => '9:30 am' do
  runner "Incedent.notify_workers"
end

every 1.hour do
  runner "Incedent.autoclose!"
end