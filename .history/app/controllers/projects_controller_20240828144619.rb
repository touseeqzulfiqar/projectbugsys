class ProjectsController < ApplicationController
  before_action :set_project, only: %i[show edit update destroy status_update]
  load_and_authorize_resource

  # GET /projects or /projects.json
  def index
    if current_user.manager?
      @pagy, @projects = pagy(Project.all)
      @bugs = current_user.bugs
    elsif current_user.QA?
      @pagy, @projects = pagy(current_user.projects)
      @bugs = current_user.bugs
    else
      redirect_to all_bugs_path
    end
  end

  # GET /projects/1 or /projects/1.json
  def show
    @bugs = @project.bugs
  end

  # GET /projects/new
  def new
    @project = Project.new
    @project.users.build
    @qa_users = User.QA
    @developer_users = User.developer
  end

  # GET /projects/1/edit
  def edit
    @qa_users = User.QA
    @developer_users = User.developer
    @project.users.build
  end

  # POST /projects or /projects.json
  def create
    @project = Project.new(project_params)

    current_user.projects << @project
    respond_to do |format|
      if @project.save
        UserMailer.new_user(@qa_users, @project).deliver_now
        format.html { redirect_to project_url(@project), notice: 'Project was successfully created.' }
        format.json { render :show, status: :created, location: @project }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @project.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /projects/1 or /projects/1.json
  def update
    if @project.update(project_params)
      current_user.projects << @project unless @project.users.include?(current_user)
      respond_to do |format|
        format.html { redirect_to project_url(@project), notice: 'Project was successfully updated.' }
        format.json { render :show, status: :ok, location: @project }
      end
    else
      respond_to do |format|
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @project.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /projects/1 or /projects/1.json
  def destroy
    @project.destroy!

    respond_to do |format|
      format.html { redirect_to projects_url, notice: 'Project was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  # PATCH/PUT /projects/1/bugs/:bug_id/status_update
  def status_update
    @bug = @project.bugs.find(params[:bug_id])
    @bug.update(status: 'resolved') # Example status update

    redirect_to project_path(@project), notice: 'Bug was successfully resolved.'
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_project
    @project = Project.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def project_params
    params.require(:project).permit(:name, :description, user_ids: [],
                                                         users_attributes: %i[id email name role password password_confirmation _destroy])
  end
end
