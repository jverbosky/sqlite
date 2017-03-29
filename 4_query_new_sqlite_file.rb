require "sqlite3"

# begin

  db = SQLite3::Database.open("test.db")

# ---- Output info for each column in table ----

  p db.execute "pragma table_info(students)"

# [[0, "name", "varchar(50)", 0, nil, 0], [1, "email", ...

# ---- Output array of table rows (array of arrays) ----

  p db.execute "select * from students limit 2"

# [["Jane", "me@janedoe.com", "A", "http://blog.janedoe.com"], ["John", ...

# ---- Iterate through array of arrays and output each table row array ----

  query = db.prepare "select * from students limit 2"
  rows = query.execute

  rows.each do |row|
    p row
  end

# ["Jane", "me@janedoe.com", "A", "http://blog.janedoe.com"]
# ["John", "me@johndoe.com", "B", "http://blog.johndoe.com"]

# ---- Iterate through array of arrays and output interpolated index values

  query = db.prepare "select * from students limit 2"
  rows = query.execute

  rows.each do |row|
    puts "Name: #{row[0]}, email: #{row[1]}"
  end

# Name: Jane, email: me@janedoe.com
# Name: John, email: me@johndoe.com

# ---- Iterate through database items via column names instead of array index values

  db.results_as_hash = true

  query = db.prepare "select * from students limit 2"
  rows = query.execute

  rows.each do |row|
    puts "Name: #{row['name']}, email: #{row['email']}"
  end

# Name: Jane, email: me@janedoe.com
# Name: John, email: me@johndoe.com

# ---- List column names (array) and table rows (hashes) ----

  db.execute2( "select * from students limit 2" ) do |row|
    p row
  end

# ["name", "email", "grade", "blog"]
# {"name"=>"Jane", "email"=>"me@janedoe.com", "grade"=>"A", "blog"=>"http://blog.janedoe.com"}
# {"name"=>"John", "email"=>"me@johndoe.com", "grade"=>"B", "blog"=>"http://blog.johndoe.com"}

# ---- List column names in array ----

  db.execute2( "select * from students limit 0" ) { |columns| p columns }

# ["name", "email", "grade", "blog"]

# ----------------------------------------

# rescue SQLite3::Exception => e

#     puts "Exception occurred"
#     puts e

# ensure

#   # query.close if query
#   db.close if db

# end