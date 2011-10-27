class Profile < ActiveRecord::Base
  belongs_to :user, :dependent => :destroy
  delegate :email, :to => :user
  scope :active,  lambda { joins(:user).where("active > 0 AND active_until > ? ", Time.now().strftime("%F") ).order("last_name").order("first_name") }
  self.per_page = 10
  validates :user_id, :uniqueness => true
  
  before_save :set_screen_name
  
  
  
  def admin?
    user.roles[/9/]
  end
  
  def editor?
    user.roles[/7/]
  end
  
  def set_screen_name
    self.screen_name = "#{self.first_name} #{self.last_name}"
  end
  
  def complete?
    required_attributes = [:first_name, :last_name]
    required_attributes.each do |attribute|
      if self.send(attribute).blank?
        return false
      end
    end     
  end
  
  class << self
    def search(args={})
      profiles = Profile
      args.each_pair do |key, value|      
        profiles = profiles.where("LOWER(#{key}) like ?", "%#{value.downcase}%") 
      end
      profiles  
    end
  end
end
