class LiveController < ApplicationController
  def suggestions
    if params[:query].present?
      @projects = Project.where("name LIKE ?", "%#{params[:query]}%")
    else
      @projects = Project.all
    end
    render json: {projects: @projects}
  end
end
