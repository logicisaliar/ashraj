require 'csv'

csv_text = File.read(Rails.root.join('lib', 'seeds', 'hsn.csv'))
csv = CSV.parse(csv_text, :headers => true, :encoding => 'ISO-8859-1')
csv.each do |row|
  t = HarmonicDetail.new
  t.hsn_chapter = row['hsn_chapter']
  t.gst = row['gst']
  t.save
  puts "#{t.hsn_chapter}, #{t.gst} saved"
end

puts "There are now #{HarmonicDetail.count} rows in the transactions table"
# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
