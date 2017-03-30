require 'sqlite3'

begin

    db = SQLite3::Database.open 'personal_details.db'
    db.results_as_hash = true

    # Example of getting column names
    d_columns = db.execute2('select * from details join images on details.id = images.details_id')[0]
    p d_columns  # ["id", "name", "age", "num_1", "num_2", "num_3", "quote", "id", "details_id", "image"]

    # Example of getting all data from both tables in personal_details.db
    # p db.execute('select * from details join images on details.id = images.details_id')

    # Prepare data for iteration
    d_query = db.prepare('select * from details join images on details.id = images.details_id')
    d_rows = d_query.execute

    # Output data to console and file to current directory for each row
    d_rows.each do |row|
      puts "Details ID: #{row['id']}"
      puts "Images ID: #{row['details_id']}"
      puts "Name: #{row['name']}"
      puts "Age: #{row['age']}"
      puts "Favorite number 1: #{row['num_1']}"
      puts "Favorite number 2: #{row['num_2']}"
      puts "Favorite number 3: #{row['num_3']}"
      puts "Quote: #{row['quote']}"
      image = row['image']
      f = File.new "#{row['id']}_#{row['name']}_output.png", "wb"
      f.write image
    end

    # Details ID: 1
    # Images ID: 1
    # Name: John
    # Age: 41
    # Favorite number 1: 7
    # Favorite number 2: 11
    # Favorite number 3: 3
    # Quote: Research is what I'm doing when I don't know what I'm doing.

rescue SQLite3::Exception, SystemCallError => e

    puts "Exception occurred"
    puts e

ensure
    f.close if f
    db.close if db
end