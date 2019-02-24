class PlansController < ApplicationController
  
  def index
      @user = User.find(params[:user_id])
      @plans = @user.plans.all
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
    redirect_to(user_plans_path(@user.id))
  end
  
  def create
    @user = User.find(params[:user_id])
    @plan = @user.plans.build(plan_params)
    if @plan.save
      flash[:success] = "The new plan was created"
      redirect_to(user_plans_path(@user.id))
    else
      render(new_user_plan_path(@user.id, @plan.id))
    end
  end
  
  def update
    @user = User.find(params[:user_id])
    @plan = @user.plans.find_by(id: params[:id])
    if @plan.update_attributes(plan_params)
      flash[:success] = "Plan was edited successfully"
      redirect_to(user_plans_path(@user.id))
    else
      render(edit_user_plan_path(@user.id, @plan.id))
    end
  end
  
  private

    def plan_params
      params.require(:plan).permit(:content)
    end
  
  
end
