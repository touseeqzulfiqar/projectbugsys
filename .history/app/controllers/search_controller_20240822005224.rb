class SearchController < ApplicationController
  def suggestion
    if params[:query].present?
      @projects = Project.where("name LIKE ?", "%#{params[:query]}%")
      render json: @projects
    else
      @projects = Project.all
      render json: @projects
    end
  end
end
