class Profile < ActiveRecord::Base
  belongs_to :user, :dependent => :destroy
  # validates :screen_name, :presence => true, :on => :create
  
end
