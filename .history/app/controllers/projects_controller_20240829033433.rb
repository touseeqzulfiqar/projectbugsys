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
    @project.users.build unless @project.users.any?
  end

  # POST /projects or /projects.json
  def create
    @project = Project.new(project_params)
    if @project.save
      current_user.projects << @project unless @project.users.include?(current_user)
      UserMailer.new_user(@qa_users, @project).deliver_now
      redirect_to project_url(@project), notice: 'Project was successfully created.'
    else
      render :new, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /projects/1 or /projects/1.json
  def update
    if @project.update(project_params)
      current_user.projects << @project unless @project.users.include?(current_user)
      redirect_to project_url(@project), notice: 'Project was successfully updated.'
    else
      render :edit, status: :unprocessable_entity
    end
  end

  # DELETE /projects/1 or /projects/1.json
  def destroy
    @project.destroy
    redirect_to projects_url, notice: 'Project was successfully destroyed.'
  end

  # PATCH/PUT /projects/1/bugs/:bug_id/status_update
  def status_update
    @bug = @project.bugs.find_by(id: params[:bug_id])
    if @bug
      @bug.update(status: 'resolved')
      redirect_to project_path(@project), notice: 'Bug was successfully resolved.'
    else
      redirect_to project_path(@project), alert: 'Bug not found.'
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_project
    @project = Project.find(params[:id])
  rescue ActiveRecord::RecordNotFound
    redirect_to projects_path, alert: 'Project not found.'
  end

  # Only allow a list of trusted parameters through.
  def project_params
    params.require(:project).permit(:name, :description, user_ids: [])
  end
end
