# SQL console like for your heroku app's database
class Heroku::Command::Sql < Heroku::Command::Base

  # sql
  #
  # access the sql console for your datasabe
  #
  def index
    database_url = heroku.config_vars(app)['DATABASE_URL']

    sqlconsole_history_read(app)

    display "SQL console for #{app}.#{heroku.host}"
    while sql = Readline.readline('SQL> ')
      unless sql.nil? || sql.strip.empty?
        sqlconsole_history_add(app, sql)
        break if sql.downcase.strip == 'exit'
        display execute_sql(database_url, sql)
      end
    end
  end

  private
  def resource
    @resource ||= RestClient::Resource.new("https://sql-console.heroku.com")
  end

  def execute_sql(database_url, sql)
    resource["/query"].post(:database_url => database_url, :sql => sql)
  rescue RestClient::InternalServerError
    display "An error has occurred."
  end

  def sqlconsole_history_dir
    FileUtils.mkdir_p(path = "#{home_directory}/.heroku/sqlconsole_history")
    path
  end

  def sqlconsole_history_file(app)
    "#{sqlconsole_history_dir}/#{app}"
  end

  def sqlconsole_history_read(app)
    history = File.read(sqlconsole_history_file(app)).split("\n")
    if history.size > 50
      history = history[(history.size - 51),(history.size - 1)]
      File.open(sqlconsole_history_file(app), "w") { |f| f.puts history.join("\n") }
    end
    history.each { |cmd| Readline::HISTORY.push(cmd) }
  rescue Errno::ENOENT
  end

  def sqlconsole_history_add(app, sql)
    Readline::HISTORY.push(sql)
    File.open(sqlconsole_history_file(app), "a") { |f| f.puts sql + "\n" }
  end

end
