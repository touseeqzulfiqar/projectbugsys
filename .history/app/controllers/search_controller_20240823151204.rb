class SearchController < ApplicationController
  def suggestion
    if params[:search].present?
      @projects = Project.where("name ILIKE ?", "%#{params[:search]}%")
    else
      @projects = []
    end

    respond_to do |format|
      format.json { render json: { projects: @projects } }
      # format.turbo_stream
    end
  end
end
