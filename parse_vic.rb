require 'open-uri'
require 'nokogiri'
require 'json'

url = 'http://vicfirth.com/catalog/drumsticks/'
html = open(url)

doc = Nokogiri::HTML(html)
sticks = []
doc.css('.product-details').each do |product_details|
	stick_name = product_details.at_css('h3 a').text
	product_details.css('.product-attributes').each do |product_attributes|
		stick_diametr, stick_length = product_attributes.css('small')
														.map { |data| data.text.gsub(/\[?\]?/, '').to_f }
		sticks.push(
	    	title: stick_name,
	    	diametr: stick_diametr,
	    	length: stick_length
		)
	end
end

puts JSON.pretty_generate(sticks)