class RequestsController < ApplicationController
  
  def create
    @guide = User.find(params[:guide_id])
    @plan = Plan.find(params[:plan_id])
    @request = current_user.active_requests.build(requests_params)
    if @request.save
      ApplicationApprovalMailer.send_confirm_to_user(@guide, @request).deliver
      redirect_to user_plan_path(@guide, @plan), notice: "Thank you for applying! The request mail was successfully sent to the guide!"
    else
      redirect_to user_plan_path(@guide, @plan), alert: "Somethig went wrong"
    end
  end
  
  def edit
    @request = Request.find(params[:id])
    @tourist = @request.tourist
    @request.update_attributes(approved: true)
    redirect_to room_path(@tourist.id), notice: "承認が完了しました！チャットを始めましょう！"
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
