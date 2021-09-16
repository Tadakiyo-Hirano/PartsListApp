class AdminsController < ApplicationController
  def index
    @storage_size = Product.all.map {|product| product.document.byte_size}
  end
end
