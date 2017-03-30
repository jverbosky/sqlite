require 'sqlite3'

begin

    db = SQLite3::Database.open 'blobs.db'
    data = db.get_first_value "SELECT Data FROM Images LIMIT 1"

    f = File.new "user_1_output.png", "wb"
    f.write data

rescue SQLite3::Exception, SystemCallError => e

    puts "Exception occurred"
    puts e

ensure
    f.close if f
    db.close if db
end