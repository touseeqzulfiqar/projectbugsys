class SearchController < ApplicationController
  def suggestion
    byebug
    if params[:query].present?
      @projects = Project.where("name LIKE ?", "%#{params[:query]}%")
    else
      @projects = Project.all
    end
  end
end
