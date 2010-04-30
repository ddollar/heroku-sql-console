require File.dirname(__FILE__) + '/lib/heroku/commands/sql'

Heroku::Command::Help.group('SQL Console') do |group|
  group.command 'sql', 'launches a sql console for your app'
end
