class Profile < ActiveRecord::Base
  belongs_to :user, :dependent => :destroy
  delegate :email, :to => :user
  default_scope lambda { joins(:user).where("active > 0 AND active_until > ? ", Time.now().strftime("%F") ).order("last_name").order("first_name") }
  self.per_page = 10
  validates :user_id, :uniqueness => true
  
  def admin?
    user.roles[/9/]
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
