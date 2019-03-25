class UsersController < ApplicationController
  before_action :authenticate_user!, only: [:show]

  def index
    # @users = User.all.reject { |user| user.guide }
    @users = User.guides.paginate(page: params[:page])
  end

  def show
    @user = User.find(params[:id])
  end

  # def new
  #    @user = User.new
  # end
  #
  # def create
  #   @user = User.new(user_params)
  #   if @user.save
  #     log_in @user
  #     flash[:success] = "Welcome to the Sample App!"
  #     redirect_to @user
  #   else
  #     render 'new'
  #   end
  # end

  # def edit
  #   @user = current_user
  # end
  #
  # def update
  #   @user = current_user
  #   if @user.update_attributes(update_params)
  #     flash[:success] = "Profile updated"
  #     redirect_to @user
  #   else
  #     render 'edit'
  #   end
  # end

  def profile_edit
    @user = current_user
  end

  def profile_update
    @user = current_user
    if current_user.update_attributes(profile_params)
      redirect_to user_path(@user.id), notice: 'プロフィールを更新しました'
    else
      render "profile_edit"
    end
  end

  private

    def user_params
      params.require(:user).permit(:name, :email, :password,
                                   :password_confirmation)
    end

    def update_params
      params.require(:user).permit(:name, :number, :email)
    end

    def profile_params
      params.require(:user).permit(:name, :university, :major, :hometown, :hobby, :detail, :picture)
    end
end
