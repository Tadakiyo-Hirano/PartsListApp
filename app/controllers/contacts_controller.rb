class ContactsController < ApplicationController
  before_action :set_contact, only: [:show, :edit, :update, :destroy]

  def index
    @contacts = Contact.all
  end

  def show
    @contact = Contact.find(params[:id])
  end

  def new
    @contact = Contact.new
  end

  def create
    @contact = Contact.new(contact_params)
    if @contact.save
      ContactMailer.contact_mail(@contact).deliver
      redirect_to contact_path(@contact), flash: { notice: '不具合報告を送信しました。' }
    else
      render :new
    end
  end

  def edit
  end

  def update
    respond_to do |format|
      if @contact.update(contact_params)
        redirect_to @contact, flash: { notice: 'Contact was successfully updated.' }
      else
        render :edit
      end
    end
  end

  def destroy
    @contact.destroy
    respond_to do |format|
      redirect_to contacts_url, flash: { notice: 'Contact was successfully destroyed.' }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_contact
      @contact = Contact.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def contact_params
      params.require(:contact).permit(:name, :content)
    end
end
