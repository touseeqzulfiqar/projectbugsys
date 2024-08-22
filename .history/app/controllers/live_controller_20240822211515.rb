class LiveController < ApplicationController
  def suggestions
    
    binding.pry
    
    if params[:query].present?
      @projects = Project.where("name LIKE ?", "%#{params[:query]}%").order(:name).limit(10)
    else
      @projects = Project.all
    end
    render json: {projects: @projects}
  end
end
