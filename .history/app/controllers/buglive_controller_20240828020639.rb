class BugliveController < ApplicationController
  def suggestions
      if params[:search].present?
        @bugs = Bug.where("description LIKE ?", "%#{params[:search]}%").order(:title).limit(10)
      else
        @bugs = Bug.all
      end

  end
end
