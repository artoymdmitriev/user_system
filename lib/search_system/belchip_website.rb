require 'nokogiri'
require 'open-uri'
require "#{Rails.root}/lib/search_system/electronics_website"
require "#{Rails.root}/lib/search_system/electronic_item"

class BelchipWebsite < ElectronicsWebsite
  
  def get_items
    get_webpage
    return @electronic_items
  end

  def get_webpage
    webpage = Nokogiri::HTML(open("http://belchip.by/search/?query=#{request_string}"))
    get_webpage_items webpage
  end

  def get_webpage_items webpage
    items = Array.new
  	css = ".cat-item"
    items = webpage.css(css)
    items.each do |item_html|
      parse_item item_html
    end
  end

  def parse_item item_html
    item = ElectronicItem.new
    item.name = get_item_name item_html
    item.link = get_item_link item_html
    item.price = get_item_price item_html
    item.pic_link = get_item_pic_link item_html
    item.shop_name = get_shop_name
    add_item_to_array item
  end

  def add_item_to_array item
    @electronic_items << item
  end

  def get_item_name item
    css = "h3 a"
    item.css(css).text
  end

  def get_item_link item
    css = "h3 a"
    item_link = item.css(css)[0]['href']
    "http://belchip.by/" + item_link
  end

  def get_item_price item
    css = ".butt-add span .denoPrice"
    item_price = item.css(css).text
    item_price.empty? ? "Цена по запросу" : item_price
  end

  def get_item_pic_link item
    css = ".cat-pic a img"
    item_pic_link = item.css(css)[1]['src']
    "http://belchip.by/" + item_pic_link
  end

  def get_shop_name
    "Belchip"
  end
end