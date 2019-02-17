class PlansController < ApplicationController
  
  def index
      @user = User.find(params[:user_id])
      @plans = @user.plans
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
      @plan = @user.plan.find(id: params[:id])
  end
  
  def destoy
    @user = User.find(params[:user_id])
    @plan = @user.plan.find(params[:id])
    @plan.destroy
    flash[:success] = "The plan was destoyed successfully"
    redirect_to("/plans/index")
  end
  
  def create
    @user = User.find(params[:user_id])
    @plan = @user.plans.build(plan_params)
    if @plan.save
      flash[:success] = "The new plan was created"
      redirect_to("/plans/index")
    else
      render("plans/new")
    end
  end
  
  def update
    @user = User.find(params[:user_id])
    @plan = @user.plans.find_by(id: params[:id])
    if @plan.save
      flash[:success] = "Plan was edited successfully"
      redirect_to("/plans/index")
    else
      render("plans/edit")
    end
  end
  
  private

    def plan_params
      params.require(:plan).permit(:content)
    end
  
  
end
