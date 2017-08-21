class ElectronicsWebsite

  attr_accessor :request_string, :electronic_items

  def initialize request_string
    #@request_string = request_string.tr " ", "+"
    @request_string = request_string
    @electronic_items = Array.new
  end
  
  def get_items
    raise NotImplementedError, 'Use the subclass'
  end

end