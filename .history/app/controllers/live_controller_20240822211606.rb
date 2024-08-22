class LiveController < ApplicationController
  def suggestions
    
    binding.pry
    
    if params[:search].present?
      @projects = Project.where("name LIKE ?", "%#{params[:search]}%").order(:name).limit(10)
    else
      @projects = Project.all
    end
    render json: {projects: @projects}
  end
end
