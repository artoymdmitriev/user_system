require 'nokogiri'
require 'open-uri'
require "#{Rails.root}/lib/search_system/electronics_website"
require "#{Rails.root}/lib/search_system/electronic_item"

class ChipdipWebsite < ElectronicsWebsite
  def get_items
    get_main_webpage
  end

  # search page
  def get_main_webpage
    main_webpage = Nokogiri::HTML(open("https://www.ru-chipdip.by/search?searchtext=#{request_string}"))
    get_links_to_pages_with_item_lists_groups main_webpage
  end

  # links to pages with items grouped in groups (same as search page)
  def get_links_to_pages_with_item_lists_groups main_webpage
    @links_to_pages_with_item_lists_groups = Array.new
    @links_to_pages_with_item_lists_groups << "https://www.ru-chipdip.by/search?searchtext=#{request_string}&page=1"
    css = ".pager__page a"
    main_webpage.css(css).each { |item| @links_to_pages_with_item_lists_groups << ("https://www.ru-chipdip.by" + item['href'])}
    get_webpage_items
  end

  def get_webpage_items
    items = Array.new
    css = ".with-hover"
    @links_to_pages_with_item_lists_groups.each do |link|
      page = Nokogiri::HTML(open(link))
      items = page.css(css)
      items.each do |item_html|
        parse_item item_html
      end
    end
  end

  def parse_item item_html
    item = ElectronicItem.new
    item.name = get_item_name item_html
    item.link = get_item_link item_html
    item.price = get_item_price item_html
    item.pic_link = get_item_pic_link item_html
    item.shop_name = get_shop_name
    Item.create!(name: item.name, price: item.price, link: item.link, pic_link: item.pic_link, shop_name: item.shop_name)

  end

  def add_item_to_array item
    @electronic_items << item
  end

  def get_item_name item
    css = ".h_name .name .link"
    item.css(css).text
  end

  def get_item_link item
    css = ".h_name .name .link"
    item_link = item.css(css)[0]['href']
    "https://www.ru-chipdip.by" + item_link
  end

  def get_item_price item
    css = ".price_mr"
    item.css(css).text
  end

  def get_item_pic_link item
    css = ".img .img-wrapper .galery img"
    item.css(css)[0]['src']
  end

  def get_shop_name
    "ChipDip"
  end


=begin
  # links to pages with items in lists
  def get_links_to_pages_with_item_lists
    @links_to_pages_with_item_lists = Array.new
    @links_to_pages_with_item_lists_groups.each do |link|
      css = ".group-header-wrap a"
      page = Nokogiri::HTML(open(link))
      page.css(css).each { |element| @links_to_pages_with_item_lists << "https://www.ru-chipdip.by" + element['href']}
    end
    get_links_to_each_page_with_item_lists
  end

  # https://www.ru-chipdip.by/catalog-show/machines-electronics?gq=arduino
  def get_links_to_each_page_with_item_lists
    @links_to_each_page_with_item_lists = Array.new
    @links_to_pages_with_item_lists.each do |link|
      @links_to_each_page_with_item_lists << "#{link}&page=1"
      css = ".pager__page a"
      page = Nokogiri::HTML(open(link))
      #page.css(css).each { |item| @links_to_each_page_with_item_lists << ("https://www.ru-chipdip.by" + item['href'])}
      page.css(css).each { |item| @links_to_each_page_with_item_lists << ("https://www.ru-chipdip.by" + item['href']); sleep 0.5}
    end
    puts "-----"
    puts @links_to_each_page_with_item_lists
  end
=end
end