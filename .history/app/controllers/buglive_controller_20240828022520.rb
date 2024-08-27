class BugliveController < ApplicationController
  def suggestions
  if params[:search].present?
    search_term = "%#{params[:search]}%"
    @bugs = Bug.where("description ILIKE ? OR bug_type ILIKE ?", search_term, search_term)
               .order(:description)
               .limit(10)
  else
    # @bugs = Bug.all.limit(10)
  end

  render json: { bugs: @bugs }
end

end
