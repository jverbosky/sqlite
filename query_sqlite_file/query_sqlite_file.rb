require "sqlite3"

begin

  db = SQLite3::Database.open("ksw_process.db")

  query = db.prepare "pragma table_info(process)"  # list all column names in process table
  # query = db.prepare "select * from process order by name limit 50"
  rows = query.execute

  rows.each do |row|
    puts row
    # puts "Process name: #{row[1]}, description: #{row[5]}"
  end

rescue SQLite3::Exception => e

    puts "Exception occurred"
    puts e

ensure

  query.close if query
  db.close if db

end