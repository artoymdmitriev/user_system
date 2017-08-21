require './belchip_website'
require './chipdip_website'

b = BelchipWebsite.new "arduino board"
b.get_items.each { |item| puts item.inspect }

d = ChipdipWebsite.new "arduino board"
d.get_items.each { |item| puts item.inspect }