# note - images span user_1.png - user_8.png
# so can run this twice to build DB w/duplicate user records if desired

require 'sqlite3'
require 'base64'

begin

  # user data sets
  user_1 = ["John", 41, 7, 11, 3, "Research is what I'm doing when I don't know what I'm doing."]
  user_2 = ["Jane", 51, 1, 2, 3, "Life is 10% what happens to you and 90% how you react to it."]
  user_3 = ["Jim", 61, 10, 20, 30, "In order to succeed, we must first believe that we can."]
  user_4 = ["Jill", 71, 11, 22, 33, "It does not matter how slowly you go as long as you do not stop"]

  # aggregate user data into multi-dimensional array for iteration
  users = []
  users.push(user_1, user_2, user_3, user_4)

  # open database for updating
  db = SQLite3::Database.open 'personal_details.db'

  # determine current max index (id) in details table
  db.results_as_hash
  max_id = db.execute('select max("id") from details')[0][0]

  # set index variable based on current max index value
  max_id == nil ? v_id = 1 : v_id = max_id + 1

  # iterate through multi-dimensional users array for data
  users.each do |user|

    # initialize variables for SQL insert statements
    v_name = user[0]
    v_age = user[1]
    v_num_1 = user[2]
    v_num_2 = user[3]
    v_num_3 = user[4]
    v_quote = user[5]

    # prepare image for database insertion
    # file_open = File.open "./public/images/user_#{v_id}.png" , 'rb'
    # image = file_open.read
    file_open = File.binread("./public/images/user_#{v_id}.png")
    image = Base64.encode64(file_open)
    blob = SQLite3::Blob.new image

    # insert user data into details table
    db.execute('insert into details (id, name, age, num_1, num_2, num_3, quote)
                values(?, ?, ?, ?, ?, ?, ?)', [v_id, v_name, v_age, v_num_1, v_num_2, v_num_3, v_quote])

    # insert user image into images table
    db.execute('insert into images (id, details_id, image)
                values(?, ?, ?)', [v_id, v_id, blob])

    # increment index value for next iteration
    v_id += 1

  end

rescue SQLite3::Exception => e

  puts "Exception occurred"
  puts e

ensure

  db.close if db

end