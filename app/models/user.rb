class User < ActiveRecord::Base
  has_one :profile, :dependent => :destroy  
  has_secure_password
  
  validates :email, :format => { :with => /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\Z/i }
  validates :email, :uniqueness => true 
  validates :email, :presence => true 
  validates :login, :uniqueness => true 
  validates :password, :presence => { :on => :create }
  
  scope :active,  lambda { where("active > 0 AND active_until > ? ", Time.now().strftime("%F") ).order("email") }
  
  after_create :create_profile, :send_welcome_email
  
  def initialize(*args)
    super # be sure to create ActiveRecord::Base before setting values to it
    self.active= 1
    self.active_until= (Time.now + (60 * 60 * 24 * 365)).strftime("%F")
  end
  
  def create_profile
    tmp_profile = Profile.new(:user_id => self.id)
    tmp_profile.save!
  end
  
  def send_welcome_email
    tmail = Notifier.welcome_new_member(self).deliver
    # render(:text => tmail)
  end
  
  def send_admin_message(subject, message)
    tmail = Notifier.send_member_admin_message(self, subject="A message from the YCP system admin", message).deliver
  end
  
  def admin?
    true if self.roles[/9/] == "9" 
  end

  def active?
    true if self.active > 0
  end
  
  def account_expired?
    self.active_until < Date.parse(Time.now.strftime("%F"))
    
  end

  def account_about_to_expire?
    self.active_until - 30 < Date.parse(Time.now.strftime("%F"))
  end

end
