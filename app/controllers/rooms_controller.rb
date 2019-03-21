class RoomsController < ApplicationController
  before_action :chatting, only: :show

  def show
    @user = User.find(params[:id])
    @room_id = message_room_id(current_user, @user)
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
      puts "aaaaa" * 100
      if user.guide == current_user.guide
        redirect_to root_path, alert: "このユーザーとはチャットできません"
      end
    end
end
