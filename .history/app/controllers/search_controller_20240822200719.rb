class SearchController < ApplicationController
  def suggestion
    
    binding.pry
    
    if params[:search].present?
      @projects = Project.where("name ILIKE ?", "%#{params[:search]}%")
    else
      @projects = []
    end

    respond_to do |format|
      format.turbo_stream
    end
  end
end
