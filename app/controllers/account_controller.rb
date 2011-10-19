class AccountController < ApplicationController
  before_filter :set_instance_user
  
  def show
    # set @current_user in before_filter and render default view
  end
  
  def edit
    # set @current_user in before_filter and render default view
  end
  
  def update
    @current_user.update_attributes(params[:user])
    if @current_user.save 
      flash[:notice] = "Account Updated!"
      render :action => 'show'
    else
      render :action => 'edit'  
    end
  end
  
private
  def set_instance_user
    @current_user = current_user
  end
  
end
