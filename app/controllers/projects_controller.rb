class ProjectsController < ApplicationController
  before_action :set_project, only: [:show, :edit, :update, :destroy]

  # GET /projects
  # GET /projects.json
  def index
    active_id = ProjectType.find_by_description("Active").id
    delivered_id = ProjectType.find_by_description("Delivered").id
    if @current_user.is_admin?
      @active_projects = Project.where(:projectTypeId => active_id)
      @delivered_projects = Project.where(:projectTypeId => delivered_id)
    elsif @current_user.is_affiliate?
      @active_projects = Project.where(:projectTypeId => active_id, :affiliateId => @current_user.id)
      @delivered_projects = Project.where(:projectTypeId => delivered_id, :affiliateId => @current_user.id)
    else
      @active_projects = Project.where(:projectTypeId => active_id, :customerId => @current_user.id)
      @delivered_projects = Project.where(:projectTypeId => delivered_id, :customerId => @current_user.id)
    end
  end

  def dashboard
  end
  # GET /projects/1
  # GET /projects/1.json
  def show
  end

  # GET /projects/new
  def new
    @project = Project.new
    @pilots = User.where(:userTypeId => UserType.find_by_description("Affiliate").id)
    respond_to do |format|
      format.html{}
      format.js{render :layout => false}
    end
  end

  # intermediary between project input and confirm project details.
  def confirm_project
    @loc = params[:project][:address]
    @due = DateTime.strptime(params[:due][:month] + params[:due][:day].strip + params[:due][:year],"%B%d%Y")
    @comment = params[:comment][:text]
    @card = @current_user.get_card(@current_user.get_default_id)
    logger.debug params["pilot"].keys.first.to_s
    @pilot = User.find(params["pilot"].keys.first.to_i)
    @project = Project.new
    @active_id = ProjectType.find_by_description("Active").id
    @my_id = @current_user.id
    respond_to do |format|
      format.js{render :layout => false}
    end
  end

  # GET /projects/1/edit
  def edit
  end

  # POST /projects
  # POST /projects.json
  def create
    @project = Project.new(project_params)
    @current_user.charge(1)
    respond_to do |format|
      if @project.save
        format.html { redirect_to @project, notice: 'Project was successfully created.' }
        format.json { render :show, status: :created, location: @project }
      else
        format.html { render :new }
        format.json { render json: @project.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /projects/1
  # PATCH/PUT /projects/1.json
  def update
    respond_to do |format|
      if @project.update(project_params)
        format.html { redirect_to @project, notice: 'Project was successfully updated.' }
        format.json { render :show, status: :ok, location: @project }
      else
        format.html { render :edit }
        format.json { render json: @project.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /projects/1
  # DELETE /projects/1.json
  def destroy
    @project.destroy
    respond_to do |format|
      format.html { redirect_to projects_url, notice: 'Project was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_project
      @project = Project.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def project_params
      params.require(:project).permit(:customerId, :affiliateId, :address, :zip, :latitude, :longitude, :due, :projectTypeId, :owner)
    end
end
