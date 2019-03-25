class RoomsController < ApplicationController
  before_action :authenticate_user!
  before_action :chatting, only: :show
  before_action :chat_restrict, only: :show

  def show
    @user = User.find(params[:id])
    @room_id = message_room_id(current_user, @user)
    if current_user.guide # 旅行者のとき
      @requests = current_user.active_requests.where(approved: true)
    else  # ガイドのとき
      @requests = current_user.passive_requests.where(approved: true)
    end
    @messages = Message.recent_in_room(@room_id)
  end

  def message_room_id(first_user, second_user)
    first_id = first_user.id.to_i
    second_id = second_user.id.to_i
    if first_id < second_id
      "#{first_user.id}-#{second_user.id}"
    else
      "#{second_user.id}-#{first_user.id}"
    end
  end

  private

    def chatting
      user = User.find(params[:id])
      if user.guide == current_user.guide
        redirect_to root_path, alert: "このユーザーとはチャットできません"
      end
    end

    def chat_restrict
      user = User.find(params[:id])
      if current_user.guide # 旅行者のとき
        request = current_user.active_requests.find_by(guide_id: user.id)
      else  # ガイドのとき
        request = current_user.passive_requests.find_by(tourist_id: user.id)
      end
      if request.nil?
        redirect_to root_path, alert: "プランを申し込むか承認してください"
      end
    end
end
