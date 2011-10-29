class Admin::UsersController < ApplicationController
  before_filter :admin_only, :set_selected_tab, :authenticate
  # before_filter :identify
  
  def index
    @users = User.unscoped.order(:email)
  end
  
  def show
    
  end
  
  def new
    @user = User.new
  end
  
  def create
    @user = User.new(params[:user])
    # set default password unless one is provided
    if @user.password.blank? && @user.password_confirmation.blank?
      @user.password, @user.password_confirmation = "password", "password"
    end  
    if @user.save
      flash[:notice] = "User Created!"
      redirect_to :action => 'index'
    else
      render :action => 'new'
    end    
  end
  
  def edit
    @user = User.find_by_id(params[:id])
  end
  
  def update
    @user = User.find_by_id(params[:id])
    @user.update_attributes(params[:user])
    if @user.save
      flash[:notice] = "User Updated!"
      redirect_to :action => 'index'
    else
      render :action => 'edit'
    end
  end
  
  def destroy
    user = User.find_by_id(params[:id])
    user.active = -1
    user.save
    flash[:notice] = "User #{user.profile.screen_name} destroyed!"
    redirect_to :controller => 'Admin::Users', :action => 'index'
  end
  
private
  def set_selected_tab
    @users_tab_selected ="selected"
  end
  
end
