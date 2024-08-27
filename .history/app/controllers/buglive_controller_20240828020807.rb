class BugliveController < ApplicationController
  def suggestions
      if params[:search].present?
        @bugs = Bug.where("description ILIKE ?", "%#{params[:search]}%").order(:description).limit(10)
      else
        @bugs = Bug.all
      end

  end
end
