class ProjectsController < ApplicationController
  before_action :set_project, only: %i[show edit update destroy status_update]
  load_and_authorize_resource

  def index
    @pagy, @projects = pagy(Project.accessible_by(current_ability))
    @bugs = Bug.accessible_by(current_ability)
  end

  def show
    @bugs = @project.bugs
  end

  def new
    @project = Project.new
    @project.users.build
    @qa_users = User.QA
    @developer_users = User.developer
    @selected_developer_users = [] # Initialize as an empty array
  end

  def edit
    @qa_users = User.QA
    @developer_users = User.developer.where.not(id: @project.users.pluck(:id))
    @selected_developer_users = @project.users.developer
    @project.users.build unless @project.users.any?
  end

  def create
    @project = Project.new(project_params)
    @project.creator_id = current_user.id
    if @project.save
      assign_developers_to_project
      #  Assign the current user to the creator_id in projects
      current_user.projects << @project unless @project.users.include?(current_user)
      redirect_to project_url(@project), notice: 'Project was successfully created.'
    else
      render :new, status: :unprocessable_entity
    end
  end

  def update
    if @project.update(project_params)
      @project.users.clear
      assign_developers_to_project
      current_user.projects << @project unless @project.users.include?(current_user)
      redirect_to project_url(@project), notice: 'Project was successfully updated.'
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @project.destroy
    redirect_to projects_url, notice: 'Project was successfully destroyed.'
  end

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

  def set_project
    @project = Project.find(params[:id])
  rescue ActiveRecord::RecordNotFound
    redirect_to projects_path, alert: 'Project not found.'
  end

  def project_params
    params.require(:project).permit(:name, :description, user_ids: [], creator_id: [])
  end

  def assign_developers_to_project
    return unless params[:project][:developer_ids].present?

    # Split the comma-separated developer_ids into an array
    developer_ids = params[:project][:developer_ids].split(',')

    # Find the developer users by their IDs
    developer_users = User.where(id: developer_ids)

    # Assign the developers to the project
    @project.users << developer_users
  end
end
