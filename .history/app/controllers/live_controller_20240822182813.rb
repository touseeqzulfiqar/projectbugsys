class LiveController < ApplicationController
  def suggestions
    if params[:query].present?
      @projects = Project.where("name ILIKE ?", "%#{params[:query]}%")
    else
      @projects = Project.all
    end
    respond_to do |format|
      format.turbo_stream
    end
  end
end
