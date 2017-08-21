class ElectronicItem

  attr_accessor :price, :name, :link, :pic_link, :shop_name

  def inspect
    puts "#{name} #{price} #{link} #{pic_link} #{shop_name}"
  end

end