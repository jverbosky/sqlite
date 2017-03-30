require 'sqlite3'

# Open a database
db = SQLite3::Database.open("test.db")

# ------- insert data into a table --------------

# Works - ideally use column names
db.execute ("INSERT INTO students
            VALUES ('John', 'me@johndoe.com', 'B', 'http://blog.johndoe.com')")

# Works - ideally use an array to provide values
db.execute ("INSERT INTO students (name, email, grade, blog)
            VALUES ('Jen', 'me@jendoe.com', 'C', 'http://blog.jendoe.com')")

# Works using discrete SQL statements - ideally uses array to provide values
db.execute <<-SQL
  INSERT INTO students (name, email, grade, blog)
  VALUES ("Jim", "me@jimdoe.com", "D", "http://blog.jimdoe.com")
SQL

# Works, using raw values - ideally use variables
db.execute("INSERT INTO students (name, email, grade, blog)
            VALUES (?, ?, ?, ?)", ["Julie", "me@juliedoe.com", "E", "http://blog.juliedoe.com"])

# Works, using variables to provide values to insert
v_name = "Jeff"
v_email = "me@jeffdoe.com"
v_grade = "F"
v_blog = "http://blog.jeffdoe.com"

db.execute("INSERT INTO students (name, email, grade, blog)
            VALUES (?, ?, ?, ?)", [v_name, v_email, v_grade, v_blog])

# Execute inserts with parameter markers
data = ["Jill", "me@jilldoe.com", "G", "http://blog.jilldoe.com"]

v_name = data[0]
v_email = data[1]
v_grade = data[2]
v_blog = data[3]

db.execute("INSERT INTO students (name, email, grade, blog)
            VALUES (?, ?, ?, ?)", [v_name, v_email, v_grade, v_blog])

#-------- query table for data ---------------

db.execute( "select * from students" ) do |row|
  p row
end

# Use .execute2 to print the column names as the first fow
# db.execute2( "select * from students" ) do |row|
#   p row
# end