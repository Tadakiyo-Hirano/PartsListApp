class Admins::NoticesController < ApplicationController
  before_action :authenticate_admin!
  before_action :set_notice, only: %i(edit update destroy)
  
  def index
    @notices = Notice.order(display: :DESC).order(posted_at: :DESC)
  end

  def new
    @notice = Notice.new
  end

  def create
    @notice = Notice.new(notice_params)
    if @notice.save
      flash[:success] = "おしらせ(#{@notice.posted_at})を登録しました。"
      redirect_to request.referer
    else
      flash[:danger] = @notice.errors.full_messages.join
      redirect_to request.referer
    end
  end

  def edit
  end

  def update
    @notice_updated_at = @notice.updated_at
    if @notice.update(notice_params)
      if @notice_updated_at != @notice.updated_at
        flash[:success] = "#{@notice.posted_at}おしらせを更新しました。"
      else
        flash[:info] = "変更はありません。"
      end
      redirect_to admins_notices_url
    else
      flash[:danger] = @notice.errors.full_messages.join
      redirect_to admins_notices_url
    end
  end

  def destroy
    @notice.destroy
    redirect_to admins_notices_url, flash: { danger: "お知らせを削除しました。" }
  end

  private

    def set_notice
      @notice = Notice.find(params[:id])
    end

    def notice_params
      params.require(:notice).permit(:posted_at, :text, :display)
    end
end
