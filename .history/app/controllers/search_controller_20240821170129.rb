class SearchController < ApplicationController
  def suggestion
    if params[:query].present?
      @projects = Project.where("name LIKE ?", "%#{params[:query]}%")
    else
      @projects = Project.all
    end

    respond_to do |format|
      format.turbo_stream
    end
  end
end
