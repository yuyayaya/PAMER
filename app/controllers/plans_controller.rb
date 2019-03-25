class PlansController < ApplicationController
  before_action :authenticate_user!, only: [:new, :show, :edit, :destroy, :create, :update]

  def index
    @user = User.find(params[:user_id])
    @plans = @user.plans.all
  end

  def plan_index
    @user = current_user
    if params[:search].present?
      @plans = Plan.search(params[:search]).paginate(page: params[:page])
    else
      @plans = Plan.paginate(page: params[:page])
    end
  end

  def show
    @user = User.find(params[:user_id])
    @plan = @user.plans.find(params[:id])
    @like = Like.new
    @comments = @plan.comments
    @comment = Comment.new
  end

  def new
    @user = User.find(params[:user_id])
    @plan = @user.plans.build
  end

  def edit
    @user = User.find(params[:user_id])
    @plan = @user.plans.find(params[:id])
  end

  def destroy
    @user = User.find(params[:user_id])
    @plan = @user.plans.find(params[:id])
    @plan.destroy
    redirect_to plans_path, notice: "The plan was destoyed successfully"
  end

  def create
    @user = User.find(params[:user_id])
    @plan = @user.plans.build(plan_params)
    if @plan.save
      redirect_to plans_path, notice: "The new plan was created"
    else
      render 'new'
    end
  end

  def update
    @user = User.find(params[:user_id])
    @plan = @user.plans.find_by(id: params[:id])
    if @plan.update_attributes(plan_params)
      redirect_to plans_path, notice: "Plan was edited successfully"
    else
      render 'edit'
    end
  end

  private

    def plan_params
      params.require(:plan).permit(:content, :name, :tag, :image)
    end

end
