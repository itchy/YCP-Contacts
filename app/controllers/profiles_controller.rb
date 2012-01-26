class ProfilesController < ApplicationController
  before_filter :authenticate#, :identify
  before_filter :set_profile, :except => [:index, :show]
  # before_filter :admin_only, :only => [:new, :create, :destroy] -- done in user
  
  def index
    if params[:profile]
      # set search criterial
      @search_profile = Profile.new(params[:profile])
      # @profiles = Profile.where("first_name = 'Scott'").page(params[:page])
      @profiles = Profile.search(params[:profile]).page(params[:page])
    else  
      @search_profile = Profile.new
      @profiles = Profile.page(params[:page])
    end  

  end
  
  def show
    @profile = Profile.find(params[:id])
  end
  
  def new
    # this is done by user.create
    render :action => show
  end
  
  def create
    # this is done by user.create
    render :action => show
  end
  
  def edit
    # set @profile in before_filter and render default view
  end
  
  def update
    @profile.update_attributes(params[:profile])
    user = @profile.user
    user.email=params[:user][:email]
    if @profile.save && user.save
      flash[:notice] = "Profile Updated!"
      render :action => 'show'
    else
      render :action => 'edit'  
    end
  end
  
  def destroy
    # user = @profile.user
    # user.active = -1
    # user.save
    render :action => show
  end

private
  # only let admins edit other users
  def set_profile
    if current_user.admin? && params[:id]
      @profile = Profile.find_by_id(params[:id])
    else
      @profile = current_user.profile  
    end  
  end

end
