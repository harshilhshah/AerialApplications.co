class MainController < ApplicationController
  before_filter :authenticate_user, only: [:dashboard]

  def index
    @home = true
    render layout: 'responsive'
  end

  def about
  end

  def contact
    @contact = Contact.new
  end

  def create_contact
    @contact = Contact.new(contact_type_params)

    respond_to do |format|
      if @contact.save
        format.html { redirect_to '/' }
      else
	format.html { render 'contact' }
        format.json { render json: @contact.errors, status: :unprocessable_entity }
      end
    end
  end

  private
  def contact_type_params
      params.require(:contact).permit(:email,:name,:message)
  end

  def affiliates
    render layout: 'responsive'
  end

  def dashboard
  end

end
