require "#{Rails.root}/lib/search_system/belchip_website"
require "#{Rails.root}/lib/search_system/chipdip_website"


class SearchController < ApplicationController

	def search
    Item.delete_all
    search_value = params[:id]
    
    Thread.new {
      parse_belchip(search_value)
    }

    Thread.new {
      parse_chipdip(search_value)
    }

    sleep 1.seconds
    if Item.all.count < 11
      sleep 1.seconds
    end
    puts "----------------------------- #{Item.all.count}"
    redirect_to '/items/show'
	end

  def parse_belchip search_value
    belchip = BelchipWebsite.new search_value
    belchip_items = belchip.get_items
  end

  def parse_chipdip search_value
    chipdip = ChipdipWebsite.new search_value
    chipdip_items = chipdip.get_items
  end
end
