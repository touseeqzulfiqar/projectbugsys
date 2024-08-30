class BugliveController < ApplicationController
  def suggestions
    debugger
    if params[:search].present?
      search_term = "%#{params[:search]}%"
      @bugs = Bug.where("user_id = ? AND (description ILIKE ? OR bug_type ILIKE ?)", current_user.id, search_term, search_term)
                 .order(:description)
                 .limit(10)
    else
      # Optionally handle the case where no search term is provided
      # @bugs = Bug.where(user_id: current_user.id).limit(10)
    end

    render json: { bugs: @bugs }
  end
end
