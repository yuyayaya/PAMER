class StaticPagesController < ApplicationController
  layout 'landing_page'

  def home
    @user = current_user
    if params[:search].present?
      @plans = Plan.search(params[:search]).paginate(page: params[:page])
    else
      @plans = Plan.paginate(page: params[:page])
    end
  end

  def help
  end

  def about
  end

  def contact
  end
end
