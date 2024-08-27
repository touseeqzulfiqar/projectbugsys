class BugsController < ApplicationController
  before_action :set_project, only: %i[ index new create edit update destroy show]
  before_action :set_bug, only: %i[ show edit update destroy ]


    def all_bugs
      # @bugs = Bug.all
      @bugs = @project.bugs
    end
  # GET /bugs or /bugs.json
  def index
    # @bugs = Bug.all
    @bugs = @project.bugs
  end

  # GET /bugs/1 or /bugs/1.json
  def show
    @bugs = @project.bugs
  end

  # GET /bugs/new
  def new
    @bug = Bug.new
    @developer_users = User.developer
    # @project = Project.find(params[:project_id])
  end

  # GET /bugs/1/edit
  def edit
    @developer_users = User.developer
  end

  # POST /bugs or /bugs.json
  def create
  @bug = @project.bugs.new(bug_params)
  @bug.user = current_user  # Set the user_id to the current user's ID
  @bug.developer_id = nil   # Ensure developer_id is null
    debugger
  respond_to do |format|
    if @bug.save
      format.html { redirect_to project_bug_path(@project, @bug), notice: "Bug was successfully created." }
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
  def status_update
    @bug = Bug.find(params[:id])
    @bug.status = "Fixed"
    @bug.save
    redirect_to all_bugs_path
  end
   def assign
    @bug = Bug.find(params[:id])
  if @bug.update(developer_id: params[:bug][:developer_id])
    redirect_to project_bug_path(@bug.project, @bug), notice: 'Bug assigned successfully.'
  else
    render :show, status: :unprocessable_entity
  end
  end

  def update_status
    @bug = Bug.find(params[:id])
    if @bug.update(status: params[:bug][:status])
      redirect_to bugs_path, notice: "Bug status was successfully updated."
    else
      redirect_to bugs_path, alert: "Failed to update bug status."
    end
  end
  private
    # Use callbacks to share common setup or constraints between actions.
    def set_bug
      @bug = Bug.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def bug_params
      params.require(:bug).permit(:description, :status, :project_id, :deadline, :bug_type, :screenshot)
    end
    def set_project
    @project = Project.find(params[:project_id])
  end
end
