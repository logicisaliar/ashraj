require 'csv'
require 'open-uri'
require 'nokogiri'



csv_text = File.read(Rails.root.join('lib', 'seeds', 'hsn.csv'))
csv = CSV.parse(csv_text, :headers => true, :encoding => 'ISO-8859-1')
csv.each do |row|
  t = HarmonicDetail.new
  t.hsn_chapter = row['hsn_chapter']
  url = "http://www.cybex.in/HS-Codes/Perfumes-Toilet-Waters-Heading-#{t.hsn_chapter}.aspx"
  html_file = open(url).read
  html_doc = Nokogiri::HTML(html_file)
  t.gst = row['gst']
  html_doc.search('#ctl00_BodyContents_subheading_gridview_ctl02_SUBHEADING_DESCRIPTION').each do |element|
    t.description = element.text.strip
    # puts element.attribute('href').value
  end
  t.save
  puts "#{t.hsn_chapter}, #{t.gst}, #{t.description} saved"
end

puts "There are now #{HarmonicDetail.count} rows in the transactions table"
# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
