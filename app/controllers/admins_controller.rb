class AdminsController < ApplicationController
  before_action :authenticate_admin!
  
  def index
    @storage_size = Product.all.map {|product| product.document.byte_size}
  end
end
