class ProfilesController < ApplicationController
  before_filter :authenticate 
  before_filter :set_profile, :except => [:index, :new]
  before_filter :admin_only, :only => [:new, :create, :destroy]
  
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
    @profile
  end
  
  def new
    user = User.find_by_id(params[:user])
    @profile = user.profile.new
  end
  
  def create
    if @profile.save
      # 
    else
      #   
    end  
  end
  
  def edit
    
  end
  
  def update
    @profile.update_attributes(params[:profile])
    if @profile.save
      #
    else
      #
    end
  end
  
  def destroy
    user = @profile.user
    user.active = -1
    user.save
  end

private
  # only let admins edit other users
  def set_profile
    if current_user.admin? && (params[:profile_id] || params[:profile])
      id = params[:profile_id] || params[:profile][:id]
      Profile.find_by_id(id)
    else
      @profile = current_user.profile  
    end  
  end
  
  def admin_only
    unless current_user.admin?
      flash[:notice] = "You must be an admin to preform this action!"
      redirect_to profiles_path 
      return 
    end  
  end
  
end
