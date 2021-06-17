class HomeController < ApplicationController
  before_action :set_user, only: %i(index)
  
  def index
  end
end
