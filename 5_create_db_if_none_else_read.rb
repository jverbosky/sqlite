require 'sqlite3'

# Open a database
db = 

unless SQLite3::Database.open("test.db")
  SQLite3::Database.new "test.db"
end