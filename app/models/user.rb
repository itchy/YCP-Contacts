class User < ActiveRecord::Base
  has_one :profile, :dependent => :destroy
  
  has_secure_password
  validates :email, :format => { :with => /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\Z/i, :on => :create }
  validates :email, :uniqueness => true 
  validates :login, :uniqueness => true 
  validates :password, :presence => true, :on => :create
  validates :password_confirmation, :presence => true, :on => :create
  
  scope :active, where('active > 0')
  
  after_create :create_profile
  
  def initialize(*args)
    super # be sure to create ActiveRecord::Base before setting values to it
    random ="random"
    self.active= 1
    self.active_until= (Time.now + (60 * 60 * 24 * 365)).strftime("%F")
    self.password= random
    self.password_confirmation= random
  end
  
  def create_profile
    puts "********************************************************\nI GET CALLED!\n********************************************************\n"
    puts self.inspect
    tmp_profile = Profile.new(:user_id => self.id)
    tmp_profile.save!
  end
  
  def admin?
    true if self.roles[/9/] == "9" 
  end

  def active?
    true if self.active > 0
  end

end
