class BugsController < ApplicationController
  before_action :set_project
  before_action :set_bug, only: %i[ show edit update destroy ]

  # GET /bugs or /bugs.json
  def index
    # @bugs = Bug.all
    @bugs = @project.bugs
  end

  # GET /bugs/1 or /bugs/1.json
  def show
  end

  # GET /bugs/new
  def new
    @bug = Bug.new
    @developer_users = User.developer
    # @project = Project.find(params[:project_id])
  end

  # GET /bugs/1/edit
  def edit
  end

  # POST /bugs or /bugs.json
  def create
    # @bug = Bug.new(bug_params)
    @bug = @project.bugs.new(bug_params)
    @developer_users = User.find(params[:bug][:developer_user_id])
    @developer_users.bugs << @bug

    respond_to do |format|
      if @bug.save
        format.html { redirect_to project_bug_path(@project,@bug), notice: "Bug was successfully created." }
        format.json { render :show, status: :created, location: @bug }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @bug.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /bugs/1 or /bugs/1.json
  def update
    respond_to do |format|
      if @bug.update(bug_params)
        format.html { redirect_to project_bug_path(@project, @bug), notice: "Bug was successfully updated." }
        format.json { render :show, status: :ok, location: @bug }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @bug.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /bugs/1 or /bugs/1.json
  def destroy
    @bug.destroy!

    respond_to do |format|
      format.html { redirect_to project_bugs_path(@project), notice: "Bug was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_bug
      @bug = Bug.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def bug_params
      params.require(:bug).permit(:description, :status, :project_id)
    end
    def set_project
    @project = Project.find(params[:project_id])
  end
end
