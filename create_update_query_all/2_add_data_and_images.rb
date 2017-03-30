require 'sqlite3'

# Collect file and data for database insertion
begin

  file_open = File.open './public/images/user_1.png' , 'rb'
  image = file_open.read
  blob = SQLite3::Blob.new image

  data = ["John", 41, 7, 11, 3, "Research is what I'm doing when I don't know what I'm doing."]

  v_name = data[0]
  v_age = data[1]
  v_num_1 = data[2]
  v_num_2 = data[3]
  v_num_3 = data[4]
  v_quote = data[5]

rescue SystemCallError => e

  puts e

ensure

  file_open.close if file_open

end

# Open database file and insert new row with data and file
begin

  # reference
  # db = SQLite3::Database.open 'details.db'
  # blob = SQLite3::Blob.new img
  # db.execute "insert into images values(1, ?)", blob

  db = SQLite3::Database.open 'personal_details.db'

  id_count = db.execute('select count(*) from details')
  v_id = id_count[0][0] + 1

  db.execute('insert into details (id, name, age, num_1, num_2, num_3, quote)
              values(?, ?, ?, ?, ?, ?, ?)', [v_id, v_name, v_age, v_num_1, v_num_2, v_num_3, v_quote])
  db.execute('insert into images (id, details_id, image)
              values(?, ?, ?)', [v_id, v_id, blob])

rescue SQLite3::Exception => e

  puts "Exception occurred"
  puts e

ensure

  db.close if db

end