class RequestsController < ApplicationController
  
  def create
    @guide = User.find(params[:guide_id])
    @plan = Plan.find(params[:plan_id])
    @request = current_user.active_requests.build(requests_params)
    if @request.save
      redirect_to user_plan_path(@guide, @plan), notice: "Thank you for applying!"
    else
      redirect_to user_plan_path(@guide, @plan), alert: "Somethig went wrong"
    end
  end
  
  private
  def requests_params
    params.permit(:guide_id, :plan_id)
  end
   
  # def verify_tourist
  #   if current_user.guide
  #     redirect_to root_path, notice: "ガイド登録者は申し込みができません。"
  #   end
  # end
end
