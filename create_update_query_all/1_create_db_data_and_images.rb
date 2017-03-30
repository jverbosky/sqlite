require 'sqlite3'

# Create a database file
db = SQLite3::Database.new 'personal_details.db'

# Create a data table
details = db.execute <<-SQL
  create table details (
    id int primary key,
    name varchar(50),
    age int,
    num_1 int,
    num_2 int,
    num_3 int,
    quote varchar(255)
  );
SQL

# Create an image table
images = db.execute <<-SQL
  create table images (
    id int primary key,
    details_id int,  -- implied foreign key
    image blob
  );
SQL

# ---- Reference - foreign keys not supported ----

# # Create a data table
# details = db.execute <<-SQL
#   create table details (
#     id int primary key,
#     name varchar(50),
#     age int,
#     num_1 int,
#     num_2 int,
#     num_3 int,
#     quote varchar(255)
#   );
# SQL

# # # Enable foreign key support
# support = db.execute <<-SQL
#   pragma foreign_keys = ON;
# SQL

# # Create an image table
# images = db.execute <<-SQL
#   # pragma foreign_keys = ON;
#   create table images (
#     id int primary key,
#     details_id int foreign key(details_id) references details(id),
#     image blob
#   );
# SQL