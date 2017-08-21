require "#{Rails.root}/lib/search_system/belchip_website"
require "#{Rails.root}/lib/search_system/chipdip_website"

class SearchController < ApplicationController

	def search
    time1 = Time.now
		search_value = params[:id]
    belchip = BelchipWebsite.new search_value
    belchip_items = belchip.get_items

    chipdip = ChipdipWebsite.new search_value
    chipdip_items = chipdip.get_items

    @all_items = belchip_items + chipdip_items
    time2 = Time.now
    puts "------------- #{time2 - time1} -------------"
	end
end
