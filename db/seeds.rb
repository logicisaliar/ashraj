require 'csv'


puts "Creating States - 1"
csv_text = File.read(Rails.root.join('lib', 'seeds', "state.csv"))
csv = CSV.parse(csv_text, :headers => true, :encoding => 'ISO-8859-1')
csv.each do |row|
  t = State.new
  t.name = row['name']
  t.code = row['code']
  t.save
end
puts "States created"


puts "Creating Cities - 2"
csv_text = File.read(Rails.root.join('lib', 'seeds', "city.csv"))
csv = CSV.parse(csv_text, :headers => true, :encoding => 'ISO-8859-1')
csv.each do |row|
  t = City.new
  t.name = row['name']
  t.state_id = row['state_id']
  t.save
end
puts "Cities created"

puts "Creating Pincodes - 3"
csv_text = File.read(Rails.root.join('lib', 'seeds', "pincode.csv"))
csv = CSV.parse(csv_text, :headers => true, :encoding => 'ISO-8859-1')
count = 0
csv.each do |row|
  t = Pincode.new
  t.pin = row['pin']
  t.city_id = row['city_id']
  if (count > 100)
  end
  t.save
  count += 1
end
puts "Pincodes created"

puts "Creating Harmonics - 4"
csv_text = File.read(Rails.root.join('lib', 'seeds', "harmonic.csv"))
csv = CSV.parse(csv_text, :headers => true, :encoding => 'ISO-8859-1')
csv.each do |row|
  t = Harmonic.new
  t.hsn = row['hsn']
  t.save
end
puts "Harmonics created"

puts "Creating Products - 5"
csv_text = File.read(Rails.root.join('lib', 'seeds', "product.csv"))
csv = CSV.parse(csv_text, :headers => true, :encoding => 'ISO-8859-1')
csv.each do |row|
  t = Product.new
  t.name = row['name']
  t.discount = row['discount']
  t.description = row['description']
  t.type_id = row['type_id']
  t.mrp = row['mrp']
  t.unit = row['unit']
  t.gst = row['gst']
  t.harmonic_id = row['harmonic_id']
  t.save
end
puts "Products created"


puts "Creating Uses - 6"
csv_text = File.read(Rails.root.join('lib', 'seeds', "use.csv"))
csv = CSV.parse(csv_text, :headers => true, :encoding => 'ISO-8859-1')
csv.each do |row|
  t = Use.new
  t.name = row['name']
  t.save
end
puts "Uses created"

puts "Creating Types - 7"
csv_text = File.read(Rails.root.join('lib', 'seeds', "type.csv"))
csv = CSV.parse(csv_text, :headers => true, :encoding => 'ISO-8859-1')
csv.each do |row|
  t = Type.new
  t.name = row['name']
  t.save
end
puts "Types created"

puts "Creating Categories - 8"
csv_text = File.read(Rails.root.join('lib', 'seeds', "category.csv"))
csv = CSV.parse(csv_text, :headers => true, :encoding => 'ISO-8859-1')
csv.each do |row|
  t = Category.new
  t.name = row['name']
  t.save
end
puts "Categories created"

puts "Creating Packings - 9"
csv_text = File.read(Rails.root.join('lib', 'seeds', "packing.csv"))
csv = CSV.parse(csv_text, :headers => true, :encoding => 'ISO-8859-1')
csv.each do |row|
  t = Packing.new
  t.rebate = row['rebate']
  t.pack_size = row['pack_size']
  t.sample = row['sample']
  t.save
end
puts "Packings created"

puts "Creating Companies - 10"
csv_text = File.read(Rails.root.join('lib', 'seeds', "company.csv"))
csv = CSV.parse(csv_text, :headers => true, :encoding => 'ISO-8859-1')
csv.each do |row|
  t = Company.new
  t.name = row['name']
  t.kind = row['kind']
  t.parent_id = row['parent_id']
  t.days = row['days']
  t.balance = row['balance']
  t.open_balance = row['open_balance']
  t.spl_instructions = row['spl_instructions']
  t.save
end
puts "Companies created"

puts "Creating Addresses - 11"
csv_text = File.read(Rails.root.join('lib', 'seeds', "address.csv"))
csv = CSV.parse(csv_text, :headers => true, :encoding => 'ISO-8859-1')
csv.each do |row|
  t = Address.new
  t.street = row['street']
  t.kind = row['kind']
  t.company_id = row['company_id']
  t.pincode_id = row['pincode_id']
  t.save
end
puts "Addresses created"

puts "Creating Transports - 12"
csv_text = File.read(Rails.root.join('lib', 'seeds', "transport.csv"))
csv = CSV.parse(csv_text, :headers => true, :encoding => 'ISO-8859-1')
csv.each do |row|
  t = Transport.new
  t.name = row['name']
  t.street = row['street']
  t.village = row['village']
  t.number = row['number']
  t.save
end
puts "Transports created"

puts "Creating Numbers - 13"
csv_text = File.read(Rails.root.join('lib', 'seeds', "number.csv"))
csv = CSV.parse(csv_text, :headers => true, :encoding => 'ISO-8859-1')
csv.each do |row|
  t = Number.new
  # t.name = row['name']
  # t.street = row['street']
  # t.village = row['village']
  # t.number = row['number']
  t.save
end
puts "Numbers created"

puts "Creating Mails - 14"
csv_text = File.read(Rails.root.join('lib', 'seeds', "mail.csv"))
csv = CSV.parse(csv_text, :headers => true, :encoding => 'ISO-8859-1')
csv.each do |row|
  t = Mail.new
  # t.name = row['name']
  # t.street = row['street']
  # t.village = row['village']
  # t.number = row['number']
  t.save
end
puts "Mails cre4ted"
