class BugliveController < ApplicationController
  def suggestions
    debugger
      if params[:search].present?
        @bugs = Bug.where("title LIKE ?", "%#{params[:search]}%").order(:title).limit(10)
      else
        @bugs = Bug.all
      end

  end
end
