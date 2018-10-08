require 'csv'

i = 1
puts "Creating States - #{i}"
csv_text = File.read(Rails.root.join('lib', 'seeds', "state.csv"))
csv = CSV.parse(csv_text, :headers => true, :encoding => 'ISO-8859-1')
csv.each do |row|
  t = State.new
  t.name = row['name']
  t.code = row['code']
  t.save!
end
puts "States created"
i += 1


puts "Creating Cities - #{i}"
csv_text = File.read(Rails.root.join('lib', 'seeds', "city.csv"))
csv = CSV.parse(csv_text, :headers => true, :encoding => 'ISO-8859-1')
csv.each do |row|
  t = City.new
  t.name = row['name']
  t.state_id = row['state_id']
  t.save!
end
puts "Cities created"
i += 1

puts "Creating Pincodes - #{i}"
csv_text = File.read(Rails.root.join('lib', 'seeds', "pincode.csv"))
csv = CSV.parse(csv_text, :headers => true, :encoding => 'ISO-8859-1')
count = 0
csv.each do |row|
  t = Pincode.new
  t.pin = row['pin']
  t.city_id = row['city_id']
  if (count > 100)
  end
  t.save!
  count += 1
end
puts "Pincodes created"
i += 1

puts "Creating Harmonics - #{i}"
csv_text = File.read(Rails.root.join('lib', 'seeds', "harmonic.csv"))
csv = CSV.parse(csv_text, :headers => true, :encoding => 'ISO-8859-1')
csv.each do |row|
  t = Harmonic.new
  t.hsn = row['hsn']
  t.save!
end
puts "Harmonics created"
i += 1

puts "Creating Types - #{i}"
csv_text = File.read(Rails.root.join('lib', 'seeds', "type.csv"))
csv = CSV.parse(csv_text, :headers => true, :encoding => 'ISO-8859-1')
csv.each do |row|
  t = Type.new
  t.name = row['name']
  t.save!
end
puts "Types created"
i += 1

puts "Creating Products - #{i}"
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
  t.save!
end
puts "Products created"
i += 1


puts "Creating Uses - #{i}"
csv_text = File.read(Rails.root.join('lib', 'seeds', "use.csv"))
csv = CSV.parse(csv_text, :headers => true, :encoding => 'ISO-8859-1')
csv.each do |row|
  t = Use.new
  t.name = row['name']
  t.save!
end
puts "Uses created"
i += 1


puts "Creating Categories - #{i}"
csv_text = File.read(Rails.root.join('lib', 'seeds', "category.csv"))
csv = CSV.parse(csv_text, :headers => true, :encoding => 'ISO-8859-1')
csv.each do |row|
  t = Category.new
  t.name = row['name']
  t.save!
end
puts "Categories created"
i += 1

puts "Creating Packings - #{i}"
csv_text = File.read(Rails.root.join('lib', 'seeds', "packing.csv"))
csv = CSV.parse(csv_text, :headers => true, :encoding => 'ISO-8859-1')
csv.each do |row|
  t = Packing.new
  t.rebate = row['rebate']
  t.pack_size = row['pack_size']
  t.sample = row['sample']
  t.save!
end
puts "Packings created"
i += 1

puts "Creating Companies - #{i}"
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
  t.save!
end
puts "Companies created"
i += 1

puts "Creating Addresses - #{i}"
csv_text = File.read(Rails.root.join('lib', 'seeds', "address.csv"))
csv = CSV.parse(csv_text, :headers => true, :encoding => 'ISO-8859-1')
csv.each do |row|
  t = Address.new
  t.street = row['street']
  t.kind = row['kind']
  t.company_id = row['company_id']
  t.pincode_id = row['pincode_id']
  t.save!
end
puts "Addresses created"
i += 1

puts "Creating Transports - #{i}"
csv_text = File.read(Rails.root.join('lib', 'seeds', "transport.csv"))
csv = CSV.parse(csv_text, :headers => true, :encoding => 'ISO-8859-1')
csv.each do |row|
  t = Transport.new
  t.name = row['name']
  t.street = row['street']
  t.village = row['village']
  t.number = row['number']
  t.save!
end
puts "Transports created"
i += 1

puts "Creating Numbers - #{i}"
csv_text = File.read(Rails.root.join('lib', 'seeds', "number.csv"))
csv = CSV.parse(csv_text, :headers => true, :encoding => 'ISO-8859-1')
csv.each do |row|
  t = Number.new
  t.num = row['num']
  t.primary = row['primary']
  t.company_id = row['company_id']
  t.user_id = row['user_id']
  t.save!
end
puts "Numbers created"
i += 1

puts "Creating Mails - #{i}"
csv_text = File.read(Rails.root.join('lib', 'seeds', "mail.csv"))
csv = CSV.parse(csv_text, :headers => true, :encoding => 'ISO-8859-1')
csv.each do |row|
  t = Mail.new
  t.eadd = row['eadd']
  t.primary = row['primary']
  t.company_id = row['company_id']
  t.user_id = row['user_id']
  t.save!
end
puts "Mails created"
i += 1
