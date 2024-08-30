class BugsController < ApplicationController
  before_action :set_project, only: %i[index new create edit update destroy show assign]
  before_action :set_bug, only: %i[show edit update destroy assign update_status]

  def index
    @bugs = @project.bugs.accessible_by(current_ability)
  end

  def show
    @bugs = @project.bugs
  end

  def new
    @bug = @project.bugs.new
    @developer_users = User.developer
  end

  def edit
    @developer_users = User.developer
  end

  def create
    @bug = @project.bugs.new(bug_params)
    @bug.user = current_user
    @bug.developer_id = nil

    respond_to do |format|
      if @bug.save
        format.html { redirect_to project_bug_path(@project, @bug), notice: 'Bug was successfully created.' }
        format.json { render :show, status: :created, location: @bug }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @bug.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @bug.update(bug_params)
        format.html { redirect_to project_bug_path(@project, @bug), notice: 'Bug was successfully updated.' }
        format.json { render :show, status: :ok, location: @bug }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @bug.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @bug.destroy!

    respond_to do |format|
      format.html { redirect_to project_bugs_path(@project), notice: 'Bug was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def assign
    if @bug.update(developer_id: params[:bug][:developer_id])
      redirect_to project_bug_path(@project, @bug), notice: 'Bug assigned successfully.'
    else
      render :show, status: :unprocessable_entity
    end
  end

  def update_status
    if @bug.update(status: params[:bug][:status])
      redirect_to bugs_path, notice: 'Bug status was successfully updated.'
    else
      redirect_to bugs_path, alert: 'Failed to update bug status.'
    end
  end

  private

  def set_bug
    @bug = Bug.find(params[:id])
  end

  def set_project
    @project = Project.find(params[:project_id])
  end

  def bug_params
    params.require(:bug).permit(:title, :description, :status, :project_id, :deadline, :bug_type, :screenshot)
  end
end
