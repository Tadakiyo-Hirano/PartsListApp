class NoticesController < ApplicationController
  before_action :user_or_admin_signed_in?
  
  def index
    @notices = Notice.where(display: true).page(params[:page]).per(5).order(posted_at: :DESC)
  end
end
