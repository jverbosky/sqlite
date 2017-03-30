require 'sqlite3'

# Create a database file
db = SQLite3::Database.new "blobs.db"

# Create a table
rows = db.execute <<-SQL
  create table images (
    id int primary key,
    data blob
  );
SQL