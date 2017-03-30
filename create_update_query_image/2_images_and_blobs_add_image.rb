require 'sqlite3'

begin

    fin = File.open "./public/images/user_1.png" , "rb"
    img = fin.read

rescue SystemCallError => e
    puts e
ensure
    fin.close if fin
end

begin

    db = SQLite3::Database.open 'blobs.db'
    blob = SQLite3::Blob.new img
    db.execute "insert into images values(1, ?)", blob

rescue SQLite3::Exception => e

    puts "Exception occurred"
    puts e

ensure
    db.close if db
end