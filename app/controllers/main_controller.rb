class MainController < ApplicationController
  before_filter :authenticate_user, only: [:dashboard]

  def index
    @home = true
    @signup_link = '/signup'
    render layout: 'responsive'
  end

  def about
  end

  def contact
    @contact = Contact.new
  end

  def affiliates
    @signup_link = '/become_a_pilot'
    render layout: 'responsive'
  end

  def dashboard
    active_id = ProjectType.find_by_description("Active").id
    @messages = Message.where(:toId => @current_user.id)
    if @current_user.is_admin?
      @projects = Project.where(:projectTypeId => active_id)
    elsif @current_user.is_affiliate?
      @projects = Project.where(:projectTypeId => active_id, :affiliateId => @current_user.id)
    else
      @projects = Project.where(:projectTypeId => active_id, :customerId => @current_user.id)
    end 
  end

  def joe_sullivan
  end

  def nathan_sullivan
  end

  def kyle_bembnister
  end

  def mike_ledermann
  end

  def timothy_haas
  end 

  def create_contact
    @contact = Contact.new(contact_type_params)

    respond_to do |format|
      if @contact.save
        AdminMailer.contact_mail(params[:contact][:name],params[:contact][:email],params[:contact][:message]).deliver
      	format.html { redirect_to '/contact_success' }
      else
      	format.html { render 'contact' }
      	format.json { render json: @contact.errors, status: :unprocessable_entity }
      end
    end
  end

  def contact_success
  end

  private
  def contact_type_params
      params.require(:contact).permit(:email,:name,:message)
  end

end
