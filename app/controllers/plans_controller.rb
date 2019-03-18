class PlansController < ApplicationController

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
    flash[:success] = "The plan was destoyed successfully"
    redirect_to plans_path
  end

  def create
    @user = User.find(params[:user_id])
    @plan = @user.plans.build(plan_params)
    if @plan.save
      flash[:success] = "The new plan was created"
      redirect_to plans_path
    else
      render 'new'
    end
  end

  def update
    @user = User.find(params[:user_id])
    @plan = @user.plans.find_by(id: params[:id])
    if @plan.update_attributes(plan_params)
      flash[:success] = "Plan was edited successfully"
      redirect_to plans_path
    else
      render(edit_user_plan_path(@user.id, @plan.id))
    end
  end

  private

    def plan_params
      params.require(:plan).permit(:content, :name, :tag, :image)
    end

end
