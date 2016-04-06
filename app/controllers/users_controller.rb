class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update, :destroy, :user_aircraft, :profile]
  before_filter :ensure_admin, except: [:profile, :calendar, :aircraft, :account, :new_pilot, :signup, :become_a_pilot, :create, :confirm_signup, :update_password, :update]

  # GET /users
  # GET /users.json
  def index
    @users = User.all
  end

  # GET /users/1
  # GET /users/1.json
  def show
  end

  def confirm_signup
  end

  # GET /users/new
  def new
    @user = User.new
  end

  def become_a_pilot
    @user = User.new
  end

  def account
    @user = @current_user
  end

  def update_password
    user = User.authenticate(@current_user.email,params[:old_password])
    respond_to do |format|
      if user
        if params["user"][:password] == params["user"][:password_confirmation]
          format.html { redirect_to :back, notice: "Success!" }
          format.json{ render json: "Success" }
          format.js{ render json: "sad"}
        else
          format.html { redirect_to :back, notice: "Passwords don't match." }
        end
      else
        format.json { render json: user.errors, status: :unprocessable_entity }
      end
    end
  end

  def add_card
    User.add_card(card_params)
  end

  def aircraft
  end

  def calendar
  end

  def profile
  end

  def signup
    @user = User.new
  end
  # GET /users/1/edit
  def edit
  end

  def new_pilot
    @user = User.new(user_params)

    respond_to do |format|
      if @user.save
        session[:user] = @user.id
        format.html { redirect_to '/confirm_signup'}
        format.json { render :show, status: :created, location: @user }
      else
        format.html { render 'become_a_pilot' }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # POST /users
  # POST /users.json
  def create
    @user = User.new(user_params)

    respond_to do |format|
      if @user.save
        session[:user] = @user.id
        format.html { redirect_to '/confirm_signup'}
        format.json { render :show, status: :created, location: @user }
      else
        format.html { render 'signup' }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /users/1
  # PATCH/PUT /users/1.json
  def update
    respond_to do |format|
      if @user.is_admin?
        if @user.update(user_params)
          format.html { redirect_to @user, notice: 'User was successfully updated.' }
          format.json { render :show, status: :ok, location: @user }
        else
          format.html { render :edit }
          format.json { render json: @user.errors, status: :unprocessable_entity }
        end
      else
        if @user.update(user_params)
          format.html { redirect_to :back, notice: 'Changes have been saved.' }
          format.json { render :account, status: :ok, location: @user }
        else
          format.html { redirect_to :back, notice: 'Update failed.' }
          format.json { render :account, status: :ok, location: @user }
        end
      end
    end
  end

  # DELETE /users/1
  # DELETE /users/1.json
  def destroy
    @user.destroy
    respond_to do |format|
      format.html { redirect_to users_url, notice: 'User was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = User.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def user_params
      params.require(:user).permit(:firstName, :lastName, :zipCode, :email, :username, :password_enc, :password, :salt, :userTypeId, :active, :approved)
    end

    def card_params
      params.require(:user).permit(:card_number, :exp_month, :exp_year, :cvc)
    end
end
