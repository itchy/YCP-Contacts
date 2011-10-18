class Profile < ActiveRecord::Base
  belongs_to :user, :dependent => :destroy
  default_scope joins(:user).where('active > 0').order("last_name").order("first_name")
  
  # validates :screen_name, :presence => true, :on => :create
  self.per_page = 10
  
  def admin?
    user.roles[/9/]
  end
  
  
  # cause sometimes I try to access user attributes from profile
  def method_missing(method, *args)
    return user.send method.to_sym if args.size == 0 && user.respond_to?(method)
    super
  end
  
  class << self
    def search(args={})
      profiles = Profile
      args.each_pair do |key, value|      
        profiles = profiles.where("#{key} like ?", "%#{value}%") 
      end
      profiles  
    end
  end
end
