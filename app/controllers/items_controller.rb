class ItemsController < ApplicationController
  def show
    @items = Item.paginate(:page => params[:page], :per_page => 10)
  end
end