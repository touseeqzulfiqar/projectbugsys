class BugliveController < ApplicationController
  def suggestions
      if params[:search].present?
        @projects = Project.where("name ILIKE ?", "%#{params[:search]}%")
      end
  end
end
