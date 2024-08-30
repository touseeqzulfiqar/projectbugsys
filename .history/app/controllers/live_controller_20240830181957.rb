class LiveController < ApplicationController
  def suggestions
    if params[:search].present?
      search_term = "%#{params[:search]}%"
      @projects = Project.where("name ILIKE ?", search_term).limit(10)

      # Filter projects based on user assignment
      @projects = @projects.select { |project| project.users.include?(current_user) }

      if @projects.empty?
        render json: { error: "You are not assigned to any of the found projects" }
      else
        render json: { projects: @projects }
      end
    else
      render json: { error: "Search term cannot be empty" }
    end
  end
end
